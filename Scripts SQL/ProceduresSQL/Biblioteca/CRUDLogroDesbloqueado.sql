DROP PROCEDURE IF EXISTS INSERTAR_LOGRODESBLOQUEADO;
DROP PROCEDURE IF EXISTS LISTAR_LOGRODESBLOQUEADOPRODUCTO;
DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRODESBLOQUEADO;
DROP PROCEDURE IF EXISTS ELIMINAR_LOGRODESBLOQUEADO;
DROP PROCEDURE IF EXISTS LISTAR_LOGROS_POR_USUARIO;

DELIMITER $

CREATE PROCEDURE INSERTAR_LOGRODESBLOQUEADO(
    OUT _id_logro_desbloqueado INT,
    IN _fid_logro INT,
    IN _fid_producto_adquirido INT
)
BEGIN
    INSERT INTO LogroDesbloqueado (fecha_desbloqueo, fid_logro, fid_producto_adquirido, activo) 
    VALUES (CURDATE(), _fid_logro, _fid_producto_adquirido, 1);
    SET _id_logro_desbloqueado = @@last_insert_id;
END$

CREATE PROCEDURE LISTAR_LOGRODESBLOQUEADOPRODUCTO(
    IN _id_producto_adquirido INT
)
BEGIN
    SELECT ld.id_logro_desbloqueado, ld.fecha_desbloqueo, l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro
    FROM LogroDesbloqueado ld
    INNER JOIN Logro l ON ld.fid_logro = l.id_logro
    WHERE ld.activo = 1 AND l.activo = 1
    AND ld.fid_producto_adquirido = _id_producto_adquirido;
END$

CREATE PROCEDURE ACTUALIZAR_LOGRODESBLOQUEADO(
    IN _id_logro_desbloqueado INT,
    IN _fecha_desbloqueo DATE
)
BEGIN
    UPDATE LogroDesbloqueado
    SET fecha_desbloqueo = _fecha_desbloqueo
    WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

CREATE PROCEDURE ELIMINAR_LOGRODESBLOQUEADO(
    IN _id_logro_desbloqueado INT
)
BEGIN
    UPDATE LogroDesbloqueado SET activo = 0 WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

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
    INNER JOIN Logro lo ON ld.fid_logro = lo.id_logro
    INNER JOIN Producto pr ON lo.fid_juego = pr.id_producto
    INNER JOIN ProductoAdquirido pa ON ld.fid_producto_adquirido = pa.id_producto_adquirido
    INNER JOIN Biblioteca bl ON pa.fid_biblioteca = bl.id_biblioteca
    WHERE ld.activo = 1 AND
          lo.activo = 1 AND
          pr.activo = 1 AND
          bl.fid_usuario = _id_usuario;
END$

DELIMITER ;
