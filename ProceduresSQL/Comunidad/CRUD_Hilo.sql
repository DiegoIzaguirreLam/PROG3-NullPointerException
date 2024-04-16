DROP PROCEDURE IF EXISTS CREAR_HILO;
DELIMITER $ 
CREATE PROCEDURE CREAR_HILO(
	OUT _id_hilo INT ,
    IN _id_subforo INT,
    IN _fijado TINYINT,
    IN _fecha_creacion DATE,
    IN _fecha_modificacion DATE
)
BEGIN
	INSERT INTO hilo(fijado,fecha_creacion,
    fecha_modificacion,fid_subforo,
    nro_mensajes,oculto)
    VALUES (_fijado,_fecha_creacion,
    _fecha_modificacion,_id_subforo,
    0,0);
	SET _id_hilo = @@last_insert_id;

END $

DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJES_POR_HILO;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJES_POR_HILO(
	in _id_hilo INT 
)
BEGIN
	SELECT * FROM mensaje WHERE fid_hilo = _id_hilo 
    AND oculto = 0;

END $

DROP PROCEDURE IF EXISTS EDITAR_HILO;
DELIMITER $ 
CREATE PROCEDURE EDITAR_HILO(
	IN _id_hilo INT ,
    IN _fijado TINYINT,
    IN _fecha_modificacion DATE
)
BEGIN
	UPDATE hilo SET fijado = _fijado,
    fecha_modificacion = _fecha_modificacion 
    WHERE id_hilo = _id_hilo; 
END $


DROP PROCEDURE IF EXISTS DESACTIVAR_HILO;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE hilo SET oculto = 1
    WHERE id_hilo = _id_hilo; 

END $
