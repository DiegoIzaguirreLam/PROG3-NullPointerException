DROP PROCEDURE IF EXISTS CREAR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE CREAR_SUBFORO(
	OUT _id_subforo INT ,
	IN _id_foro INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	INSERT INTO subforo(fid_foro,nombre,oculto) 
    VALUES (_id_foro,_nombre,1);
	SET _id_subforo = @@last_insert_id;

END $

DROP PROCEDURE IF EXISTS MOSTRAR_HILOS_POR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_HILOS_POR_SUBFORO(
	in _id_subforo INT 
)
BEGIN
	SELECT * FROM hilo WHERE 
    fid_subforo = _id_subforo
    AND oculto = 1;

END $

DROP PROCEDURE IF EXISTS EDITAR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE EDITAR_SUBFORO(
	IN _id_subforo INT,
	IN _nombre VARCHAR(100)
)
BEGIN
	UPDATE subforo SET nombre = _nombre
    WHERE id_subforo = _id_subforo; 

END $


DROP PROCEDURE IF EXISTS DESACTIVAR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_SUBFORO(
	IN _id_subforo INT
)
BEGIN
	UPDATE foro SET oculto = 0
    WHERE id_subforo = _id_subforo; 

END $

