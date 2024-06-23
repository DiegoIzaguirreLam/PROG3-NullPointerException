DROP PROCEDURE IF EXISTS INSERTAR_SOFTWARE;
DROP PROCEDURE IF EXISTS LISTAR_SOFTWARES;
DROP PROCEDURE IF EXISTS ACTUALIZAR_SOFTWARE;
DROP PROCEDURE IF EXISTS ELIMINAR_SOFTWARE;
DROP PROCEDURE IF EXISTS BUSCAR_SOFTWARE;

DELIMITER $

CREATE PROCEDURE INSERTAR_SOFTWARE(
    OUT _id_software INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _fecha_publicacion DATE,
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _logo_url VARCHAR(200),
    IN _portada_url VARCHAR(200),
    IN _activo TINYINT,
    IN _requisitos VARCHAR(200),
    IN _licencia VARCHAR(40)
)
BEGIN
    INSERT INTO Producto
    (titulo, fecha_publicacion, precio,
    descripcion, espacio_disco, tipo_producto, logo_url, portada_url, activo, fid_proveedor)
    VALUES (_titulo, _fecha_publicacion, _precio,
    _descripcion, _espacio_disco, 'SOFTWARE', _logo_url, _portada_url, _activo, _fid_proveedor);
    SET _id_software = @@last_insert_id;
    INSERT INTO Software (id_software, requisitos, licencia)
    VALUES (_id_software, _requisitos, _licencia);
END$

CREATE PROCEDURE LISTAR_SOFTWARES()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.activo = 1;
END$

CREATE PROCEDURE ACTUALIZAR_SOFTWARE(
    IN _id_software INT,
    IN _fid_proveedor INT,
    IN _titulo VARCHAR(100),
    IN _fecha_publicacion DATE,
    IN _precio DECIMAL(5,2),
    IN _descripcion VARCHAR(100),
    IN _espacio_disco DECIMAL(5,2),
    IN _logo_url VARCHAR(200),
    IN _portada_url VARCHAR(200),
    IN _activo TINYINT,
    IN _requisitos VARCHAR(200),
    IN _licencia VARCHAR(40)
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
        activo = _activo,
        fid_proveedor = _fid_proveedor
    WHERE id_producto = _id_software;

    UPDATE Software
    SET requisitos = _requisitos,
        licencia = _licencia
    WHERE id_software = _id_software;
END$

CREATE PROCEDURE ELIMINAR_SOFTWARE(
    IN _id_producto INT
)
BEGIN
    UPDATE Producto SET activo = 0 WHERE id_producto = _id_producto;
END$

CREATE PROCEDURE BUSCAR_SOFTWARE(
    IN _id_producto INT
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, p.activo
    FROM Producto p
    INNER JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.id_producto = _id_producto;
END$

DELIMITER ;
