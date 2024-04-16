DROP PROCEDURE IF EXISTS CREAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE CREAR_MENSAJE(
	OUT _id_mensaje INT,
    IN _contenido VARCHAR(300),
    IN _fecha_publicacion DATE,
    IN _fecha_max_edicion DATE,
    IN _padre INT,
    IN _id_hilo INT,
    IN _id_usuario INT
)
BEGIN
	INSERT INTO mensaje(contenido,fecha_publicacion,
    fecha_max_edicion,padre,
    fid_hilo,fid_usuario,oculto)
    VALUES (_contenido,_fecha_publicacion,
    _fecha_max_edicion,_padre,
    _id_hilo,_id_usuario,0);
	SET _id_mensaje = @@last_insert_id;
    UPDATE hilo SET nro_mensajes = nro_mensajes +1 
    WHERE id_hilo = _id_hilo;

END $

DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJE(
	in _id_mensaje INT 
)
BEGIN
	SELECT * FROM mensaje 
    WHERE id_mensaje = _id_mensaje 
    AND oculto = 0;

END $

DROP PROCEDURE IF EXISTS EDITAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE EDITAR_MENSAJE(
	IN _id_mensaje INT,
    IN _id_hilo INT,
    IN _contenido VARCHAR(300),
    IN _fecha_max_edicion DATE
)
BEGIN
	UPDATE mensaje SET contenido = _contenido,
    fid_hilo = _id_hilo,
    fecha_max_edicion = _fecha_max_edicion
    WHERE id_mensaje = _id_mensaje; 
END $

DROP PROCEDURE IF EXISTS DESACTIVAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE mensaje SET oculto = 1
    WHERE id_mensaje = _id_mensaje; 

END $
