DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO_COLECCION;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO_COLECCION(
	IN _fid_coleccion INT,
    IN _fid_producto_adquirido INT
)
BEGIN
	INSERT INTO ProductoAdquirido_Coleccion(fid_coleccion, fid_producto_adquirido)
    VALUES (_fid_coleccion, _fid_producto_adquirido, 1);
END$


DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOADQUIRIDO_COLECCION;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PRODUCTOADQUIRIDO_COLECCION(
	IN _fid_coleccion INT,
    IN _fid_producto_adquirido INT
)
BEGIN
	UPDATE ProductoAdquirido_Coleccion
    SET activo = 0
    WHERE fid_coleccion = _fid_coleccion AND fid_producto_adquirido = _fid_producto_adquirido;
END$