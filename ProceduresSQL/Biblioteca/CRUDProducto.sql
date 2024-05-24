DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOS()
BEGIN
	SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social
    FROM Producto p
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS BUSCAR_PRODUCTO;
DELIMITER $
CREATE PROCEDURE BUSCAR_PRODUCTO(
	IN _id_producto INT
)
BEGIN
	SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo
    FROM Producto p
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 and p.id_producto = _id_producto;
END$
DELIMITER ;
