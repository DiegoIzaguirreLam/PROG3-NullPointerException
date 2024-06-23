DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO;
DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOSADQUIRIDOS_X_ID_BIBLIOTECA;
DROP PROCEDURE IF EXISTS ACTUALIZAR_PRODUCTOADQUIRIDO;
DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOADQUIRIDO;
DROP PROCEDURE IF EXISTS BUSCAR_PRODUCTOADQUIRIDO;
DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOSADQUIRIDOS_X_ID_COLECCION;

DELIMITER $

CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO(
    OUT _id_producto_adquirido INT,
    IN _fid_biblioteca INT,
    IN _fid_producto INT,
    IN _fid_movimiento INT
)
BEGIN
    INSERT INTO ProductoAdquirido (fecha_adquisicion, tiempo_uso, actualizado, oculto, fid_biblioteca, fid_producto, fid_movimiento, activo)
    VALUES (CURDATE(), CAST('00:00:00' AS TIME), false, false, _fid_biblioteca, _fid_producto, _fid_movimiento, 1);
    SET _id_producto_adquirido = LAST_INSERT_ID();
END$

CREATE PROCEDURE LISTAR_PRODUCTOSADQUIRIDOS_X_ID_BIBLIOTECA(
    IN _id_biblioteca INT
)
BEGIN
    SELECT pa.id_producto_adquirido, pa.fecha_adquisicion, pa.fecha_ejecucion, pa.tiempo_uso, pa.actualizado,
    pa.oculto, pa.fid_biblioteca, p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo AS proveedor_activo, pa.fid_biblioteca AS id_biblioteca
    FROM ProductoAdquirido pa
    INNER JOIN Producto p ON p.id_producto = pa.fid_producto
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 AND pa.fid_biblioteca = _id_biblioteca;
END$

CREATE PROCEDURE ACTUALIZAR_PRODUCTOADQUIRIDO(
    IN _id_producto_adquirido INT,
    IN _fecha_adquisicion DATE,
    IN _fecha_ejecucion DATE,
    IN _tiempo_uso TIME,
    IN _actualizado TINYINT,
    IN _oculto TINYINT,
    IN _fid_biblioteca INT,
    IN _fid_producto INT
)
BEGIN
    UPDATE ProductoAdquirido
    SET fecha_adquisicion = _fecha_adquisicion,
        fecha_ejecucion = _fecha_ejecucion,
        tiempo_uso = _tiempo_uso,
        actualizado = _actualizado,
        oculto = _oculto,
        fid_biblioteca = _fid_biblioteca,
        fid_producto = _fid_producto
    WHERE id_producto_adquirido = _id_producto_adquirido;
END$

CREATE PROCEDURE ELIMINAR_PRODUCTOADQUIRIDO(
    IN _id_producto_adquirido INT
)
BEGIN
    UPDATE ProductoAdquirido
    SET activo = 0
    WHERE id_producto_adquirido = _id_producto_adquirido; 
END$

CREATE PROCEDURE BUSCAR_PRODUCTOADQUIRIDO(
    IN _id_producto_adquirido INT
)
BEGIN
    SELECT * FROM ProductoAdquirido WHERE id_producto_adquirido = _id_producto_adquirido;
END$

CREATE PROCEDURE LISTAR_PRODUCTOSADQUIRIDOS_X_ID_COLECCION(
    IN _id_coleccion INT
)
BEGIN
    SELECT pa.id_producto_adquirido, pa.fecha_adquisicion, pa.fecha_ejecucion, pa.tiempo_uso, pa.actualizado,
    pa.oculto, pa.fid_biblioteca, p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo AS proveedor_activo, pa.fid_biblioteca AS id_biblioteca
    FROM ProductoAdquirido_Coleccion pac
    INNER JOIN ProductoAdquirido pa ON pac.fid_producto_adquirido = pa.id_producto_adquirido
    INNER JOIN Producto p ON p.id_producto = pa.fid_producto
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 AND pac.fid_coleccion = _id_coleccion AND pa.activo = 1 AND pac.activo = 1;
END$

DELIMITER ;