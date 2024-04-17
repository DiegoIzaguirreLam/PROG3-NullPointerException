
select * from Logro;
DROP PROCEDURE IF EXISTS INSERTAR_LOGRO;
DELIMITER $
CREATE PROCEDURE INSERTAR_LOGRO(
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _activo TINYINT,
    IN _fid_juego INT
)
BEGIN
    INSERT INTO Logro(nombre,descripcion,activo,fid_juego) 
    VALUES (_nombre,_descripcion,_activo,_fid_juego);
END$

DROP PROCEDURE IF EXISTS LISTAR_LOGRO;
DELIMITER $
CREATE PROCEDURE LISTAR_LOGRO()
BEGIN
	SELECT * FROM Logro;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_LOGRO(
	IN _id_logro INT,
	IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _fid_juego INT
)
BEGIN
	UPDATE Logro
    SET nombre = _nombre,
		descripcion = _descripcion,
        fid_juego = _fid_juego
	WHERE id_logro = _id_logro;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_LOGRO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_LOGRO(
	IN _id_logro INT
)
BEGIN
	UPDATE Logro
    SET activo = false
    WHERE id_logro = _id_logro;
END$

DROP PROCEDURE IF EXISTS BUSCAR_LOGRO;
DELIMITER $
CREATE PROCEDURE BUSCAR_LOGRO(
	IN _id_logro INT
)
BEGIN
	SELECT * FROM Logro WHERE id_logro = _id_logro;
END$


