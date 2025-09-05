DELIMITER $$

CREATE PROCEDURE MigrarSepomexACodigoPostal()
BEGIN
    -- Declarar variables para manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback en caso de error
        ROLLBACK;
        SELECT 'Error durante la migración. Se ha revertido la transacción.' AS mensaje;
    END;
    
    -- Iniciar transacción
    START TRANSACTION;
    
    -- Limpiar tablas destino (opcional, comentar si se quiere preservar datos existentes)
    DELETE FROM codigopostal.AsentamientoOficina;
    DELETE FROM codigopostal.OficinasPostales;
    DELETE FROM codigopostal.Asentamientos;
    DELETE FROM codigopostal.TiposAsentamiento;
    DELETE FROM codigopostal.Ciudades;
    DELETE FROM codigopostal.Municipios;
    DELETE FROM codigopostal.Estados;
    
    -- 1. Migrar Estados
    INSERT INTO codigopostal.Estados (c_estado, d_estado)
    SELECT DISTINCT 
        c_estado,
        d_estado
    FROM sepomex.sepomex
    WHERE c_estado IS NOT NULL 
        AND d_estado IS NOT NULL
        AND c_estado > 0
    ORDER BY c_estado;
    
    SELECT 'Estados migrados: ', ROW_COUNT() AS registros;
    
    -- 2. Migrar Municipios
    INSERT INTO codigopostal.Municipios (c_mnpio, c_estado, d_mnpio)
    SELECT DISTINCT 
        c_mnpio,
        c_estado,
        d_mnpio
    FROM sepomex.sepomex
    WHERE c_mnpio IS NOT NULL 
        AND c_estado IS NOT NULL 
        AND d_mnpio IS NOT NULL
        AND c_mnpio > 0
        AND c_estado > 0
    ORDER BY c_estado, c_mnpio;
    
    SELECT 'Municipios migrados: ', ROW_COUNT() AS registros;
    
    -- 3. Migrar Ciudades
    INSERT INTO codigopostal.Ciudades (c_cve_ciudad, d_ciudad, c_estado)
    SELECT DISTINCT 
        c_cve_ciudad,
        d_ciudad,
        c_estado
    FROM sepomex.sepomex
    WHERE c_cve_ciudad IS NOT NULL 
        AND d_ciudad IS NOT NULL 
        AND c_estado IS NOT NULL
        AND c_cve_ciudad > 0
        AND c_estado > 0
        AND d_ciudad != ''
    ORDER BY c_cve_ciudad;
    
    SELECT 'Ciudades migradas: ', ROW_COUNT() AS registros;
    
    -- 4. Migrar Tipos de Asentamiento
    INSERT INTO codigopostal.TiposAsentamiento (c_tipo_asenta, d_tipo_asenta)
    SELECT DISTINCT 
        c_tipo_asenta,
        d_tipo_asenta
    FROM sepomex.sepomex
    WHERE c_tipo_asenta IS NOT NULL 
        AND d_tipo_asenta IS NOT NULL
        AND c_tipo_asenta > 0
    ORDER BY c_tipo_asenta;
    
    SELECT 'Tipos de asentamiento migrados: ', ROW_COUNT() AS registros;
    
    -- 5. Migrar Asentamientos
    INSERT INTO codigopostal.Asentamientos (
        id_asenta_cpcons, 
        d_asenta, 
        d_codigo, 
        d_zona, 
        c_tipo_asenta, 
        c_mnpio
    )
    SELECT DISTINCT 
        id_asenta_cpcons,
        d_asenta,
        d_codigo,
        CASE 
            WHEN UPPER(d_zona) = 'URBANO' THEN 'Urbano'
            WHEN UPPER(d_zona) = 'RURAL' THEN 'Rural'
            ELSE 'Urbano' -- Default
        END AS d_zona,
        c_tipo_asenta,
        c_mnpio
    FROM sepomex.sepomex
    WHERE id_asenta_cpcons IS NOT NULL 
        AND d_asenta IS NOT NULL 
        AND d_codigo IS NOT NULL
        AND c_tipo_asenta IS NOT NULL
        AND c_mnpio IS NOT NULL
        AND id_asenta_cpcons > 0
        AND c_tipo_asenta > 0
        AND c_mnpio > 0
    ORDER BY id_asenta_cpcons;
    
    SELECT 'Asentamientos migrados: ', ROW_COUNT() AS registros;
    
    -- 6. Migrar Oficinas Postales
    -- Primero, insertar las oficinas únicas
    INSERT INTO codigopostal.OficinasPostales (c_oficina, d_CP, c_cve_ciudad)
    SELECT DISTINCT 
        c_oficina,
        d_cp,
        c_cve_ciudad
    FROM sepomex.sepomex
    WHERE c_oficina IS NOT NULL 
        AND d_cp IS NOT NULL 
        AND c_cve_ciudad IS NOT NULL
        AND c_oficina > 0
        AND c_cve_ciudad > 0
        AND d_cp != ''
    ORDER BY c_oficina;
    
    SELECT 'Oficinas postales migradas: ', ROW_COUNT() AS registros;
    
    -- 7. Migrar relación Asentamiento-Oficina
    INSERT INTO codigopostal.AsentamientoOficina (id_asenta_cpcons, c_oficina)
    SELECT DISTINCT 
        id_asenta_cpcons,
        c_oficina
    FROM sepomex.sepomex
    WHERE id_asenta_cpcons IS NOT NULL 
        AND c_oficina IS NOT NULL
        AND id_asenta_cpcons > 0
        AND c_oficina > 0
    ORDER BY id_asenta_cpcons, c_oficina;
    
    SELECT 'Relaciones Asentamiento-Oficina migradas: ', ROW_COUNT() AS registros;
    
    -- Confirmar transacción
    COMMIT;
    
    SELECT 'Migración completada exitosamente' AS mensaje;
    
END$$

DELIMITER ;

-- Procedimiento auxiliar para verificar la migración
DELIMITER $$

CREATE PROCEDURE VerificarMigracion()
BEGIN
    SELECT 'Estados:' AS tabla, COUNT(*) AS registros FROM codigopostal.Estados
    UNION ALL
    SELECT 'Municipios:', COUNT(*) FROM codigopostal.Municipios
    UNION ALL
    SELECT 'Ciudades:', COUNT(*) FROM codigopostal.Ciudades
    UNION ALL
    SELECT 'Tipos Asentamiento:', COUNT(*) FROM codigopostal.TiposAsentamiento
    UNION ALL
    SELECT 'Asentamientos:', COUNT(*) FROM codigopostal.Asentamientos
    UNION ALL
    SELECT 'Oficinas Postales:', COUNT(*) FROM codigopostal.OficinasPostales
    UNION ALL
    SELECT 'Asentamiento-Oficina:', COUNT(*) FROM codigopostal.AsentamientoOficina;
END$$

DELIMITER ;

-- Para ejecutar la migración:
-- CALL MigrarSepomexACodigoPostal();

-- Para verificar los resultados:
-- CALL VerificarMigracion();