DROP PROCEDURE IF EXISTS INSERTAR_JUEGO;
DROP PROCEDURE IF EXISTS LISTAR_JUEGOS;
DROP PROCEDURE IF EXISTS ACTUALIZAR_JUEGO;
DROP PROCEDURE IF EXISTS ELIMINAR_JUEGO;
DROP PROCEDURE IF EXISTS BUSCAR_JUEGO;

DELIMITER $

CREATE PROCEDURE INSERTAR_JUEGO(
    OUT _id_juego INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _fecha_publicacion DATE,
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _logo_url VARCHAR(200),
    IN _portada_url VARCHAR(200),
    IN _activo TINYINT,
    IN _requisitos_minimos VARCHAR(200),
    IN _requisitos_recomendados VARCHAR(200),
    IN _multijugador TINYINT
)
BEGIN
    -- Insertar producto (juego)
    INSERT INTO Producto(titulo, fecha_publicacion, precio, descripcion, espacio_disco, tipo_producto, logo_url, portada_url, fid_proveedor, activo)
    VALUES (_titulo, _fecha_publicacion, _precio, _descripcion, _espacio_disco, 'JUEGO', _logo_url, _portada_url, _fid_proveedor, _activo);
    
    -- Obtener el ID del juego insertado
    SET _id_juego = @@last_insert_id;
    
    -- Insertar detalles del juego
    INSERT INTO Juego(id_juego, requisitos_minimos, requisitos_recomendados, multijugador)
    VALUES (_id_juego, _requisitos_minimos, _requisitos_recomendados, _multijugador);
END$

CREATE PROCEDURE LISTAR_JUEGOS()
BEGIN
    -- Listar todos los juegos activos con detalles
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           j.requisitos_minimos, j.requisitos_recomendados, j.multijugador, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN Juego j ON p.id_producto = j.id_juego
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.activo = 1;
END$

CREATE PROCEDURE ACTUALIZAR_JUEGO(
    IN _id_juego INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _fecha_publicacion DATE,
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _logo_url VARCHAR(200),
    IN _portada_url VARCHAR(200),
    IN _activo TINYINT,
    IN _requisitos_minimos VARCHAR(200),
    IN _requisitos_recomendados VARCHAR(200),
    IN _multijugador TINYINT
)
BEGIN
    -- Actualizar información del producto (juego)
    UPDATE Producto
    SET titulo = _titulo,
        fecha_publicacion = _fecha_publicacion,
        precio = _precio,
        descripcion = _descripcion,
        espacio_disco = _espacio_disco,
        logo_url = _logo_url,
        portada_url = _portada_url,
        activo = _activo,
        fid_proveedor = _fid_proveedor
    WHERE id_producto = _id_juego;

    -- Actualizar detalles del juego
    UPDATE Juego
    SET requisitos_minimos = _requisitos_minimos,
        requisitos_recomendados = _requisitos_recomendados,
        multijugador = _multijugador
    WHERE id_juego = _id_juego;
END$

CREATE PROCEDURE ELIMINAR_JUEGO(
    IN _id_producto INT
)
BEGIN
    -- Desactivar el juego (marcar como no activo)
    UPDATE Producto SET activo = 0 WHERE id_producto = _id_producto;
END$

CREATE PROCEDURE BUSCAR_JUEGO(
    IN _id_producto INT
)
BEGIN
    -- Buscar un juego por su ID de producto
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url,
           p.portada_url, p.activo, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
           pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN Juego j ON p.id_producto = j.id_juego
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.id_producto = _id_producto;
END$

DELIMITER ;