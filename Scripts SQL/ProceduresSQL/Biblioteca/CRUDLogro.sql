DROP PROCEDURE IF EXISTS INSERTAR_LOGRO;
DROP PROCEDURE IF EXISTS LISTAR_LOGROS;
DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRO;
DROP PROCEDURE IF EXISTS ELIMINAR_LOGRO;
DROP PROCEDURE IF EXISTS BUSCAR_LOGRO;
DROP PROCEDURE IF EXISTS LISTAR_LOGROS_X_ID_JUEGO;

DELIMITER $

CREATE PROCEDURE INSERTAR_LOGRO(
    OUT _id_logro INT,
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _activo TINYINT,
    IN _fid_juego INT
)
BEGIN
    INSERT INTO Logro(nombre, descripcion, fid_juego, activo)
    VALUES (_nombre, _descripcion, _fid_juego, _activo);
    SET _id_logro = LAST_INSERT_ID();
END$

CREATE PROCEDURE LISTAR_LOGROS()
BEGIN
    SELECT l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro,
    p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion AS descripcion_producto,
    p.espacio_disco, p.activo AS producto_activo, j.multijugador, j.requisitos_minimos,
    j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = j.id_juego
    WHERE l.activo = 1;
END$

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

CREATE PROCEDURE ELIMINAR_LOGRO(
    IN _id_logro INT
)
BEGIN
    UPDATE Logro
    SET activo = false
    WHERE id_logro = _id_logro;
END$

CREATE PROCEDURE BUSCAR_LOGRO(
    IN _id_logro INT
)
BEGIN
    SELECT l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro,
    l.activo AS logro_activo, p.id_producto, p.titulo, p.fecha_publicacion, p.precio,
    p.descripcion AS descripcion_producto, p.espacio_disco, p.activo AS producto_activo,
    j.multijugador, j.requisitos_minimos, j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = j.id_juego
    WHERE l.id_logro = _id_logro;
END$

CREATE PROCEDURE LISTAR_LOGROS_X_ID_JUEGO(
    IN _id_juego INT
)
BEGIN
    SELECT l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro,
    p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion AS descripcion_producto,
    p.espacio_disco, p.activo AS producto_activo, j.multijugador, j.requisitos_minimos,
    j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = j.id_juego
    WHERE l.activo = 1 AND j.id_juego = _id_juego;
END$

DELIMITER ;
