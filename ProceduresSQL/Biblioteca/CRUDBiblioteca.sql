
DROP PROCEDURE IF EXISTS INSERTAR_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE INSERTAR_BIBLIOTECA(
	OUT _id_biblioteca INT,
    IN _fid_usuario INT
)
BEGIN
	INSERT INTO Biblioteca(fid_usuario)
    VALUES (_fid_usuario);
    SET _id_biblioteca = @@last_insert_id;
END$


DROP PROCEDURE IF EXISTS BUSCAR_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE BUSCAR_BIBLIOTECA(
	IN _fid_usuario INT
)
BEGIN
	SELECT * FROM Biblioteca WHERE fid_usuario = _fid_usuario;
END$


