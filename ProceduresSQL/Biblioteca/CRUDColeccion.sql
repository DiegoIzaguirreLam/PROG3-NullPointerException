


DROP PROCEDURE IF EXISTS INSERTAR_COLECCION;
DELIMITER $
CREATE PROCEDURE INSERTAR_COLECCION(
	OUT _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
	INSERT INTO Coleccion(nombre, fid_biblioteca, activo)
    VALUES (_nombre, _fid_biblioteca, 1);
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
	UPDATE FROM Coleccion SET activo = false where id_coleccion = _id_coleccion;
END$


DROP PROCEDURE IF EXISTS LISTAR_COLECCIONES;
DELIMITER $
CREATE PROCEDURE LISTAR_COLECCIONES(
	IN _fid_biblioteca INT
)
BEGIN
	SELECT * FROM Coleccion WHERE fid_biblioteca = _fid_biblioteca AND activo=1;
END$

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOSADQUIRIDOS_COLECCION;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOSADQUIRIDOS_COLECCION(
	IN _fid_coleccion INT
)
BEGIN
	SELECT p.titulo as titulo_producto, p.descripcion, p.tipo_producto, pa.fecha_ejecucion, pa.tiempo_uso, pa.actualizado, p.logo_url, p.portada_url
    FROM Coleccion c
    INNER JOIN ProductoAdquirido_Coleccion pc ON c.id_coleccion = pc.fid_coleccion
    INNER JOIN ProductoAdquirido pa ON  pa.id_producto_adquirido = pc.fid_producto_adquirido
    INNER JOIN Producto p ON p.id_producto = pa.fid_producto
    WHERE c.id_coleccion = _fid_coleccion AND pc.activo = 1 AND pa.activo = 1;
END$