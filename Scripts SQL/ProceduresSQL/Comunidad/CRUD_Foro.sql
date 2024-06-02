DROP PROCEDURE IF EXISTS CREAR_FORO;
DROP PROCEDURE IF EXISTS LISTAR_FOROS;
DROP PROCEDURE IF EXISTS BUSCAR_FORO;
DROP PROCEDURE IF EXISTS LISTAR_CREADOS;
DROP PROCEDURE IF EXISTS LISTAR_SUSCRITOS;
DROP PROCEDURE IF EXISTS MOSTRAR_SUBFOROS_POR_FORO;
DROP PROCEDURE IF EXISTS EDITAR_FORO;
DROP PROCEDURE IF EXISTS DESACTIVAR_FORO;
DROP PROCEDURE IF EXISTS ELIMINAR_FORO;

DELIMITER $ 
CREATE PROCEDURE CREAR_FORO(
	OUT _id_foro INT ,
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)

BEGIN
	INSERT INTO Foro(nombre,descripcion,
    origen_foro,oculto, activo) VALUES (_nombre,_descripcion,
    _origen_foro,0, 1);
	SET _id_foro = @@last_insert_id;

END $

CREATE PROCEDURE LISTAR_FOROS()
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro c INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_creador = 1 AND c.activo = 1;
END$

CREATE PROCEDURE BUSCAR_FORO(
	IN _nombre VARCHAR(100)
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro c INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_creador = 1 AND c.activo = 1 AND nombre LIKE CONCAT('%',_nombre,'%');
END$

CREATE PROCEDURE LISTAR_CREADOS(
	IN _iduser INT
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro c INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_creador = 1 AND c.activo = 1 AND f.fid_usuario = _iduser;
END$

CREATE PROCEDURE LISTAR_SUSCRITOS(
	IN _iduser INT
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, c.fid_usuario as id_user FROM Foro o INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_suscriptor = 1 AND o.activo = 1 AND f.fid_usuario = _iduser AND f.activo = 1 INNER JOIN ForoUsuario c ON c.fid_foro = id_foro WHERE c.es_creador = 1 AND c.activo = 1;
END$

CREATE PROCEDURE MOSTRAR_SUBFOROS_POR_FORO(
	in _id_foro INT 
)
BEGIN
	SELECT * FROM subforo WHERE fid_foro = _id_foro 
    AND oculto = 0;

END $

CREATE PROCEDURE EDITAR_FORO(
	IN _id_foro INT,
	IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)
BEGIN
	UPDATE Foro SET nombre = _nombre,
    descripcion = _descripcion,
    origen_foro = _origen_foro 
    WHERE id_foro = _id_foro; 

END $

CREATE PROCEDURE DESACTIVAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE Foro SET oculto = 1
    WHERE id_foro = _id_foro; 

END $

CREATE PROCEDURE ELIMINAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE Foro SET activo = 0
    WHERE id_foro = _id_foro; 

END $


