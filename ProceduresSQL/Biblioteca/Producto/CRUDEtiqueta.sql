
DROP PROCEDURE IF EXISTS INSERTAR_ETIQUETA;
DELIMITER $
CREATE PROCEDURE INSERTAR_ETIQUETA(
	OUT _id_etiqueta INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	INSERT INTO Etiqueta(nombre, activo)
    VALUES (_nombre, 1);
    SET _id_etiqueta = @@last_insert_id;
END;

DROP PROCEDURE IF EXISTS LISTAR_ETIQUETAS;
DELIMITER $
CREATE PROCEDURE LISTAR_ETIQUETAS()
BEGIN
	SELECT * FROM Etiqueta;
END;

DROP PROCEDURE IF EXISTS ACTUALIZAR_ETIQUETA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_ETIQUETA(
	IN _id_etiqueta INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	UPDATE Proveedor
    SET nombre = _nombre
    WHERE id_etiqueta = _id_nombre;
END;

DROP PROCEDURE IF EXISTS ELIMINAR_ETIQUETA;
DELIMITER $
CREATE PROCEDURE ELIMINAR_ETIQUETA(
	IN _id_etiqueta INT
)
BEGIN
	UPDATE Etiqueta SET activo = 0 WHERE id_etiqueta = _id_etiqueta;
END;
