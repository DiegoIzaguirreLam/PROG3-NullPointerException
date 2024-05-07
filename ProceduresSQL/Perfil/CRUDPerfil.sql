DROP PROCEDURE IF EXISTS INSERTAR_PERFIL;
DELIMITER $
CREATE PROCEDURE INSERTAR_PERFIL(
	IN _id_perfil INT,
    IN _foto_url VARCHAR(200)
)
BEGIN
	INSERT INTO Perfil(id_perfil, usuario_id, foto_url, oculto) 
    VALUES(_id_perfil, _id_perfil, _foto_url, false);
END$


DROP PROCEDURE IF EXISTS LISTAR_PERFILES;
DELIMITER $
CREATE PROCEDURE LISTAR_PERFILES()
BEGIN
    SELECT *
    FROM Perfil
    WHERE oculto=false;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_PERFIL;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PERFIL(
    IN _id_perfil INT,
    IN _foto_url VARCHAR(200),
    IN _oculto TINYINT
)
BEGIN
    UPDATE Perfil
    SET foto_url = _foto_url,
		oculto = _oculto
    WHERE id_perfil = _id_perfil;
END$

DROP PROCEDURE IF EXISTS BUSCAR_PERFIL;
DELIMITER $
CREATE PROCEDURE BUSCAR_PERFIL(
	IN _id_usuario INT
)
BEGIN
	SELECT *
    FROM Perfil
    WHERE id_perfil = _id_usuario; 
END$

DROP PROCEDURE IF EXISTS OCULTAR_PERFIL;
DELIMITER $
CREATE PROCEDURE OCULTAR_PERFIL(
	IN _id_perfil INT
)
BEGIN
    UPDATE Perfil
    SET oculto = true
    WHERE id_perfil = _id_perfil; 
END$