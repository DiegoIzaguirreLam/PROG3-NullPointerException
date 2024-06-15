
DROP PROCEDURE IF EXISTS INSERTAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE INSERTAR_LOGRODESBLOQUEADO(
	OUT _id_logro_desbloqueado INT,
    IN _fid_logro INT,
    IN _fid_producto_adquirido INT
)
BEGIN
    INSERT INTO LogroDesbloqueado(fecha_desbloqueo,fid_logro,fid_producto_adquirido, activo) 
    VALUES (CURDATE(),_fid_logro,_fid_producto_adquirido, 1);
    SET _id_logro_desbloqueado = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_LOGRODESBLOQUEADOPRODUCTO;
DELIMITER $
CREATE PROCEDURE LISTAR_LOGRODESBLOQUEADOPRODUCTO(
	IN _id_producto_adquirido INT
)
BEGIN
	SELECT ld.id_logro_desbloqueado, ld.fecha_desbloqueo, l.id_logro, l.nombre as nombre_logro, l.descripcion as descripcion_logro
    FROM LogroDesbloqueado ld
    INNER JOIN Logro l ON l.id_logro = ld.fid_logro
    WHERE ld.activo = 1 AND l.activo = 1
    AND ld.fid_producto_adquirido = _id_producto_adquirido;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT,
    IN _fecha_desbloqueo DATE
)
BEGIN
	UPDATE LogroDesbloqueado
    SET fecha_desbloqueo = _fecha_desbloqueado
	WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT
)
BEGIN
	UPDATE LogroDesbloqueado SET activo = 0 WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$



-- ----------------------------------------------------------------------------------------
-- Autor: Fabricio
-- ----------------------------------------------------------------------------------------
-- Procedimiento que enlista todos los logros que tiene un usuario
-- Recopila la información de la Fecha de Desbloqueo, Nombre del
-- Logro, Descripción del Logro, Título del Juego y la URL del Logo.
-- ----------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS LISTAR_LOGROS_POR_USUARIO;
-- ----------------------------------------------------------------------------------------
DELIMITER $ 
CREATE PROCEDURE LISTAR_LOGROS_POR_USUARIO (
    IN _id_usuario INT
)
BEGIN
    SELECT ld.id_logro_desbloqueado AS "ID del Logro Desbloqueado",
		   ld.fecha_desbloqueo AS "Fecha de Desbloqueo",
		   lo.id_logro AS "ID del Logro",
		   lo.nombre AS "Nombre del Logro",
           lo.descripcion AS "Descripción del Logro",
           pr.id_producto AS "ID del Juego",
           pr.titulo AS "Título del Juego",
           pr.logo_url AS "URL del Logo"
    FROM LogroDesbloqueado ld
    INNER JOIN Logro             lo ON ld.fid_logro = lo.id_logro
    INNER JOIN Juego             ju ON lo.fid_juego = ju.id_juego
    INNER JOIN Producto          pr ON ju.id_juego  = pr.id_producto
    INNER JOIN ProductoAdquirido pa ON ld.fid_producto_adquirido = pa.id_producto_adquirido
    INNER JOIN Biblioteca 		 bl	ON pa.fid_biblioteca = bl.id_biblioteca
    WHERE ld.activo = true AND
		  lo.activo = true AND
          pr.activo = true AND
          bl.fid_usuario= _id_usuario;
END $
-- ----------------------------------------------------------------------------------------
