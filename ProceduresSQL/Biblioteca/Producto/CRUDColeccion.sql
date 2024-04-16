


DROP PROCEDURE IF EXISTS INSERTAR_COLECCION;
DELIMITER $
CREATE PROCEDURE INSERTAR_COLECCION(
	OUT _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
	INSERT INTO Coleccion(nombre, fid_biblioteca)
    VALUES (_nombre, _fid_biblioteca);
    SET _id_coleccion = @@last_insert_id;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_COLECCION;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_COLECCION(
	IN _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
	UPDATE Coleccion
    SET nombre = _nombre,
		fid_biblioteca = _fid_biblioteca
	WHERE id_coleccion = _id_coleccion;
END$


DROP PROCEDURE IF EXISTS ELIMINAR_COLECCION;
DELIMITER $
CREATE PROCEDURE ELIMINAR_COLECCION(
	IN _id_coleccion INT
)
BEGIN
	DELETE FROM ProductoAdquirido_Coleccion	WHERE fid_coleccion = _id_coleccion;
    DELETE FROM Coleccion WHERE id_coleccion = _id_coleccion;
END$


DROP PROCEDURE IF EXISTS LISTAR_COLECCIONES;
DELIMITER $
CREATE PROCEDURE LISTAR_COLECCIONES(
	IN _fid_biblioteca INT
)
BEGIN
	SELECT * FROM Coleccion WHERE fid_biblioteca = _fid_biblioteca;
END$






