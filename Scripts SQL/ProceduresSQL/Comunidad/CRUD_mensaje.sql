DROP PROCEDURE IF EXISTS CREAR_MENSAJE;
DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJE;
DROP PROCEDURE IF EXISTS EDITAR_MENSAJE;
DROP PROCEDURE IF EXISTS DESACTIVAR_MENSAJE;
DROP PROCEDURE IF EXISTS ELIMINAR_MENSAJE;

DELIMITER $ 
CREATE PROCEDURE CREAR_MENSAJE(
	OUT _id_mensaje INT,
    IN _contenido VARCHAR(300),
    IN _fecha_publicacion DATE,
    IN _fecha_max_edicion DATE,
    IN _id_hilo INT,
    IN _id_usuario INT
)
BEGIN
	INSERT INTO Mensaje(contenido,fecha_publicacion,
    fecha_max_edicion,
    fid_hilo,fid_usuario,oculto, activo)
    VALUES (_contenido,_fecha_publicacion,
    _fecha_max_edicion,
    _id_hilo,_id_usuario,0, 1);
	SET _id_mensaje = @@last_insert_id;
    UPDATE Hilo SET nro_mensajes = nro_mensajes +1 
    WHERE id_hilo = _id_hilo;

END $

DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJE(
	in _id_mensaje INT 
)
BEGIN
	SELECT * FROM mensaje 
    WHERE id_mensaje = _id_mensaje 
    AND oculto = 0;

END $

DELIMITER $ 
CREATE PROCEDURE EDITAR_MENSAJE(
	IN _id_mensaje INT,
    IN _id_hilo INT,
    IN _contenido VARCHAR(300),
    IN _fecha_max_edicion DATE
)
BEGIN
	UPDATE Mensaje SET contenido = _contenido,
    fid_hilo = _id_hilo,
    fecha_max_edicion = _fecha_max_edicion
    WHERE id_mensaje = _id_mensaje; 
END $

DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE Mensaje SET oculto = 1
    WHERE id_mensaje = _id_mensaje; 

END $

DELIMITER $ 
CREATE PROCEDURE ELIMINAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE Mensaje SET activo = 0
    WHERE id_mensaje = _id_mensaje; 

END $
