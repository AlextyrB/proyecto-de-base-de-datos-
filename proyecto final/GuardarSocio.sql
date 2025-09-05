DELIMITER //

CREATE PROCEDURE GuardarNuevoSocio(
    IN p_nombre VARCHAR(15),
    IN p_apellido_paterno VARCHAR(20),
    IN p_apellido_materno VARCHAR(20),
    IN p_telefono VARCHAR(10),
    IN p_correo VARCHAR(100),
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255),
    OUT p_id_socio INT
)
BEGIN
    DECLARE v_error_count INT DEFAULT 0;
    DECLARE v_duplicate_count INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1
            p_mensaje = MESSAGE_TEXT;
        SET p_resultado = 0;
        SET p_id_socio = 0;
    END;

    -- Inicializar variables de salida
    SET p_resultado = 1;
    SET p_mensaje = 'Socio guardado exitosamente';
    SET p_id_socio = 0;

    START TRANSACTION;

    -- Validaciones de entrada
    IF p_nombre IS NULL OR TRIM(p_nombre) = '' THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El nombre es obligatorio';
        ROLLBACK;
    ELSEIF p_apellido_paterno IS NULL OR TRIM(p_apellido_paterno) = '' THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El apellido paterno es obligatorio';
        ROLLBACK;
    ELSEIF p_apellido_materno IS NULL OR TRIM(p_apellido_materno) = '' THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El apellido materno es obligatorio';
        ROLLBACK;
    ELSE
        -- Verificar si ya existe un socio con el mismo teléfono o correo
        IF p_telefono IS NOT NULL AND TRIM(p_telefono) != '' THEN
            SELECT COUNT(*) INTO v_duplicate_count 
            FROM Socio 
            WHERE telefono = p_telefono;
            
            IF v_duplicate_count > 0 THEN
                SET p_resultado = 0;
                SET p_mensaje = 'Ya existe un socio registrado con ese número de teléfono';
                ROLLBACK;
            END IF;
        END IF;

        IF p_correo IS NOT NULL AND TRIM(p_correo) != '' AND p_resultado = 1 THEN
            SELECT COUNT(*) INTO v_duplicate_count 
            FROM Socio 
            WHERE correo = p_correo;
            
            IF v_duplicate_count > 0 THEN
                SET p_resultado = 0;
                SET p_mensaje = 'Ya existe un socio registrado con ese correo electrónico';
                ROLLBACK;
            END IF;
        END IF;

        -- Si todas las validaciones son exitosas, insertar el nuevo socio
        IF p_resultado = 1 THEN
            INSERT INTO Socio (
                nombre, 
                apellido_paterno, 
                apellido_materno, 
                telefono, 
                correo
            ) VALUES (
                TRIM(p_nombre),
                TRIM(p_apellido_paterno),
                TRIM(p_apellido_materno),
                CASE WHEN p_telefono IS NULL OR TRIM(p_telefono) = '' THEN NULL ELSE TRIM(p_telefono) END,
                CASE WHEN p_correo IS NULL OR TRIM(p_correo) = '' THEN NULL ELSE TRIM(p_correo) END
            );

            -- Obtener el ID del socio recién insertado
            SET p_id_socio = LAST_INSERT_ID();
            
            COMMIT;
        END IF;
    END IF;

END //

DELIMITER ;