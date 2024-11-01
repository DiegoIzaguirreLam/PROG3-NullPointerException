DROP PROCEDURE IF EXISTS INSERTAR_BANDASONORA;
DROP PROCEDURE IF EXISTS LISTAR_BANDASSONORAS;
DROP PROCEDURE IF EXISTS ACTUALIZAR_BANDASONORA;
DROP PROCEDURE IF EXISTS ELIMINAR_BANDASONORA;
DROP PROCEDURE IF EXISTS BUSCAR_BANDASONORA;

DELIMITER $

CREATE PROCEDURE INSERTAR_BANDASONORA(
    OUT _id_banda_sonora INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _fecha_publicacion DATE,
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _logo_url VARCHAR(200),
    IN _portada_url VARCHAR(200),
    IN _activo TINYINT,
    IN _artista VARCHAR(100),
    IN _compositor VARCHAR(100),
    IN _duracion TIME
)
BEGIN
    INSERT INTO Producto
    (titulo, fecha_publicacion, precio,
    descripcion, espacio_disco, tipo_producto, logo_url, portada_url, fid_proveedor, activo)
    VALUES (_titulo, _fecha_publicacion, _precio,
    _descripcion, _espacio_disco, 'BANDASONORA', _logo_url, _portada_url, _fid_proveedor, _activo);
    SET _id_banda_sonora = @@last_insert_id;
    INSERT INTO BandaSonora (id_banda_sonora, artista, compositor, duracion)
    VALUES (_id_banda_sonora, _artista, _compositor, _duracion);
END$

CREATE PROCEDURE LISTAR_BANDASSONORAS()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           bs.artista, bs.compositor, bs.duracion, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.activo = 1;
END$

CREATE PROCEDURE ACTUALIZAR_BANDASONORA(
    IN _id_banda_sonora INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _fecha_publicacion DATE,
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _logo_url VARCHAR(200),
    IN _portada_url VARCHAR(200),
    IN _activo TINYINT,
    IN _artista VARCHAR(100),
    IN _compositor VARCHAR(100),
    IN _duracion TIME
)
BEGIN
    UPDATE Producto
    SET titulo = _titulo,
        fecha_publicacion = _fecha_publicacion,
        precio = _precio,
        descripcion = _descripcion,
        espacio_disco = _espacio_disco,
        logo_url = _logo_url,
        portada_url = _portada_url,
        fid_proveedor = _fid_proveedor,
        activo = _activo
    WHERE id_producto = _id_banda_sonora;

    UPDATE BandaSonora
    SET artista = _artista,
        compositor = _compositor,
        duracion = _duracion
    WHERE id_banda_sonora = _id_banda_sonora;
END$

CREATE PROCEDURE ELIMINAR_BANDASONORA(
    IN _id_producto INT
)
BEGIN
    UPDATE Producto SET activo = 0 WHERE id_producto = _id_producto;
END$

CREATE PROCEDURE BUSCAR_BANDASONORA(
    IN _id_producto INT
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco,
           p.logo_url, p.portada_url, p.activo, b.artista, b.compositor, b.duracion,
           pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN BandaSonora b ON p.id_producto = b.id_banda_sonora
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.id_producto = _id_producto;
END$

DELIMITER ;
