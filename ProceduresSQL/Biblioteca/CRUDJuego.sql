

DROP PROCEDURE IF EXISTS INSERTAR_JUEGO;
DELIMITER $
CREATE PROCEDURE INSERTAR_JUEGO(
    OUT _id_juego INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _fecha_publicacion DATE,
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _oculto TINYINT,
    IN _requisitos_minimos VARCHAR(200),
    IN _requisitos_recomendados VARCHAR(200),
    IN _multijugador TINYINT
)
BEGIN
	INSERT INTO Producto(titulo,fecha_publicacion,precio,descripcion, espacio_disco, oculto, fid_proveedor, activo) VALUES(_titulo, _fecha_publicacion, _precio,_descripcion,_espacio_disco,_oculto,_fid_proveedor, 1);
    SET _id_juego = @@last_insert_id;
    INSERT INTO Juego(id_juego, requisitos_minimos, requisitos_recomendados,multijugador) VALUES(_id_juego, _requisitos_minimos, _requisitos_recomendados, _multijugador);
END$

DROP PROCEDURE IF EXISTS LISTAR_JUEGOS;
DELIMITER $
CREATE PROCEDURE LISTAR_JUEGO()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco,
           j.requisitos_minimos, j.requisitos_recomendados, j.multijugador
    FROM Producto p
    INNER JOIN Juego j ON p.id_producto = j.id_juego;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_JUEGO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_JUEGO(
    IN _id_juego INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _oculto TINYINT,
    IN _requisitos_minimos VARCHAR(200),
    IN _requisitos_recomendados VARCHAR(200),
    IN _multijugador TINYINT
)
BEGIN
    UPDATE Producto
    SET titulo = _titulo,
        precio = _precio,
        descripcion = _descripcion,
        espacio_disco = _espacio_disco,
        oculto = _oculto,
        fid_proveedor = _fid_proveedor
    WHERE id_producto = _id_juego;

    UPDATE Juego
    SET requisitos_minimos = _requisitos_minimos,
        requisitos_recomendados = _requisitos_recomendados,
        multijugador = _multijugador
    WHERE id_juego = _id_juego;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_JUEGO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_JUEGO(
	IN _id_producto INT
)
BEGIN
	UPDATE Producto SET activo = 0 WHERE id_producto = _id_producto;
END$

DROP PROCEDURE IF EXISTS BUSCAR_JUEGO;
DELIMITER $
CREATE PROCEDURE BUSCAR_JUEGO(
	IN _id_producto INT
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.activo,
           j.requisitos_minimos, j.requisitos_recomendados, j.multijugador
    FROM Producto p
    INNER JOIN Juego j ON p.id_producto = j.id_juego
    WHERE id_producto = _id_producto;
END$

SELECT * FROM Producto p INNER JOIN Juego j ON p.id_producto = j.id_juego;
SELECT * FROM Juego;
