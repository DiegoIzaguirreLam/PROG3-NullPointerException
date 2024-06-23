DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS;
DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS_X_ETIQUETA;
DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS_X_TITULO_DESARROLLADOR;
DROP PROCEDURE IF EXISTS BUSCAR_PRODUCTO;
DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS_DESTACADOS;

DELIMITER $

CREATE PROCEDURE LISTAR_PRODUCTOS()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
           bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo as proveedor_activo
    FROM Producto p
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1
    LIMIT 30;
END$

CREATE PROCEDURE LISTAR_PRODUCTOS_X_ETIQUETA(
    IN _id_etiqueta INT
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
           bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo as proveedor_activo
    FROM Producto p
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    INNER JOIN ProductoEtiqueta pe ON pe.fid_producto = p.id_producto
    WHERE p.activo = 1 AND pe.fid_etiqueta = _id_etiqueta;
END$

CREATE PROCEDURE LISTAR_PRODUCTOS_X_TITULO_DESARROLLADOR(
    IN _nombre VARCHAR(100)
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
           bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo as proveedor_activo
    FROM Producto p
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 AND CONCAT(p.titulo,' ',pr.razon_social) LIKE CONCAT('%',_nombre,'%');
END$

CREATE PROCEDURE BUSCAR_PRODUCTO(
    IN _id_producto INT
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
           bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo as proveedor_activo
    FROM Producto p
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 AND p.id_producto = _id_producto;
END$

CREATE PROCEDURE LISTAR_PRODUCTOS_DESTACADOS()
BEGIN
    SELECT p.id_producto, COALESCE(COUNT(pa.fid_producto), 0) as num_adquiridos
	FROM Producto p
	LEFT JOIN ProductoAdquirido pa ON pa.fid_producto = p.id_producto
	GROUP BY p.id_producto
	ORDER BY num_adquiridos DESC
	LIMIT 3;
END$

DELIMITER ;