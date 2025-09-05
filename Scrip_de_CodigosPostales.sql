CREATE DEFINER=`root`@`localhost` PROCEDURE `codigopostal`.`AnalizarCodigosPostales`()
BEGIN
    
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
    
    
    SELECT 'Distribución de longitudes de códigos postales:' AS analisis;
    SELECT 
        LENGTH(TRIM(d_codigo)) as longitud,
        COUNT(*) as cantidad
    FROM sepomex.sepomex
    WHERE d_codigo IS NOT NULL
    GROUP BY LENGTH(TRIM(d_codigo))
    ORDER BY longitud;
    
    
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
    
    
    SELECT 'Códigos con caracteres no numéricos:' AS analisis;
    SELECT 
        d_codigo,
        COUNT(*) as registros
    FROM sepomex.sepomex
    WHERE d_codigo REGEXP '[^0-9]'
        AND d_codigo IS NOT NULL
    GROUP BY d_codigo
    LIMIT 20;
END

-------------------------------------------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `codigopostal`.`AnalizarDuplicados`()
BEGIN
    
    SELECT 'Asentamientos con código postal 01030 en municipio 10:' AS analisis;
    SELECT 
        id_asenta_cpcons,
        d_codigo,
        d_asenta,
        c_mnpio,
        d_mnpio,
        c_tipo_asenta,
        d_tipo_asenta
    FROM sepomex.sepomex
    WHERE d_codigo = '01030' AND c_mnpio = 10;
    
    
    SELECT 'Top 10 combinaciones duplicadas de código postal + municipio:' AS analisis;
    SELECT 
        d_codigo,
        c_mnpio,
        d_mnpio,
        COUNT(*) as total_asentamientos,
        GROUP_CONCAT(DISTINCT d_asenta ORDER BY d_asenta SEPARATOR ' | ') as asentamientos
    FROM sepomex.sepomex
    WHERE d_codigo IS NOT NULL AND c_mnpio IS NOT NULL
    GROUP BY d_codigo, c_mnpio
    HAVING COUNT(*) > 1
    ORDER BY COUNT(*) DESC
    LIMIT 10;
    
    
    SELECT 'Total de combinaciones código-municipio duplicadas:' AS analisis;
    SELECT COUNT(*) as total_duplicados
    FROM (
        SELECT d_codigo, c_mnpio
        FROM sepomex.sepomex
        WHERE d_codigo IS NOT NULL AND c_mnpio IS NOT NULL
        GROUP BY d_codigo, c_mnpio
        HAVING COUNT(*) > 1
    ) t;
END
-----------------------------------------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `codigopostal`.`AnalizarIDsDuplicados`()
BEGIN
    
    SELECT 'Total de id_asenta_cpcons duplicados:' AS analisis;
    SELECT COUNT(*) as total_ids_duplicados
    FROM (
        SELECT id_asenta_cpcons, COUNT(*) as veces
        FROM sepomex.sepomex
        WHERE id_asenta_cpcons IS NOT NULL
        GROUP BY id_asenta_cpcons
        HAVING COUNT(*) > 1
    ) t;
    
    
    SELECT 'Primeros 10 id_asenta_cpcons duplicados:' AS analisis;
    SELECT 
        id_asenta_cpcons,
        COUNT(*) as veces_repetido,
        GROUP_CONCAT(DISTINCT CONCAT(d_codigo, ' - ', d_asenta) SEPARATOR ' | ') as asentamientos
    FROM sepomex.sepomex
    WHERE id_asenta_cpcons IS NOT NULL
    GROUP BY id_asenta_cpcons
    HAVING COUNT(*) > 1
    ORDER BY id_asenta_cpcons
    LIMIT 10;
    
    
    SELECT 'Registros con id_asenta_cpcons = 1:' AS analisis;
    SELECT 
        id_asenta_cpcons,
        d_codigo,
        d_asenta,
        d_mnpio,
        c_mnpio,
        d_estado,
        c_estado
    FROM sepomex.sepomex
    WHERE id_asenta_cpcons = 1;
    
    
    SELECT 'Análisis de patrones en IDs:' AS analisis;
    SELECT 
        MIN(id_asenta_cpcons) as id_minimo,
        MAX(id_asenta_cpcons) as id_maximo,
        COUNT(DISTINCT id_asenta_cpcons) as ids_unicos,
        COUNT(*) as total_registros
    FROM sepomex.sepomex
    WHERE id_asenta_cpcons IS NOT NULL;
END
------------------------------------------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `codigopostal`.`BuscarColoniasPorNombre`(
    IN p_nombre VARCHAR(100),
    IN p_estado VARCHAR(100)
)
BEGIN
    SELECT 
        a.d_codigo AS codigo_postal,
        a.d_asenta AS colonia,
        ta.d_tipo_asenta AS tipo,
        m.d_mnpio AS municipio,
        e.d_estado AS estado
    FROM Asentamientos a
    INNER JOIN TiposAsentamiento ta ON a.c_tipo_asenta = ta.c_tipo_asenta
    INNER JOIN Municipios m ON a.c_mnpio = m.c_mnpio
    INNER JOIN Estados e ON m.c_estado = e.c_estado
    WHERE a.d_asenta LIKE CONCAT('%', p_nombre, '%')
        AND (p_estado IS NULL OR e.d_estado = p_estado)
    ORDER BY e.d_estado, m.d_mnpio, a.d_asenta;
END
-----------------------------------------------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `codigopostal`.`BuscarPorCodigoPostal`(IN p_codigo_postal VARCHAR(5))
BEGIN
    SELECT 
        a.id_asenta_cpcons,
        a.d_codigo AS codigo_postal,
        a.d_asenta AS asentamiento,
        ta.d_tipo_asenta AS tipo_asentamiento,
        a.d_zona AS zona,
        m.d_mnpio AS municipio,
        e.d_estado AS estado
    FROM Asentamientos a
    INNER JOIN TiposAsentamiento ta ON a.c_tipo_asenta = ta.c_tipo_asenta
    INNER JOIN Municipios m ON a.c_mnpio = m.c_mnpio
    INNER JOIN Estados e ON m.c_estado = e.c_estado
    WHERE a.d_codigo = p_codigo_postal
    ORDER BY a.d_asenta;
END
--------------------------------------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `codigopostal`.`BuscarPorCodigoPostal`(IN p_codigo_postal VARCHAR(5))
BEGIN
    SELECT 
        a.id_asenta_cpcons,
        a.d_codigo AS codigo_postal,
        a.d_asenta AS asentamiento,
        ta.d_tipo_asenta AS tipo_asentamiento,
        a.d_zona AS zona,
        m.d_mnpio AS municipio,
        e.d_estado AS estado
    FROM Asentamientos a
    INNER JOIN TiposAsentamiento ta ON a.c_tipo_asenta = ta.c_tipo_asenta
    INNER JOIN Municipios m ON a.c_mnpio = m.c_mnpio
    INNER JOIN Estados e ON m.c_estado = e.c_estado
    WHERE a.d_codigo = p_codigo_postal
    ORDER BY a.d_asenta;
END
---------------------------------------------------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `codigopostal`.`VerificarMigracion`()
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
END
