
DROP PROCEDURE IF EXISTS INSERTAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE INSERTAR_LOGRODESBLOQUEADO(
    IN fid_logro INT,
    IN fid_producto_adquirido INT
)
BEGIN
    INSERT INTO Logro(fecha_desbloqueo,fid_logro,fid_producto_adquirido) 
    VALUES (CURDATE(),_fid_logro,_fid_producto_adquirido);
END$

DROP PROCEDURE IF EXISTS LISTAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE LISTAR_LOGRODESBLOQUEADO()
BEGIN
	SELECT * FROM LogroDesbloqueado;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT,
    IN _fecha_desbloqueo DATE,
    IN fid_logro INT,
    IN fid_producto_adquirido INT
)
BEGIN
	UPDATE LogroDesbloqueado
    SET fecha_desbloqueo = _fecha_desbloqueado,
		fid_logro = _fid_logro,
        fid_producto_adquirido = _fid_producto_adquirido
	WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT
)
BEGIN
	DELETE FROM LogroDesbloqueado WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

