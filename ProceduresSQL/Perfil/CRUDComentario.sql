DROP PROCEDURE IF EXISTS INSERTAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE INSERTAR_COMENTARIO(
	OUT _id_comentario INT,
	IN _fid_perfil INT,
    IN _fid_usuario INT,
	IN _texto VARCHAR(300),
	IN _nro_likes INT
)
BEGIN
	INSERT INTO Comentario(fid_perfil,fid_usuario,texto,nro_likes, oculto)
    VALUES(_fid_perfil, _fid_usuario, _texto,_nro_likes,false);
    SET _id_comentario = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_COMENTARIOS;
DELIMITER $
CREATE PROCEDURE LISTAR_COMENTARIOS()
BEGIN
    SELECT id_comentario, u.nombre_perfil, texto, nro_likes
    FROM Comentario c
    INNER JOIN Usuario u ON u.UID = c.fid_usuario
    WHERE oculto = false;
END$

DROP PROCEDURE IF EXISTS LISTAR_COMENTARIOS_PERFIL;
DELIMITER $
CREATE PROCEDURE LISTAR_COMENTARIOS_PERFIL(
	IN _id_perfil INT
)
BEGIN
    SELECT id_comentario, u.nombre_perfil, texto, nro_likes
    FROM Comentario c
    INNER JOIN Usuario u ON u.UID = c.fid_usuario
    WHERE oculto = false
    AND _id_perfil = fid_perfil_comentarista;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_COMENTARIO(
    IN _id_comentario INT,
	IN _fid_perfil INT,
    IN _fid_usuario INT,
	IN _texto VARCHAR(300),
	IN _nro_likes INT,
    IN _oculto TINYINT
)
BEGIN
    UPDATE Comentario
    SET fid_perfil = _fid_perfil,
		fid_usuario = _fid_usuario,
        texto = _texto,
        nro_likes = _nro_likes,
        oculto = _oculto
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