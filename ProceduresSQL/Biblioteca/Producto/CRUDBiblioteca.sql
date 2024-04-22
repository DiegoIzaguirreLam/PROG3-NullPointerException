
DROP PROCEDURE IF EXISTS INSERTAR_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE INSERTAR_BIBLIOTECA(
	IN _id_biblioteca INT
)
BEGIN
	INSERT INTO Biblioteca(id_biblioteca, id_usuario)
    VALUES (_id_biblioteca, id_biblioteca);
END$

DELIMITER $
CREATE PROCEDURE BUSCAR_BIBLIOTECA(
	IN _id_biblioteca INT
)
BEGIN
	SELECT * FROM Biblioteca WHERE id_biblioteca = _id_biblioteca;
END$


