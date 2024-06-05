DROP PROCEDURE IF EXISTS CREAR_HILO;
DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJES_POR_HILO;
DROP PROCEDURE IF EXISTS EDITAR_HILO;
DROP PROCEDURE IF EXISTS DESACTIVAR_HILO;
DROP PROCEDURE IF EXISTS ELIMINAR_HILO;

DELIMITER $ 
CREATE PROCEDURE CREAR_HILO(
	OUT _id_hilo INT ,
    IN _id_subforo INT,
    IN _id_usuario INT,
    IN _fijado TINYINT,
    IN _fecha_creacion DATE,
    IN _fecha_modificacion DATE,
	IN _imagen_url VARCHAR(200)
)
BEGIN
	INSERT INTO Hilo(fijado,fecha_creacion,
    fecha_modificacion,fid_subforo,fid_creador, imagen_url,
    nro_mensajes,oculto, activo)
    VALUES (_fijado,_fecha_creacion,
    _fecha_modificacion,_id_subforo,
    _id_usuario, _imagen_url, 0,0, 1);
	SET _id_hilo = @@last_insert_id;

END $

DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJES_POR_HILO(
	in _id_hilo INT 
)
BEGIN
	SELECT * FROM Mensaje WHERE fid_hilo = _id_hilo 
    AND oculto = 0;

END $

DELIMITER $ 
CREATE PROCEDURE EDITAR_HILO(
	IN _id_hilo INT,
    IN _id_subforo INT,
    IN _fijado TINYINT,
    IN _fecha_modificacion DATE,
	IN _imagen_url VARCHAR(200)
)
BEGIN
	UPDATE Hilo SET fijado = _fijado, fid_subforo = _id_subforo,
    fecha_modificacion = _fecha_modificacion , imagen_url = _imagen_url
    WHERE id_hilo = _id_hilo; 
END $

DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE Hilo SET oculto = 1
    WHERE id_hilo = _id_hilo; 

END $

DELIMITER $ 
CREATE PROCEDURE ELIMINAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE Hilo SET activo = 0
    WHERE id_hilo = _id_hilo; 

END $


