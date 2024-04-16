
DROP PROCEDURE IF EXISTS INSERTAR_BANDASONORA;
DELIMITER $
CREATE PROCEDURE INSERTAR_BANDASONORA(
	OUT _id_banda_sonora INT,
	IN _fid_proveedor INT,
	IN _titulo VARCHAR(100),
	IN _precio DECIMAL(5,2),
	IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _oculto TINYINT,
    IN _artista VARCHAR(100),
    IN _compositor VARCHAR(100),
    IN _duracion TIME
)
BEGIN
	INSERT INTO Producto
    (titulo,fecha_publicacion,precio,
    descripcion, espacio_disco, oculto, fid_proveedor)
    VALUES(_titulo, _fecha_publicacion, _precio,
    _descripcion,_espacio_disco, _oculto, _fid_proveedor);
    SET _id_banda_sonora = @@last_insert_id;
    INSERT INTO BandaSonora(id_banda_sonora,artista,compositor,duracion)
    VALUES(_id_banda_sonora,_artista,_compositor,_duracion);
END$

DROP PROCEDURE IF EXISTS LISTAR_BANDASONORAS;
DELIMITER $
CREATE PROCEDURE LISTAR_BANDASONORA()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco,
           bs.artista, bs.compositor, bs.duracion
    FROM Producto p
    INNER JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_BANDASONORA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_BANDASONORA(
    IN _id_banda_sonora INT,
    IN _titulo VARCHAR(100),
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _oculto TINYINT,
    IN _artista VARCHAR(100),
    IN _compositor VARCHAR(100),
    IN _duracion TIME
)
BEGIN
    UPDATE Producto
    SET titulo = _titulo,
        precio = _precio,
        descripcion = _descripcion,
        espacio_disco = _espacio_disco,
        oculto = _oculto
    WHERE id_producto = _id_banda_sonora;

    UPDATE BandaSonora
    SET artista = _artista,
        compositor = _compositor,
        duracion = _duracion
    WHERE id_banda_sonora = _id_banda_sonora;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_BANDASONORA;
DELIMITER $
CREATE PROCEDURE ELIMINAR_BANDASONORA(
	IN _id_producto INT
)
BEGIN
    UPDATE Producto
    SET oculto = true
    WHERE id_producto = _id_producto; 
END$


DROP PROCEDURE IF EXISTS BUSCAR_BANDASONORA;
DELIMITER $
CREATE PROCEDURE BUSCAR_BANDASONORA(
	IN _id_producto INT
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco,
           b.artista, b.compositor, b.duracion
    FROM Producto p
    INNER JOIN BandaSonora b ON p.id_producto = b.id_banda_sonora
    WHERE id_producto = _id_producto;
END$
