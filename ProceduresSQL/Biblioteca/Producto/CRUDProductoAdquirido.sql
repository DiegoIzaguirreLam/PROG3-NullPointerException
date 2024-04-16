

DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO(
	IN _oculto TINYINT,
	IN _fid_biblioteca INT,
	IN _fid_producto INT,
	IN _fid_expositor INT,
	IN _fid_movimiento INT
)
BEGIN
	INSERT INTO ProductoAdquirido
    (fecha_adquisicion,tiempo_uso,actualizado, oculto,
    fid_biblioteca, fid_producto, fid_expositor, fid_movimiento)
    VALUES(CURDATE(), CAST('00:00:00' AS TIME),false, _oculto,
    _fid_biblioteca,_fid_producto,_fid_expositor,_fid_movimiento);
END$

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOADQUIRIDO()
BEGIN
	SELECT * FROM ProductoAdquirido;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PRODUCTOADQUIRIDO(
    IN _id_banda_adquirido INT,
    IN _fecha_adquisicion DATE,
    IN _fecha_ejecucion DATE,
    IN _tiempo_uso TIME,
    IN _actualizado TINYINT,
    IN _oculto TINYINT,
    IN _fid_biblioteca INT,
    IN _fid_producto INT,
    IN _fid_expositor INT,
    IN _fid_movimiento INT
)
BEGIN
    UPDATE ProductoAdquirido
    SET fecha_adquisicion = _fecha_adquisicion,
        fecha_ejecucion = _fecha_ejecucion,
        tiempo_uso = _tiempo_uso,
        actualizado = _actualizado,
        oculto = _oculto,
        fid_biblioteca = _fid_biblioteca,
		fid_producto = _fid_producto,
        fid_expositor = _fid_expositor,
        fid_movimiento = _fid_movimiento
    WHERE id_producto_adquirido = _id_producto_adquirido;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PRODUCTOADQUIRIDO(
	IN _id_producto_adquirido INT
)
BEGIN
    UPDATE ProductoAdquirido
    SET oculto = true
    WHERE id_producto_adquirido = _id_producto_adquirido; 
END$

