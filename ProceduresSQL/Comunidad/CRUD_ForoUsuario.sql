DROP PROCEDURE IF EXISTS CREAR_RELACION;
DROP PROCEDURE IF EXISTS ELIMINAR_RELACION;
DELIMITER $
CREATE PROCEDURE CREAR_RELACION(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	INSERT INTO ForoUsuario (fid_foro, fid_usuario, activo)
	VALUES (_fid_foro, _fid_usuario, 1);
END$
CREATE PROCEDURE ELIMINAR_RELACION(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	UPDATE ForoUsuario SET activo=0 
	WHERE fid_foro = _fid_foro AND fid_usuario = _fid_usuario;
END$
