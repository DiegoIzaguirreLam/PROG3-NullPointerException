DROP PROCEDURE IF EXISTS INSERTAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE INSERTAR_COMENTARIO(
	OUT _id_comentario INT,
	IN _fid_perfil_comentado INT,
    IN _fid_usuario_comentarista INT,
	IN _texto VARCHAR(300),
	IN _nro_likes INT,
    IN _fecha_maxedicion DATE
)
BEGIN
	INSERT INTO Comentario(fid_perfil_comentado,fid_usuario_comentarista,texto,nro_likes,fecha_publicacion,fecha_maxedicion,oculto)
    VALUES(_fid_perfil_comentado, _fid_usuario_comentarista, _texto,_nro_likes,CURDATE(),_fecha_maxedicion,false);
    SET _id_comentario = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_COMENTARIOS;
DELIMITER $
CREATE PROCEDURE LISTAR_COMENTARIOS()
BEGIN
    SELECT c.id_comentario, c.nro_likes, c.oculto, c.fecha_publicacion, c.fecha_maxedicion, p.id_perfil, p.oculto as 'perfil_oculto'
    FROM Comentario c
    INNER JOIN Perfil p on p.id_perfil = c.fid_perfil_comentado
    WHERE c.oculto = false;
END$

DROP PROCEDURE IF EXISTS LISTAR_COMENTARIOS_PERFIL;
DELIMITER $
CREATE PROCEDURE LISTAR_COMENTARIOS_PERFIL(
	IN _id_perfil INT
)
BEGIN
    SELECT c.id_comentario, c.nro_likes, c.oculto, c.fecha_publicacion, c.fecha_maxedicion, p.id_perfil, p.oculto as 'perfil_oculto'
    FROM Comentario c
    INNER JOIN Perfil p on p.id_perfil = c.fid_perfil_comentado
    WHERE c.oculto = false
    AND _id_perfil = fid_perfil_comentado;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_COMENTARIO(
    IN _id_comentario INT,
	IN _fid_perfil INT,
    IN _fid_usuario INT,
	IN _texto VARCHAR(300),
	IN _nro_likes INT,
    IN _oculto TINYINT,
    IN _fecha_maxedicion DATE,
    IN _fecha_publicacion DATE
)
BEGIN
    UPDATE Comentario
    SET fid_perfil = _fid_perfil,
		fid_usuario = _fid_usuario,
        texto = _texto,
        nro_likes = _nro_likes,
        oculto = _oculto,
        fecha_publicacion = _fecha_publicacion,
        fecha_maxedicion = _fecha_maxedicion
    WHERE id_comentario = _id_comentario;
END$

DROP PROCEDURE IF EXISTS OCULTAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE OCULTAR_COMENTARIO(
	IN _id_comentario INT
)
BEGIN
    UPDATE Comentario
    SET oculto = true
    WHERE id_comentario = _id_comentario; 
END$