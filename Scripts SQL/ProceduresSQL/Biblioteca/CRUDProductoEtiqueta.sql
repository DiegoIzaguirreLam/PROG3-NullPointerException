
DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOETIQUETA(
    IN _fid_producto INT,
    IN _fid_etiqueta INT
)
BEGIN
	INSERT INTO ProductoEtiqueta(fid_producto,fid_etiqueta,activo)
    VALUES(_fid_producto, _fid_etiqueta,1)
    ON DUPLICATE KEY UPDATE activo = 1;
END$

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOETIQUETA()
BEGIN
	SELECT * FROM ProductoEtiqueta;
END$

/*
DROP PROCEDURE IF EXISTS ACTUALIZAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PRODUCTOETIQUETA(
	IN _fid_producto INT,
    IN _fid_etiqueta INT
)
BEGIN
	UPDATE ProductoEtiqueta
    SET fid_producto = _fid_producto,
		fid_etiqueta = _fid_etiqueta
	WHERE fid_producto=_fid_producto and fid_etiqueta = _fid_etiqueta;
END$*/

DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PRODUCTOETIQUETA(
	IN _fid_producto INT,
    IN _fid_etiqueta INT
)
BEGIN
	UPDATE ProductoEtiqueta 
    SET activo = 0
    WHERE fid_producto = _fid_producto
    AND fid_etiqueta = _fid_etiqueta;
END$

