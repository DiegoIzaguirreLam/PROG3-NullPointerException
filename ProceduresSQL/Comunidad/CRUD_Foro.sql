DROP PROCEDURE IF EXISTS CREAR_FORO;
DELIMITER $ 
CREATE PROCEDURE CREAR_FORO(
	OUT _id_foro INT ,
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)

BEGIN
	INSERT INTO foro(nombre,descripcion,
    origen_foro,oculto, activo) VALUES (_nombre,_descripcion,
    _origen_foro,0, 1);
	SET _id_foro = @@last_insert_id;

END $

DROP PROCEDURE IF EXISTS LISTAR_FOROS;
CREATE PROCEDURE LISTAR_FOROS()
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro INNER JOIN ForoUsuario f ON f.fid_foro = id_foro WHERE f.es_creador = 1 AND activo = 1;
END$

DROP PROCEDURE IF EXISTS MOSTRAR_SUBFOROS_POR_FORO;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_SUBFOROS_POR_FORO(
	in _id_foro INT 
)
BEGIN
	SELECT * FROM subforo WHERE fid_foro = _id_foro 
    AND oculto = 0;

END $


DROP PROCEDURE IF EXISTS EDITAR_FORO;
DELIMITER $ 
CREATE PROCEDURE EDITAR_FORO(
	IN _id_foro INT,
	IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)
BEGIN
	UPDATE foro SET nombre = _nombre,
    descripcion = _descripcion,
    origen_foro = _origen_foro 
    WHERE id_foro = _id_foro; 

END $

DROP PROCEDURE IF EXISTS DESACTIVAR_FORO;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE foro SET oculto = 1
    WHERE id_foro = _id_foro; 

END $

DROP PROCEDURE IF EXISTS ELIMINAR_FORO;
DELIMITER $ 
CREATE PROCEDURE ELIMINAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE foro SET activo = 0
    WHERE id_foro = _id_foro; 

END $


