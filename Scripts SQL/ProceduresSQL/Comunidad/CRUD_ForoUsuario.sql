DROP PROCEDURE IF EXISTS CREAR_RELACION_FORO;
DROP PROCEDURE IF EXISTS ELIMINAR_RELACION_FORO;
DROP PROCEDURE IF EXISTS SUSCRIBIR_RELACION;
DROP PROCEDURE IF EXISTS LISTAR_SUSCRITOS_FOROUSER;
DROP PROCEDURE IF EXISTS DESUSCRIBIR_RELACION_FORO;
DROP PROCEDURE IF EXISTS LISTAR_SUSCRIPTORES;

DELIMITER $
CREATE PROCEDURE CREAR_RELACION_FORO(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	INSERT INTO ForoUsuario (fid_foro, fid_usuario, es_creador, es_suscriptor, activo)
	VALUES (_fid_foro, _fid_usuario, 1, 0, 1);
END$
CREATE PROCEDURE SUSCRIBIR_RELACION(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	INSERT INTO ForoUsuario (fid_foro, fid_usuario, es_creador, es_suscriptor, activo)
	VALUES (_fid_foro, _fid_usuario, 0, 1, 1);
END$
CREATE PROCEDURE ELIMINAR_RELACION_FORO(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	UPDATE ForoUsuario SET activo=0 
	WHERE fid_foro = _fid_foro AND fid_usuario = _fid_usuario AND es_creador = 1;
END$
CREATE PROCEDURE DESUSCRIBIR_RELACION_FORO(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	UPDATE ForoUsuario SET activo=0 
	WHERE fid_foro = _fid_foro AND fid_usuario = _fid_usuario AND es_suscriptor = 1;
END$
CREATE PROCEDURE LISTAR_SUSCRITOS_FOROUSER(
	IN _fid_usuario INT
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro INNER JOIN ForoUsuario f ON f.fid_foro = id_foro WHERE fid_usuario = _fid_usuario AND f.es_suscriptor = 1 AND f.activo = 1;
END$

CREATE PROCEDURE LISTAR_SUSCRIPTORES(
	IN _fid_foro INT
)
BEGIN
	SELECT fid_usuario FROM ForoUsuario WHERE fid_foro = _fid_foro AND es_suscriptor = 1 AND es_creador = 0 AND activo = 1;
END$