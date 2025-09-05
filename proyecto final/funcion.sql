---Una función que realice una lógica de negocio sobre la base de datos--


USE club;

DELIMITER //

CREATE FUNCTION calcular_descuento_mensualidad(
    p_id_socio INT,
    p_mensualidad_base DECIMAL(10,2)
) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_cantidad_barcos INT DEFAULT 0;
    DECLARE v_total_viajes INT DEFAULT 0;
    DECLARE v_descuento_porcentaje DECIMAL(5,2) DEFAULT 0.00;
    DECLARE v_mensualidad_final DECIMAL(10,2);
    
    -- Contar cuántos barcos tiene el socio
    SELECT COUNT(*) INTO v_cantidad_barcos
    FROM Barco 
    WHERE id_socio = p_id_socio;
    
    -- Contar total de viajes realizados por los barcos del socio
    SELECT COUNT(DISTINCT vb.n_viaje) INTO v_total_viajes
    FROM Barco b
    INNER JOIN Viaje_Barco vb ON b.n_matricula = vb.n_matricula
    WHERE b.id_socio = p_id_socio;
    
    -- Lógica de negocio para calcular descuento
    -- Descuento por cantidad de barcos
    IF v_cantidad_barcos >= 3 THEN
        SET v_descuento_porcentaje = v_descuento_porcentaje + 15.00; -- 15% por tener 3+ barcos
    ELSEIF v_cantidad_barcos = 2 THEN
        SET v_descuento_porcentaje = v_descuento_porcentaje + 8.00;  -- 8% por tener 2 barcos
    END IF;
    
    -- Descuento adicional por actividad (viajes realizados)
    IF v_total_viajes >= 20 THEN
        SET v_descuento_porcentaje = v_descuento_porcentaje + 10.00; -- 10% por alta actividad
    ELSEIF v_total_viajes >= 10 THEN
        SET v_descuento_porcentaje = v_descuento_porcentaje + 5.00;  -- 5% por actividad media
    END IF;
    
    -- Límite máximo de descuento del 25%
    IF v_descuento_porcentaje > 25.00 THEN
        SET v_descuento_porcentaje = 25.00;
    END IF;
    
    -- Calcular mensualidad final con descuento
    SET v_mensualidad_final = p_mensualidad_base - (p_mensualidad_base * v_descuento_porcentaje / 100);
    
    RETURN v_mensualidad_final;
END //

SELECT 
    s.id_socio,
    CONCAT(s.nombre, ' ', s.apellido_paterno) AS nombre_socio,
    b.mensualidad AS mensualidad_base,
    calcular_descuento_mensualidad(s.id_socio, b.mensualidad) AS mensualidad_con_descuento
FROM 
    Socio s
JOIN 
    Barco b ON s.id_socio = b.id_socio
WHERE 
    s.id_socio = 8;  -- Reemplaza con el ID del socio que necesites
