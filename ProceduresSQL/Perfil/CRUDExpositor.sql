DROP PROCEDURE IF EXISTS INSERTAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE INSERTAR_EXPOSITOR(
	OUT _id_expositor INT,
	IN _fid_perfil INT
)
BEGIN
	INSERT INTO Expositor(fid_perfil,oculto,activo) VALUES(_fid_perfil,false,true);
    SET _id_expositor = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_EXPOSITORES;
DELIMITER $
CREATE PROCEDURE LISTAR_EXPOSITORES()
BEGIN
    SELECT *
    FROM Expositor
    WHERE activo = 1;
END$

DROP PROCEDURE IF EXISTS LISTAR_EXPOSITORES_PERFIL;
DELIMITER $
CREATE PROCEDURE LISTAR_EXPOSITORES_PERFIL(
	IN id_perfil INT
)
BEGIN
    SELECT *
    FROM Expositor
    WHERE fid_perfil = id_perfil
    AND activo = 1;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_EXPOSITOR(
    IN _id_expositor INT,
    IN _oculto TINYINT,
    IN _activo TINYINT,
    IN _fid_perfil INT
)
BEGIN
    UPDATE Expositor
    SET oculto=_oculto,
		fid_perfil = _fid_perfil,
        activo = _activo
    WHERE id_expositor = _id_expositor;
END$

DROP PROCEDURE IF EXISTS OCULTAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE OCULTAR_EXPOSITOR(
	IN _id_expositor INT
)
BEGIN
    UPDATE Expositor
    SET oculto = true
    WHERE id_expositor = _id_expositor; 
END$

DROP PROCEDURE IF EXISTS ELIMINAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE ELIMINAR_EXPOSITOR(
	IN _id_expositor INT
)
BEGIN
    UPDATE Expositor
    SET activo = false
    WHERE id_expositor = _id_expositor; 
END$