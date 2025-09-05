-- =====================================================
-- ANÁLISIS DE CÓDIGOS POSTALES PROBLEMÁTICOS
-- =====================================================
USE codigopostal;

DELIMITER $$

DROP PROCEDURE IF EXISTS AnalizarCodigosPostales$$

CREATE PROCEDURE AnalizarCodigosPostales()
BEGIN
    -- Ver códigos postales con más de 5 caracteres
    SELECT 'Códigos postales con más de 5 caracteres:' AS analisis;
    SELECT 
        d_codigo,
        LENGTH(d_codigo) as longitud,
        LENGTH(TRIM(d_codigo)) as longitud_sin_espacios,
        COUNT(*) as registros
    FROM sepomex.sepomex
    WHERE LENGTH(TRIM(d_codigo)) > 5
    GROUP BY d_codigo
    ORDER BY LENGTH(d_codigo) DESC
    LIMIT 20;
    
    -- Ver estadísticas de longitudes
    SELECT 'Distribución de longitudes de códigos postales:' AS analisis;
    SELECT 
        LENGTH(TRIM(d_codigo)) as longitud,
        COUNT(*) as cantidad
    FROM sepomex.sepomex
    WHERE d_codigo IS NOT NULL
    GROUP BY LENGTH(TRIM(d_codigo))
    ORDER BY longitud;
    
    -- Ver ejemplos de registros problemáticos
    SELECT 'Ejemplos de registros con códigos largos:' AS analisis;
    SELECT 
        id_asenta_cpcons,
        d_codigo,
        d_asenta,
        d_mnpio,
        d_estado
    FROM sepomex.sepomex
    WHERE LENGTH(TRIM(d_codigo)) > 5
    LIMIT 10;
    
    -- Verificar si hay caracteres especiales
    SELECT 'Códigos con caracteres no numéricos:' AS analisis;
    SELECT 
        d_codigo,
        COUNT(*) as registros
    FROM sepomex.sepomex
    WHERE d_codigo REGEXP '[^0-9]'
        AND d_codigo IS NOT NULL
    GROUP BY d_codigo
    LIMIT 20;
END$$

DELIMITER ;

-- =====================================================
-- SOLUCIÓN: MODIFICAR ESQUEMA Y LIMPIAR DATOS
-- =====================================================

-- Opción 1: Aumentar el tamaño de la columna
ALTER TABLE Asentamientos MODIFY COLUMN d_codigo VARCHAR(10) NOT NULL;
ALTER TABLE OficinasPostales MODIFY COLUMN d_CP VARCHAR(10) NOT NULL;

-- =====================================================
-- PROCEDIMIENTO DE MIGRACIÓN CON LIMPIEZA DE DATOS
-- =====================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS MigrarSepomexLimpio$$

CREATE PROCEDURE MigrarSepomexLimpio()
BEGIN
    DECLARE v_error_msg TEXT;
    DECLARE v_error_code INT;
    
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_code = MYSQL_ERRNO,
            v_error_msg = MESSAGE_TEXT;
        
        ROLLBACK;
        SELECT CONCAT('Error ', v_error_code, ': ', v_error_msg) AS mensaje_error;
    END;
    
    START TRANSACTION;
    
    -- Limpiar tablas
    DELETE FROM AsentamientoOficina;
    DELETE FROM OficinasPostales;
    DELETE FROM Asentamientos;
    DELETE FROM TiposAsentamiento;
    DELETE FROM Ciudades;
    DELETE FROM Municipios;
    DELETE FROM Estados;
    
    -- 1. Migrar Estados
    INSERT INTO Estados (c_estado, d_estado)
    SELECT DISTINCT 
        c_estado,
        TRIM(d_estado)
    FROM sepomex.sepomex
    WHERE c_estado IS NOT NULL 
        AND d_estado IS NOT NULL
        AND c_estado > 0;
    
    SELECT CONCAT('Estados migrados: ', ROW_COUNT()) AS resultado;
    
    -- 2. Migrar Municipios
    INSERT INTO Municipios (c_mnpio, c_estado, d_mnpio)
    SELECT DISTINCT 
        c_mnpio,
        c_estado,
        TRIM(d_mnpio)
    FROM sepomex.sepomex
    WHERE c_mnpio IS NOT NULL 
        AND c_estado IS NOT NULL 
        AND d_mnpio IS NOT NULL
        AND c_mnpio > 0
        AND c_estado > 0;
    
    SELECT CONCAT('Municipios migrados: ', ROW_COUNT()) AS resultado;
    
    -- 3. Migrar Ciudades
    INSERT IGNORE INTO Ciudades (c_cve_ciudad, d_ciudad, c_estado)
    SELECT DISTINCT 
        c_cve_ciudad,
        TRIM(d_ciudad),
        c_estado
    FROM sepomex.sepomex
    WHERE c_cve_ciudad IS NOT NULL 
        AND d_ciudad IS NOT NULL 
        AND c_estado IS NOT NULL
        AND c_cve_ciudad > 0
        AND TRIM(d_ciudad) != '';
    
    SELECT CONCAT('Ciudades migradas: ', ROW_COUNT()) AS resultado;
    
    -- 4. Migrar Tipos de Asentamiento
    INSERT INTO TiposAsentamiento (c_tipo_asenta, d_tipo_asenta)
    SELECT DISTINCT 
        c_tipo_asenta,
        TRIM(d_tipo_asenta)
    FROM sepomex.sepomex
    WHERE c_tipo_asenta IS NOT NULL 
        AND d_tipo_asenta IS NOT NULL
        AND c_tipo_asenta > 0;
    
    SELECT CONCAT('Tipos de asentamiento migrados: ', ROW_COUNT()) AS resultado;
    
    -- 5. Crear tabla temporal con datos limpios y IDs únicos
    DROP TEMPORARY TABLE IF EXISTS temp_asentamientos;
    
    CREATE TEMPORARY TABLE temp_asentamientos AS
    SELECT 
        ROW_NUMBER() OVER (ORDER BY d_codigo, c_mnpio, d_asenta) AS nuevo_id,
        id_asenta_cpcons AS id_original,
        TRIM(d_asenta) AS d_asenta,
        -- Limpiar y validar código postal
        CASE 
            WHEN LENGTH(TRIM(d_codigo)) <= 5 THEN TRIM(d_codigo)
            WHEN d_codigo REGEXP '^[0-9]{5}' THEN SUBSTRING(TRIM(d_codigo), 1, 5)
            ELSE LPAD(SUBSTRING(REGEXP_REPLACE(d_codigo, '[^0-9]', ''), 1, 5), 5, '0')
        END AS d_codigo,
        CASE 
            WHEN UPPER(TRIM(d_zona)) LIKE '%URBAN%' THEN 'Urbano'
            WHEN UPPER(TRIM(d_zona)) = 'RURAL' THEN 'Rural'
            ELSE 'Urbano'
        END AS d_zona,
        c_tipo_asenta,
        c_mnpio,
        c_oficina,
        -- CP original para oficinas
        CASE 
            WHEN LENGTH(TRIM(d_cp)) <= 5 THEN TRIM(d_cp)
            WHEN d_cp REGEXP '^[0-9]{5}' THEN SUBSTRING(TRIM(d_cp), 1, 5)
            ELSE LPAD(SUBSTRING(REGEXP_REPLACE(d_cp, '[^0-9]', ''), 1, 5), 5, '0')
        END AS d_cp_limpio,
        c_cve_ciudad
    FROM sepomex.sepomex s
    WHERE d_asenta IS NOT NULL 
        AND d_codigo IS NOT NULL
        AND c_tipo_asenta IS NOT NULL
        AND c_mnpio IS NOT NULL
        AND TRIM(d_asenta) != ''
        AND TRIM(d_codigo) != '';
    
    -- 6. Insertar asentamientos con datos limpios
    INSERT INTO Asentamientos (
        id_asenta_cpcons, 
        d_asenta, 
        d_codigo, 
        d_zona, 
        c_tipo_asenta, 
        c_mnpio
    )
    SELECT DISTINCT
        nuevo_id,
        d_asenta,
        d_codigo,
        d_zona,
        c_tipo_asenta,
        c_mnpio
    FROM temp_asentamientos
    WHERE LENGTH(d_codigo) <= 10;  -- Asegurar que cumpla con el nuevo límite
    
    SELECT CONCAT('Asentamientos migrados: ', ROW_COUNT()) AS resultado;
    
    -- 7. Migrar Oficinas Postales con códigos limpios
    INSERT IGNORE INTO OficinasPostales (c_oficina, d_CP, c_cve_ciudad)
    SELECT DISTINCT 
        c_oficina,
        d_cp_limpio,
        c_cve_ciudad
    FROM temp_asentamientos t
    WHERE c_oficina IS NOT NULL 
        AND d_cp_limpio IS NOT NULL 
        AND c_cve_ciudad IS NOT NULL
        AND c_oficina > 0
        AND d_cp_limpio != ''
        AND LENGTH(d_cp_limpio) <= 10
        AND EXISTS (SELECT 1 FROM Ciudades c WHERE c.c_cve_ciudad = t.c_cve_ciudad);
    
    SELECT CONCAT('Oficinas postales migradas: ', ROW_COUNT()) AS resultado;
    
    -- 8. Migrar relación
    INSERT IGNORE INTO AsentamientoOficina (id_asenta_cpcons, c_oficina)
    SELECT DISTINCT 
        t.nuevo_id,
        t.c_oficina
    FROM temp_asentamientos t
    WHERE t.c_oficina IS NOT NULL
        AND EXISTS (SELECT 1 FROM OficinasPostales o WHERE o.c_oficina = t.c_oficina);
    
    SELECT CONCAT('Relaciones Asentamiento-Oficina migradas: ', ROW_COUNT()) AS resultado;
    
    -- Mostrar estadísticas de limpieza
    SELECT 'Estadísticas de limpieza de códigos:' AS info;
    SELECT 
        COUNT(*) as total_registros,
        SUM(CASE WHEN LENGTH(d_codigo) = 5 THEN 1 ELSE 0 END) as codigos_correctos,
        SUM(CASE WHEN LENGTH(d_codigo) < 5 THEN 1 ELSE 0 END) as codigos_cortos,
        SUM(CASE WHEN LENGTH(d_codigo) > 5 THEN 1 ELSE 0 END) as codigos_largos
    FROM temp_asentamientos;
    
    -- Limpiar tabla temporal
    DROP TEMPORARY TABLE IF EXISTS temp_asentamientos;
    
    COMMIT;
    
    SELECT 'Migración completada exitosamente!' AS mensaje;
    
END$$

DELIMITER ;

-- =====================================================
-- INSTRUCCIONES DE USO
-- =====================================================
-- 1. Primero analizar el problema:
--    CALL AnalizarCodigosPostales();
--
-- 2. Modificar el esquema para permitir códigos más largos:
--    ALTER TABLE Asentamientos MODIFY COLUMN d_codigo VARCHAR(10) NOT NULL;
--    ALTER TABLE OficinasPostales MODIFY COLUMN d_CP VARCHAR(10) NOT NULL;
--
-- 3. Ejecutar la migración con limpieza:
--    CALL MigrarSepomexLimpio();
--
-- 4. Verificar resultados:
--    CALL VerificarMigracion();