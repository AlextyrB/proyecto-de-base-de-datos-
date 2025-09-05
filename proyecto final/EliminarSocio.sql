USE club;

DELIMITER //

CREATE PROCEDURE EliminarSocio(
    IN p_id_socio INT(10)
)
BEGIN
    DECLARE v_count_barcos INT DEFAULT 0;
    DECLARE v_socio_exists INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Verificar si el socio existe
    SELECT COUNT(*) INTO v_socio_exists 
    FROM Socio 
    WHERE id_socio = p_id_socio;
    
    IF v_socio_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El socio especificado no existe.';
    END IF;

    -- Verificar si el socio tiene barcos asociados
    SELECT COUNT(*) INTO v_count_barcos 
    FROM Barco 
    WHERE id_socio = p_id_socio;
    
    START TRANSACTION;
    
    IF v_count_barcos > 0 THEN
        -- Si tiene barcos, primero eliminar las relaciones en Barco_Muelle
        DELETE bm FROM Barco_Muelle bm
        INNER JOIN Barco b ON bm.n_matricula = b.n_matricula
        WHERE b.id_socio = p_id_socio;
        
        -- Eliminar las relaciones en Viaje_Barco
        DELETE vb FROM Viaje_Barco vb
        INNER JOIN Barco b ON vb.n_matricula = b.n_matricula
        WHERE b.id_socio = p_id_socio;
        
        -- Eliminar los barcos del socio
        DELETE FROM Barco WHERE id_socio = p_id_socio;
    END IF;
    
    -- Finalmente eliminar el socio
    DELETE FROM Socio WHERE id_socio = p_id_socio;
    
    COMMIT;
    
    SELECT CONCAT('Socio con ID ', p_id_socio, ' eliminado exitosamente.') AS resultado;
    
END //

DELIMITER ;

-- Procedimiento alternativo que solo elimina si no tiene barcos asociados
DELIMITER //

CREATE PROCEDURE EliminarSocioSeguro(
    IN p_id_socio INT(10)
)
BEGIN
    DECLARE v_count_barcos INT DEFAULT 0;
    DECLARE v_socio_exists INT DEFAULT 0;
    
    -- Verificar si el socio existe
    SELECT COUNT(*) INTO v_socio_exists 
    FROM Socio 
    WHERE id_socio = p_id_socio;
    
    IF v_socio_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El socio especificado no existe.';
    END IF;

    -- Verificar si el socio tiene barcos asociados
    SELECT COUNT(*) INTO v_count_barcos 
    FROM Barco 
    WHERE id_socio = p_id_socio;
    
    IF v_count_barcos > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el socio porque tiene barcos asociados.';
    ELSE
        DELETE FROM Socio WHERE id_socio = p_id_socio;
        SELECT CONCAT('Socio con ID ', p_id_socio, ' eliminado exitosamente.') AS resultado;
    END IF;
    
END //

DELIMITER ;

-- Ejemplos de uso:
-- CALL EliminarSocio(1);           -- Elimina el socio y sus barcos asociados
-- CALL EliminarSocioSeguro(1);     -- Solo elimina si no tiene barcos asociados