DROP PROCEDURE IF EXISTS CREAR_MEDALLA;
DELIMITER $
CREATE PROCEDURE CREAR_MEDALLA(
	OUT _ID_MEDALLA INT,
    IN _NOMBRE VARCHAR(100),
    IN _EXPERIENCIA INT
)
BEGIN
	INSERT INTO Medalla(NOMBRE, EXPERIENCIA, ACTIVO)
	VALUES (_NOMBRE, _EXPERIENCIA, 1);
    SET _ID_MEDALLA = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ACTUALIZAR_MEDALLA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_MEDALLA(
	IN _ID_MEDALLA INT,
    IN _NOMBRE VARCHAR(100),
    IN _EXPERIENCIA INT
)
BEGIN
	UPDATE Medalla SET NOMBRE = _NOMBRE, EXPERIENCIA = _EXPERIENCIA WHERE ID_MEDALLA = _ID_MEDALLA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_MEDALLAS;
DELIMITER $
CREATE PROCEDURE LISTAR_MEDALLAS(
)
BEGIN
	SELECT * FROM Medalla;
END $
DELIMITER ;