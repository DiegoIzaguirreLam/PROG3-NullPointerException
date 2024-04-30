
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

INSERT INTO Biblioteca(id_biblioteca, fid_usuario) VALUES(1, 1);

SELECT * from ProductoAdquirido;
DROP PROCEDURE IF EXISTS BUSCAR_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE BUSCAR_BIBLIOTECA(
	IN _id_biblioteca INT
)
BEGIN
	SELECT * FROM Biblioteca WHERE id_biblioteca = _id_biblioteca;
END$


