DROP PROCEDURE IF EXISTS CREAR_SUBFORO;
DROP PROCEDURE IF EXISTS MOSTRAR_HILOS_POR_SUBFORO;
DROP PROCEDURE IF EXISTS EDITAR_SUBFORO;
DROP PROCEDURE IF EXISTS DESACTIVAR_SUBFORO;

DELIMITER $ 
CREATE PROCEDURE CREAR_SUBFORO(
	OUT _id_subforo INT ,
	IN _id_foro INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	INSERT INTO Subforo(fid_foro,nombre,oculto, activo) 
    VALUES (_id_foro,_nombre,0, 1);
	SET _id_subforo = @@last_insert_id;

END $

DELIMITER $ 
CREATE PROCEDURE MOSTRAR_HILOS_POR_SUBFORO(
	in _id_subforo INT 
)
BEGIN
	SELECT * FROM Hilo WHERE 
    fid_subforo = _id_subforo
    AND oculto = 0;

END $


DELIMITER $ 
CREATE PROCEDURE EDITAR_SUBFORO(
	IN _id_subforo INT,
	IN _nombre VARCHAR(100)
)
BEGIN
	UPDATE Subforo SET nombre = _nombre
    WHERE id_subforo = _id_subforo; 

END $

DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_SUBFORO(
	IN _id_subforo INT
)
BEGIN
	UPDATE Foro SET oculto = 1
    WHERE id_subforo = _id_subforo; 

END $
