
DROP PROCEDURE IF EXISTS INSERTAR_BANDASONORA;
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
    (titulo,fecha_publicacion,precio,
    descripcion, espacio_disco, tipo_producto, logo_url, portada_url, fid_proveedor, activo)
    VALUES(_titulo, _fecha_publicacion, _precio,
    _descripcion,_espacio_disco, 'BANDASONORA', _logo_url, _portada_url, _fid_proveedor, _activo);
    SET _id_banda_sonora = @@last_insert_id;
    INSERT INTO BandaSonora(id_banda_sonora, artista,compositor,duracion)
    VALUES(_id_banda_sonora, _artista,_compositor,_duracion);
END$


DROP PROCEDURE IF EXISTS LISTAR_BANDASSONORAS;
DELIMITER $
CREATE PROCEDURE LISTAR_BANDASSONORAS()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           bs.artista, bs.compositor, bs.duracion, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.activo = 1;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_BANDASONORA;
DELIMITER $
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

DROP PROCEDURE IF EXISTS ELIMINAR_BANDASONORA;
DELIMITER $
CREATE PROCEDURE ELIMINAR_BANDASONORA(
	IN _id_producto INT
)
BEGIN
    UPDATE Producto SET activo = 0 WHERE id_producto = _id_producto;
END$

DROP PROCEDURE IF EXISTS BUSCAR_BANDASONORA;
DELIMITER $
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


DROP PROCEDURE IF EXISTS INSERTAR_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE INSERTAR_BIBLIOTECA(
	OUT _id_biblioteca INT,
    IN _fid_usuario INT
)
BEGIN
	INSERT INTO Biblioteca(fid_usuario)
    VALUES (_fid_usuario);
    SET _id_biblioteca = @@last_insert_id;
END$

INSERT INTO Biblioteca(id_biblioteca, fid_usuario) VALUES(1, 1);

SELECT * from ProductoAdquirido;
DROP PROCEDURE IF EXISTS BUSCAR_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE BUSCAR_BIBLIOTECA(
	IN _id_biblioteca INT
)
BEGIN
	SELECT * FROM Biblioteca WHERE id_biblioteca = _id_biblioteca;
END$





DROP PROCEDURE IF EXISTS INSERTAR_COLECCION;
DELIMITER $
CREATE PROCEDURE INSERTAR_COLECCION(
	OUT _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
	INSERT INTO Coleccion(nombre, fid_biblioteca, activo)
    VALUES (_nombre, _fid_biblioteca, 1);
    SET _id_coleccion = @@last_insert_id;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_COLECCION;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_COLECCION(
	IN _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
	UPDATE Coleccion
    SET nombre = _nombre,
		fid_biblioteca = _fid_biblioteca
	WHERE id_coleccion = _id_coleccion;
END$


DROP PROCEDURE IF EXISTS ELIMINAR_COLECCION;
DELIMITER $
CREATE PROCEDURE ELIMINAR_COLECCION(
	IN _id_coleccion INT
)
BEGIN
	UPDATE FROM Coleccion SET activo = false where id_coleccion = _id_coleccion;
END$


DROP PROCEDURE IF EXISTS LISTAR_COLECCIONES;
DELIMITER $
CREATE PROCEDURE LISTAR_COLECCIONES(
	IN _fid_biblioteca INT
)
BEGIN
	SELECT * FROM Coleccion WHERE fid_biblioteca = _fid_biblioteca AND activo=1;
END$

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOSADQUIRIDOS_COLECCION;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOSADQUIRIDOS_COLECCION(
	IN _fid_coleccion INT
)
BEGIN
	SELECT p.titulo as titulo_producto, p.descripcion, p.tipo_producto, pa.fecha_ejecucion, pa.tiempo_uso, pa.actualizado, p.logo_url, p.portada_url
    FROM Coleccion c
    INNER JOIN ProductoAdquirido_Coleccion pc ON c.id_coleccion = pc.fid_coleccion
    INNER JOIN ProductoAdquirido pa ON  pa.id_producto_adquirido = pc.fid_producto_adquirido
    INNER JOIN Producto p ON p.id_producto = pa.fid_producto
    WHERE c.id_coleccion = _fid_coleccion AND pc.activo = 1 AND pa.activo = 1;
END$
DROP PROCEDURE IF EXISTS INSERTAR_ETIQUETA;
DELIMITER $
CREATE PROCEDURE INSERTAR_ETIQUETA(
	OUT _id_etiqueta INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	INSERT INTO Etiqueta(nombre, activo)
    VALUES (_nombre, 1);
    SET _id_etiqueta = @@last_insert_id;
END;

DROP PROCEDURE IF EXISTS LISTAR_ETIQUETAS;
DELIMITER $
CREATE PROCEDURE LISTAR_ETIQUETAS()
BEGIN
	SELECT * FROM Etiqueta;
END;

DROP PROCEDURE IF EXISTS ACTUALIZAR_ETIQUETA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_ETIQUETA(
	IN _id_etiqueta INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	UPDATE Proveedor
    SET nombre = _nombre
    WHERE id_etiqueta = _id_nombre;
END;

DROP PROCEDURE IF EXISTS ELIMINAR_ETIQUETA;
DELIMITER $
CREATE PROCEDURE ELIMINAR_ETIQUETA(
	IN _id_etiqueta INT
)
BEGIN
	UPDATE Etiqueta SET activo = 0 WHERE id_etiqueta = _id_etiqueta;
END;


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
    IN _logo_url VARCHAR(200),
    IN _portada_url VARCHAR(200),
    IN _activo TINYINT,
    IN _requisitos_minimos VARCHAR(200),
    IN _requisitos_recomendados VARCHAR(200),
    IN _multijugador TINYINT
)
BEGIN
	INSERT INTO Producto(titulo,fecha_publicacion,precio,descripcion, espacio_disco,
    tipo_producto, logo_url, portada_url, fid_proveedor, activo) VALUES(_titulo, _fecha_publicacion,
    _precio,_descripcion,_espacio_disco,'JUEGO',logo_url,portada_url,_fid_proveedor, _activo);
    SET _id_juego = @@last_insert_id;
    INSERT INTO Juego(id_juego, requisitos_minimos, requisitos_recomendados,multijugador) VALUES(_id_juego, _requisitos_minimos, _requisitos_recomendados, _multijugador);
END$

DROP PROCEDURE IF EXISTS LISTAR_JUEGOS;
DELIMITER $
CREATE PROCEDURE LISTAR_JUEGOS()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           j.requisitos_minimos, j.requisitos_recomendados, j.multijugador, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN Juego j ON p.id_producto = j.id_juego
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor 
    WHERE p.activo = 1;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_JUEGO;
DELIMITER $
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
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url,
    p.portada_url,a.activo,j.requisitos_minimos, j.requisitos_recomendados, j.multijugador, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN Juego j ON p.id_producto = j.id_juego
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.id_producto = _id_producto;
END$


select * from Logro;
DROP PROCEDURE IF EXISTS INSERTAR_LOGRO;
DELIMITER $
CREATE PROCEDURE INSERTAR_LOGRO(
	OUT _id_logro INT,
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _activo TINYINT,
    IN _fid_juego INT
)
BEGIN
    INSERT INTO Logro(nombre,descripcion,fid_juego, activo) 
    VALUES (_nombre,_descripcion,_fid_juego, _activo);
    SET _id_logro = @@last_insert_id;
END$



DROP PROCEDURE IF EXISTS LISTAR_LOGROS;
DELIMITER $
CREATE PROCEDURE LISTAR_LOGROS()
BEGIN
	SELECT l.id_logro, l.nombre as nombre_logro, l.descripcion as descripcion_logro, p.id_producto, p.titulo,
    p.fecha_publicacion, p.precio, p.descripcion as descripcion_producto, p.espacio_disco, p.activo as producto_activo,
    j.multijugador, j.requisitos_minimos, j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = l.fid_juego
    WHERE l.activo = 1;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRO;
DELIMITER $
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

DROP PROCEDURE IF EXISTS ELIMINAR_LOGRO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_LOGRO(
	IN _id_logro INT
)
BEGIN
	UPDATE Logro
    SET activo = false
    WHERE id_logro = _id_logro;
END$

DROP PROCEDURE IF EXISTS BUSCAR_LOGRO;
DELIMITER $
CREATE PROCEDURE BUSCAR_LOGRO(
	IN _id_logro INT
)
BEGIN
	SELECT l.id_logro, l.nombre as nombre_logro, l.descripcion as descripcion_logro, l.activo as logro_activo, p.id_producto, p.titulo,
    p.fecha_publicacion, p.precio, p.descripcion as descripcion_producto, p.espacio_disco, p.activo as producto_activo,
    j.multijugador, j.requisitos_minimos, j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = l.fid_juego
    WHERE l.id_logro = _id_logro;
END$



DROP PROCEDURE IF EXISTS INSERTAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE INSERTAR_LOGRODESBLOQUEADO(
	OUT _id_logro_desbloqueado INT,
    IN fid_logro INT,
    IN fid_producto_adquirido INT
)
BEGIN
    INSERT INTO Logro(fecha_desbloqueo,fid_logro,fid_producto_adquirido, activo) 
    VALUES (CURDATE(),_fid_logro,_fid_producto_adquirido, 1);
    SET _id_logro_desbloqueado = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS BUSCAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE BUSCAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT
)
BEGIN
	SELECT * FROM LogroDesbloqueado WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$


DROP PROCEDURE IF EXISTS LISTAR_LOGRODESBLOQUEADOPRODUCTO;
DELIMITER $
CREATE PROCEDURE LISTAR_LOGRODESBLOQUEADOPRODUCTO(
	IN _id_producto_adquirido INT
)
BEGIN
	SELECT * FROM LogroDesbloqueado WHERE id_producto_adquirido = _id_producto_adquirido;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT,
    IN _fecha_desbloqueo DATE,
    IN fid_logro INT,
    IN fid_producto_adquirido INT
)
BEGIN
	UPDATE LogroDesbloqueado
    SET fecha_desbloqueo = _fecha_desbloqueado,
		fid_logro = _fid_logro,
        fid_producto_adquirido = _fid_producto_adquirido
	WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT
)
BEGIN
	UPDATE LogroDesbloqueado SET activo = 0 WHERE id_logro_desbloqueado = _id_logro_desbloqueado
END$

DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOS()
BEGIN
	SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_juego, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN Juego j ON p.id_producto = j.id_juego
    INNER JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    INNER JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO(
	OUT _id_producto_adquirido INT,
	IN _fid_biblioteca INT,
	IN _fid_producto INT
)
BEGIN
	INSERT INTO ProductoAdquirido
    (fecha_adquisicion,tiempo_uso,actualizado, oculto,
    fid_biblioteca, fid_producto, fid_expositor, fid_movimiento, activo)
    VALUES(CURDATE(), CAST('00:00:00' AS TIME),false, false,
    _fid_biblioteca,_fid_producto, 1);
	SET _id_producto_adquirido = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOSADQUIRIDOS;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOSADQUIRIDOS(
	IN _id_biblioteca INT
)
BEGIN
	SELECT * FROM ProductoAdquirido WHERE fid_biblioteca = _id_biblioteca;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_PRODUCTOADQUIRIDO;
DELIMITER $
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

DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PRODUCTOADQUIRIDO(
	IN _id_producto_adquirido INT
)
BEGIN
    UPDATE ProductoAdquirido
    SET activo = 0
    WHERE id_producto_adquirido = _id_producto_adquirido; 
END$

DROP PROCEDURE IF EXISTS BUSCAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE BUSCAR_PRODUCTOADQUIRIDO(
	IN _id_producto_adquirido INT
)
BEGIN
    SELECT * FROM ProductoAdquirido WHERE id_producto_adquirido = _id_producto_adquirido;
END$



DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO_COLECCION;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO_COLECCION(
	IN _fid_coleccion INT,
    IN _fid_producto_adquirido INT
)
BEGIN
	INSERT INTO ProductoAdquirido_Coleccion(fid_coleccion, fid_producto_adquirido)
    VALUES (_fid_coleccion, _fid_producto_adquirido, 1);
END$


DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOADQUIRIDO_COLECCION;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PRODUCTOADQUIRIDO_COLECCION(
	IN _fid_coleccion INT,
    IN _fid_producto_adquirido INT
)
BEGIN
	UPDATE ProductoAdquirido_Coleccion
    SET activo = 0
    WHERE fid_coleccion = _fid_coleccion AND fid_producto_adquirido = _fid_producto_adquirido;
END$
DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOETIQUETA(
    IN _fid_producto INT,
    IN _fid_etiqueta INT
)
BEGIN
	INSERT INTO ProductoEtiqueta(fid_producto,fid_etiqueta)
    VALUES(_fid_producto, _fid_etiqueta);
END$

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOETIQUETA()
BEGIN
	SELECT * FROM ProductoEtiqueta;
END$

/*
DROP PROCEDURE IF EXISTS ACTUALIZAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PRODUCTOETIQUETA(
	IN _fid_producto INT,
    IN _fid_etiqueta INT
)
BEGIN
	UPDATE ProductoEtiqueta
    SET fid_producto = _fid_producto,
		fid_etiqueta = _fid_etiqueta
	WHERE fid_producto=_fid_producto and fid_etiqueta = _fid_etiqueta;
END$*/

DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOETIQUETA;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PRODUCTOETIQUETA(
	IN _fid_producto INT,
    IN _fid_etiqueta INT
)
BEGIN
	DELETE FROM ProductoEtiqueta 
    WHERE fid_producto = _fid_producto
    AND fid_etiqueta = _fid_etiqueta;
END$


DROP PROCEDURE IF EXISTS INSERTAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE INSERTAR_PROVEEDOR(
	OUT _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
	INSERT INTO Proveedor(razon_social, activo)
    VALUES (_razon_social, 1);
    SET _id_proveedor = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_PROVEEDORES;
DELIMITER $
CREATE PROCEDURE LISTAR_PROVEEDORES()
BEGIN
	SELECT * FROM Proveedor;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PROVEEDOR(
	IN _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
	UPDATE Proveedor
    SET razon_social = _razon_social
    WHERE id_proveedor = _id_proveedor;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PROVEEDOR(
	IN _id_proveedor INT
)
BEGIN
	UPDATE Proveedor
    SET activo = false
    WHERE id_proveedor = _id_proveedor;
    UPDATE Producto
    SET oculto = true
    WHERE fid_proveedor = _id_proveedor;
END$

DROP PROCEDURE IF EXISTS INSERTAR_SOFTWARE;
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
    (titulo,fecha_publicacion,precio,
    descripcion, espacio_disco, tipo_producto, logo_url, portada_url, activo, fid_proveedor)
    VALUES(_titulo, _fecha_publicacion, _precio,
    _descripcion,_espacio_disco,'SOFTWARE',_logo_url,_portada_url,_activo,_fid_proveedor);
    SET _id_software = @@last_insert_id;
    INSERT INTO Software(id_software, requisitos,licencia)
    VALUES(_id_software, _requisitos,_licencia);
END$


DROP PROCEDURE IF EXISTS LISTAR_SOFTWARES;
DELIMITER $
CREATE PROCEDURE LISTAR_SOFTWARES()
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
           s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social
    FROM Producto p
    INNER JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.activo = 1;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_SOFTWARE;
DELIMITER $
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

DROP PROCEDURE IF EXISTS ELIMINAR_SOFTWARE;
DELIMITER $
CREATE PROCEDURE ELIMINAR_SOFTWARE(
	IN _id_producto INT
)
BEGIN
    UPDATE Producto SET activo = 0 WHERE id_producto = _id_producto;
END$

DROP PROCEDURE IF EXISTS BUSCAR_SOFTWARE;
DELIMITER $
CREATE PROCEDURE BUSCAR_SOFTWARE(
	IN _id_producto INT
)
BEGIN
    SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, portada_url,
           s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, p.activo
    FROM Producto p
    INNER JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON p.fid_proveedor = pr.id_proveedor
    WHERE p.id_producto = _id_producto;
END$


DROP PROCEDURE IF EXISTS CREAR_FORO;
DELIMITER $ 
CREATE PROCEDURE CREAR_FORO(
	OUT _id_foro INT ,
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)

BEGIN
	INSERT INTO foro(nombre,descripcion,
    origen_foro,oculto, activo) VALUES (_nombre,_descripcion,
    _origen_foro,0, 1);
	SET _id_foro = @@last_insert_id;

END $

DROP PROCEDURE IF EXISTS LISTAR_FOROS;
CREATE PROCEDURE LISTAR_FOROS()
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro INNER JOIN ForoUsuario f ON f.fid_foro = id_foro WHERE f.es_creador = 1 AND activo = 1;
END$

DROP PROCEDURE IF EXISTS MOSTRAR_SUBFOROS_POR_FORO;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_SUBFOROS_POR_FORO(
	in _id_foro INT 
)
BEGIN
	SELECT * FROM subforo WHERE fid_foro = _id_foro 
    AND oculto = 0;

END $


DROP PROCEDURE IF EXISTS EDITAR_FORO;
DELIMITER $ 
CREATE PROCEDURE EDITAR_FORO(
	IN _id_foro INT,
	IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)
BEGIN
	UPDATE foro SET nombre = _nombre,
    descripcion = _descripcion,
    origen_foro = _origen_foro 
    WHERE id_foro = _id_foro; 

END $

DROP PROCEDURE IF EXISTS DESACTIVAR_FORO;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE foro SET oculto = 1
    WHERE id_foro = _id_foro; 

END $

DROP PROCEDURE IF EXISTS ELIMINAR_FORO;
DELIMITER $ 
CREATE PROCEDURE ELIMINAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE foro SET activo = 0
    WHERE id_foro = _id_foro; 

END $


DROP PROCEDURE IF EXISTS CREAR_RELACION;
DROP PROCEDURE IF EXISTS ELIMINAR_RELACION;
DELIMITER $
CREATE PROCEDURE CREAR_RELACION(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	INSERT INTO ForoUsuario (fid_foro, fid_usuario, es_creador, es_suscriptor, activo)
	VALUES (_fid_foro, _fid_usuario, 1, 1, 1);
END$
CREATE PROCEDURE SUSCRIBIR_RELACION(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	INSERT INTO ForoUsuario (fid_foro, fid_usuario, es_creador, es_suscriptor, activo)
	VALUES (_fid_foro, _fid_usuario, 0, 1, 1);
END$
CREATE PROCEDURE ELIMINAR_RELACION(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	UPDATE ForoUsuario SET activo=0 
	WHERE fid_foro = _fid_foro AND fid_usuario = _fid_usuario;
END$
CREATE PROCEDURE LISTAR_SUSCRITOS(
	IN _fid_usuario INT
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro INNER JOIN ForoUsuario f ON f.fid_foro = id_foro WHERE fid_usuario = _fid_usuario AND f.es_suscriptor = 1 AND activo = 1;
END$
DROP PROCEDURE IF EXISTS CREAR_GESTOR;
DELIMITER $ 
CREATE PROCEDURE CREAR_GESTOR(
	OUT _id_gestor INT ,
    IN _id_usuario INT,
    IN _contador_faltas INT,
    IN _contador_baneos INT,
    IN _contador_palabras INT,
    IN _max_faltas INT,
    IN _max_baneos INT,
    IN _cant_baneos INT,
    IN _cant_faltas INT,
    IN _fin_ban DATE
)
BEGIN
	INSERT INTO hilo(id_gestor, id_usuario, contador_faltas,
    contador_baneos,contador_palabras,
    max_faltas,max_baneos,
    cant_baneos, cant_faltas,
    fin_ban, activo)
    VALUES (_id_usuario, _id_usuario, _contador_faltas,
    _contador_baneos,contador_palabras,
    _max_faltas,_max_baneos,
    _cant_baneos, _cant_faltas,
    _fin_ban, 1);
	SET _id_gestor = @@last_insert_id;

END $

DROP PROCEDURE IF EXISTS BUSCAR_GESTOR;
DELIMITER $ 
CREATE PROCEDURE BUSCAR_GESTOR(
	in _id_gestor INT 
)
BEGIN
	SELECT * FROM gestorsanciones
    WHERE id_gestor = _id_gestor;

END $


DROP PROCEDURE IF EXISTS EDITAR_GESTOR;
DELIMITER $ 
CREATE PROCEDURE EDITAR_GESTOR(
    IN _id_gestor INT,
    IN _contador_faltas INT,
    IN _contador_baneos INT,
    IN _contador_palabras INT,
    IN _max_faltas INT,
    IN _max_baneos INT,
    IN _cant_baneos INT,
    IN _cant_faltas INT,
    IN _fin_ban DATE
)
BEGIN
	UPDATE gestorsanciones SET
    contador_faltas = _contador_faltas,
    contador_baneos = _contador_baneos,
    contador_palabras = _contador_palabras,
    max_faltas = _max_faltas,
    max_baneos = _max_baneos,
    cant_baneos = _cant_baneos,
    cant_faltas = _cant_faltas,
    fin_ban = _fin_ban
    WHERE id_gestor = _id_gestor; 
END $



/*Pruebas*/


DROP PROCEDURE IF EXISTS CREAR_HILO;
DELIMITER $ 
CREATE PROCEDURE CREAR_HILO(
	OUT _id_hilo INT ,
    IN _id_subforo INT,
    IN _id_usuario INT,
    IN _fijado TINYINT,
    IN _fecha_creacion DATE,
    IN _fecha_modificacion DATE,
	IN _imagen_url VARCHAR(200)
)
BEGIN
	INSERT INTO hilo(fijado,fecha_creacion,
    fecha_modificacion,fid_subforo,fid_creador, imagen_url,
    nro_mensajes,oculto, activo)
    VALUES (_fijado,_fecha_creacion,
    _fecha_modificacion,_id_subforo,
    _id_usuario, _imagen_url, 0,0, 1);
	SET _id_hilo = @@last_insert_id;

END $

DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJES_POR_HILO;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJES_POR_HILO(
	in _id_hilo INT 
)
BEGIN
	SELECT * FROM mensaje WHERE fid_hilo = _id_hilo 
    AND oculto = 0;

END $

DROP PROCEDURE IF EXISTS EDITAR_HILO;
DELIMITER $ 
CREATE PROCEDURE EDITAR_HILO(
	IN _id_hilo INT,
    IN _id_subforo INT,
    IN _fijado TINYINT,
    IN _fecha_modificacion DATE,
	IN _imagen_url VARCHAR(200)
)
BEGIN
	UPDATE hilo SET fijado = _fijado, fid_subforo = _id_subforo,
    fecha_modificacion = _fecha_modificacion , imagen_url = _imagen_url
    WHERE id_hilo = _id_hilo; 
END $



DROP PROCEDURE IF EXISTS DESACTIVAR_HILO;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE hilo SET oculto = 1
    WHERE id_hilo = _id_hilo; 

END $

DROP PROCEDURE IF EXISTS ELIMINAR_HILO;
DELIMITER $ 
CREATE PROCEDURE ELIMINAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE hilo SET activo = 0
    WHERE id_hilo = _id_hilo; 

END $


DROP PROCEDURE IF EXISTS CREAR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE CREAR_SUBFORO(
	OUT _id_subforo INT ,
	IN _id_foro INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	INSERT INTO subforo(fid_foro,nombre,oculto, activo) 
    VALUES (_id_foro,_nombre,0, 1);
	SET _id_subforo = @@last_insert_id;

END $

DROP PROCEDURE IF EXISTS MOSTRAR_HILOS_POR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_HILOS_POR_SUBFORO(
	in _id_subforo INT 
)
BEGIN
	SELECT * FROM hilo WHERE 
    fid_subforo = _id_subforo
    AND oculto = 0;

END $

DROP PROCEDURE IF EXISTS EDITAR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE EDITAR_SUBFORO(
	IN _id_subforo INT,
	IN _nombre VARCHAR(100)
)
BEGIN
	UPDATE subforo SET nombre = _nombre
    WHERE id_subforo = _id_subforo; 

END $

DROP PROCEDURE IF EXISTS DESACTIVAR_SUBFORO;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_SUBFORO(
	IN _id_subforo INT
)
BEGIN
	UPDATE foro SET oculto = 1
    WHERE id_subforo = _id_subforo; 

END $
DROP PROCEDURE IF EXISTS CREAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE CREAR_MENSAJE(
	OUT _id_mensaje INT,
    IN _contenido VARCHAR(300),
    IN _fecha_publicacion DATE,
    IN _fecha_max_edicion DATE,
    IN _padre INT,
    IN _id_hilo INT,
    IN _id_usuario INT
)
BEGIN
	INSERT INTO mensaje(contenido,fecha_publicacion,
    fecha_max_edicion,padre,
    fid_hilo,fid_usuario,oculto, activo)
    VALUES (_contenido,_fecha_publicacion,
    _fecha_max_edicion,_padre,
    _id_hilo,_id_usuario,0, 1);
	SET _id_mensaje = @@last_insert_id;
    UPDATE hilo SET nro_mensajes = nro_mensajes +1 
    WHERE id_hilo = _id_hilo;

END $

DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJE(
	in _id_mensaje INT 
)
BEGIN
	SELECT * FROM mensaje 
    WHERE id_mensaje = _id_mensaje 
    AND oculto = 0;

END $

DROP PROCEDURE IF EXISTS EDITAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE EDITAR_MENSAJE(
	IN _id_mensaje INT,
    IN _id_hilo INT,
    IN _contenido VARCHAR(300),
    IN _fecha_max_edicion DATE
)
BEGIN
	UPDATE mensaje SET contenido = _contenido,
    fid_hilo = _id_hilo,
    fecha_max_edicion = _fecha_max_edicion
    WHERE id_mensaje = _id_mensaje; 
END $

DROP PROCEDURE IF EXISTS DESACTIVAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE mensaje SET oculto = 1
    WHERE id_mensaje = _id_mensaje; 

END $

DROP PROCEDURE IF EXISTS ELIMINAR_MENSAJE;
DELIMITER $ 
CREATE PROCEDURE ELIMINAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE mensaje SET activo = 0
    WHERE id_mensaje = _id_mensaje; 

END $
DROP PROCEDURE IF EXISTS INSERTAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE INSERTAR_COMENTARIO(
	OUT _id_comentario INT,
	IN _fid_perfil_comentado INT,
    IN _fid_usuario_comentarista INT,
	IN _texto VARCHAR(300),
	IN _nro_likes INT,
    IN _fecha_maxedicion DATE
)
BEGIN
	INSERT INTO Comentario(fid_perfil_comentado,fid_usuario_comentarista,texto,nro_likes,fecha_publicacion,fecha_maxedicion,oculto, activo)
    VALUES(_fid_perfil_comentado, _fid_usuario_comentarista, _texto,_nro_likes,CURDATE(),_fecha_maxedicion,false, 1);
    SET _id_comentario = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_COMENTARIOS;
DELIMITER $
CREATE PROCEDURE LISTAR_COMENTARIOS()
BEGIN
    SELECT c.id_comentario, c.nro_likes, c.oculto, c.fecha_publicacion, c.fecha_maxedicion, p.id_perfil, p.oculto as 'perfil_oculto'
    FROM Comentario c
    INNER JOIN Perfil p on p.id_perfil = c.fid_perfil_comentado
    WHERE c.oculto = false;
END$

DROP PROCEDURE IF EXISTS LISTAR_COMENTARIOS_PERFIL;
DELIMITER $
CREATE PROCEDURE LISTAR_COMENTARIOS_PERFIL(
	IN _id_perfil INT
)
BEGIN
    SELECT c.id_comentario, c.nro_likes, c.oculto, c.fecha_publicacion, c.fecha_maxedicion, p.id_perfil, p.oculto as 'perfil_oculto'
    FROM Comentario c
    INNER JOIN Perfil p on p.id_perfil = c.fid_perfil_comentado
    WHERE c.oculto = false
    AND _id_perfil = fid_perfil_comentado;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_COMENTARIO(
    IN _id_comentario INT,
	IN _fid_perfil INT,
    IN _fid_usuario INT,
	IN _texto VARCHAR(300),
	IN _nro_likes INT,
    IN _oculto TINYINT,
    IN _fecha_maxedicion DATE,
    IN _fecha_publicacion DATE
)
BEGIN
    UPDATE Comentario
    SET fid_perfil = _fid_perfil,
		fid_usuario = _fid_usuario,
        texto = _texto,
        nro_likes = _nro_likes,
        oculto = _oculto,
        fecha_publicacion = _fecha_publicacion,
        fecha_maxedicion = _fecha_maxedicion
    WHERE id_comentario = _id_comentario;
END$

DROP PROCEDURE IF EXISTS OCULTAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE OCULTAR_COMENTARIO(
	IN _id_comentario INT
)
BEGIN
    UPDATE Comentario
    SET oculto = true
    WHERE id_comentario = _id_comentario; 
END$

DROP PROCEDURE IF EXISTS ELIMINAR_COMENTARIO;
DELIMITER $
CREATE PROCEDURE OCULTAR_COMENTARIO(
	IN _id_comentario INT
)
BEGIN
    UPDATE Comentario
    SET activo = false
    WHERE id_comentario = _id_comentario; 
END$DROP PROCEDURE IF EXISTS INSERTAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE INSERTAR_EXPOSITOR(
	OUT _id_expositor INT,
	IN _fid_perfil INT
)
BEGIN
	INSERT INTO Expositor(fid_perfil,oculto,activo) VALUES(_fid_perfil,false,true);
    SET _id_expositor = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_EXPOSITORES;
DELIMITER $
CREATE PROCEDURE LISTAR_EXPOSITORES()
BEGIN
    SELECT *
    FROM Expositor
    WHERE activo = 1;
END$

DROP PROCEDURE IF EXISTS LISTAR_EXPOSITORES_PERFIL;
DELIMITER $
CREATE PROCEDURE LISTAR_EXPOSITORES_PERFIL(
	IN id_perfil INT
)
BEGIN
    SELECT *
    FROM Expositor
    WHERE fid_perfil = id_perfil
    AND activo = 1;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_EXPOSITOR(
    IN _id_expositor INT,
    IN _oculto TINYINT,
    IN _activo TINYINT,
    IN _fid_perfil INT
)
BEGIN
    UPDATE Expositor
    SET oculto=_oculto,
		fid_perfil = _fid_perfil,
        activo = _activo
    WHERE id_expositor = _id_expositor;
END$

DROP PROCEDURE IF EXISTS OCULTAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE OCULTAR_EXPOSITOR(
	IN _id_expositor INT
)
BEGIN
    UPDATE Expositor
    SET oculto = true
    WHERE id_expositor = _id_expositor; 
END$

DROP PROCEDURE IF EXISTS ELIMINAR_EXPOSITOR;
DELIMITER $
CREATE PROCEDURE ELIMINAR_EXPOSITOR(
	IN _id_expositor INT
)
BEGIN
    UPDATE Expositor
    SET activo = false
    WHERE id_expositor = _id_expositor; 
END$DROP PROCEDURE IF EXISTS INSERTAR_PERFIL;
DELIMITER $
CREATE PROCEDURE INSERTAR_PERFIL(
	IN _id_perfil INT,
    IN _foto_url VARCHAR(200)
)
BEGIN
	INSERT INTO Perfil(id_perfil, usuario_id, foto_url, oculto) 
    VALUES(_id_perfil, _id_perfil, _foto_url, false);
END$


DROP PROCEDURE IF EXISTS LISTAR_PERFILES;
DELIMITER $
CREATE PROCEDURE LISTAR_PERFILES()
BEGIN
    SELECT *
    FROM Perfil
    WHERE oculto=false;
END$

DROP PROCEDURE IF EXISTS ACTUALIZAR_PERFIL;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PERFIL(
    IN _id_perfil INT,
    IN _foto_url VARCHAR(200),
    IN _oculto TINYINT
)
BEGIN
    UPDATE Perfil
    SET foto_url = _foto_url,
		oculto = _oculto
    WHERE id_perfil = _id_perfil;
END$

DROP PROCEDURE IF EXISTS BUSCAR_PERFIL;
DELIMITER $
CREATE PROCEDURE BUSCAR_PERFIL(
	IN _id_usuario INT
)
BEGIN
	SELECT *
    FROM Perfil
    WHERE id_perfil = _id_usuario; 
END$

DROP PROCEDURE IF EXISTS OCULTAR_PERFIL;
DELIMITER $
CREATE PROCEDURE OCULTAR_PERFIL(
	IN _id_perfil INT
)
BEGIN
    UPDATE Perfil
    SET oculto = true
    WHERE id_perfil = _id_perfil; 
END$DROP PROCEDURE IF EXISTS CREAR_CARTERA;
DELIMITER $
CREATE PROCEDURE CREAR_CARTERA(
	IN _ID_CARTERA INT,
    IN _FONDOS DECIMAL(10, 2),
    IN _CANT_MOVIMIENTOS INT
)
BEGIN
	INSERT INTO Cartera(ID_CARTERA, FONDOS, CANT_MOVIMIENTOS, ACTIVO)
	VALUES (_ID_CARTERA, _FONDOS, _CANT_MOVIMIENTOS, 1);
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ACTUALIZAR_CARTERA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_CARTERA(
	IN _ID_CARTERA INT,
    IN _FONDOS DECIMAL(10, 2),
    IN _CANT_MOVIMIENTOS INT
)
BEGIN
	UPDATE Cartera SET FONDOS = _FONDOS, CANT_MOVIMIENTOS = _CANT_MOVIMIENTOS WHERE ID_CARTERA = _ID_CARTERA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS BUSCAR_CARTERA;
DELIMITER $
CREATE PROCEDURE BUSCAR_CARTERA(
	IN _ID_CARTERA INT
)
BEGIN
	SELECT * FROM Cartera WHERE ID_CARTERA = _ID_CARTERA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS CREAR_MEDALLA;
DELIMITER $
CREATE PROCEDURE CREAR_MEDALLA(
	OUT _ID_MEDALLA INT,
    IN _NOMBRE VARCHAR(100),
    IN _EXPERIENCIA INT
)
BEGIN
	INSERT INTO Medalla(NOMBRE, EXPERIENCIA, ACTIVO)
	VALUES (_NOMBRE, _EXPERIENCIA, 1);
    SET _ID_MEDALLA = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ACTUALIZAR_MEDALLA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_MEDALLA(
	IN _ID_MEDALLA INT,
    IN _NOMBRE VARCHAR(100),
    IN _EXPERIENCIA INT
)
BEGIN
	UPDATE Medalla SET NOMBRE = _NOMBRE, EXPERIENCIA = _EXPERIENCIA WHERE ID_MEDALLA = _ID_MEDALLA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_MEDALLAS;
DELIMITER $
CREATE PROCEDURE LISTAR_MEDALLAS(
)
BEGIN
	SELECT * FROM Medalla;
END $
DELIMITER ;DROP PROCEDURE IF EXISTS CREAR_MOVIMIENTO;
DELIMITER $
CREATE PROCEDURE CREAR_MOVIMIENTO(
	OUT _ID_MOVIMIENTO INT,
    IN _ID_TRANSACCION VARCHAR(100),
    IN _FECHA_TRANSACCION DATE,
    IN _MONTO_PAGO DECIMAL(10, 2),
    IN _TIPO VARCHAR(100),
    IN _METODO_PAGO VARCHAR(100),
    IN _FID_CARTERA INT
)
BEGIN
	INSERT INTO Movimiento(ID_TRANSACCION, FECHA_TRANSACCION, MONTO_PAGO, TIPO, METODO_PAGO, FID_CARTERA)
	VALUES (_ID_TRANSACCION, _FECHA_TRANSACCION, _MONTO_PAGO, _TIPO, _METODO_PAGO, _FID_CARTERA);
	SET _ID_MOVIMIENTO = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_MOVIMIENTOS;
DELIMITER $
CREATE PROCEDURE LISTAR_MOVIMIENTOS(
	IN _FID_CARTERA INT
)
BEGIN
	SELECT * FROM Movimiento WHERE FID_CARTERA = _FID_CARTERA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS BUSCAR_MOVIMIENTO;
DELIMITER $
CREATE PROCEDURE BUSCAR_MOVIMIENTO(
	IN _ID_MOVIMIENTO INT
)
BEGIN
	SELECT * FROM Movimiento WHERE ID_MOVIMIENTO = _ID_MOVIMIENTO;
END $
DELIMITER ;DROP PROCEDURE IF EXISTS CREAR_NOTIFICACION;
DELIMITER $
CREATE PROCEDURE CREAR_NOTIFICACION(
	OUT _ID_NOTIFICACION INT,
    IN _TIPO VARCHAR(30),
    IN _MENSAJE VARCHAR(200),
    IN _FID_USUARIO INT
)
BEGIN
	INSERT INTO Notificacion(TIPO, MENSAJE, FID_USUARIO, REVISADA, ACTIVO)
    VALUES (_TIPO, _MENSAJE, _FID_USUARIO, FALSE, 1);
    SET _ID_NOTIFICACION = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ELIMINAR_NOTIFICACION;
DELIMITER $
CREATE PROCEDURE ELIMINAR_NOTIFICACION(
	IN _ID_NOTIFICACION INT
)
BEGIN
	UPDATE Notificacion SET REVISADA = TRUE WHERE ID_NOTIFICACION = _ID_NOTIFICACION;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ACTUALIZAR_NOTIFICACION;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_NOTIFICACION(
	IN _ID_NOTIFICACION INT,
    IN _TIPO VARCHAR(30),
    IN _MENSAJE VARCHAR(200),
    IN _FID_USUARIO INT
)
BEGIN
	UPDATE Notificacion SET TIPO = _TIPO, MENSAJE = _MENSAJE, FID_USUARIO = _FID_USUARIO WHERE ID_NOTIFICACION = _ID_NOTIFICACION;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_NOTIFICACIONES;
DELIMITER $
CREATE PROCEDURE LISTAR_NOTIFICACIONES(
	IN _FID_USUARIO INT
)
BEGIN
	SELECT * FROM Notificacion WHERE FID_USUARIO = _FID_USUARIO;
END $
DELIMITER ;DROP PROCEDURE IF EXISTS CREAR_PAIS;
DELIMITER $
CREATE PROCEDURE CREAR_PAIS(
	OUT _ID_PAIS INT,
    IN _NOMBRE VARCHAR(100),
    IN _CODIGO VARCHAR(100),
    IN _FID_MONEDA INT
)
BEGIN
	INSERT INTO Pais(NOMBRE, CODIGO, ACTIVO, FID_MONEDA)
    VALUES (_NOMBRE, _CODIGO, 1, _FID_MONEDA);
    SET _ID_PAIS = @@last_insert_id;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS BUSCAR_PAIS;
DELIMITER $
CREATE PROCEDURE BUSCAR_PAIS(
	IN _ID_PAIS INT
)
BEGIN
	SELECT * FROM Pais WHERE ID_PAIS = _ID_PAIS;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PAISES;
DELIMITER $
CREATE PROCEDURE LISTAR_PAISES()
BEGIN
	SELECT p.id_pais, p.nombre as nombre_pais, p.codigo as codigo_pais, m.id_tipo_moneda, 
    m.nombre as nombre_moneda, m.codigo as codigo_moneda, m.cambio_de_dolares, m.fecha_cambio, m.activo as moneda_activa
    FROM Pais p
    INNER JOIN TipoMoneda m ON m.id_tipo_moneda = p.fid_moneda
    WHERE p.activo = 1;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS ACTUALIZAR_PAIS;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PAIS(
	IN _id_pais INT,
    IN _nombre VARCHAR(100),
    IN _codigo VARCHAR(3),
    IN _fid_moneda INT
)
BEGIN
	UPDATE Pais
    SET nombre = _nombre,
		codigo = _codigo,
        fid_moneda = _fid_moneda
    WHERE id_pais = _id_pais;
END $
DELIMITER ;DROP PROCEDURE IF EXISTS AGREGAR_AMIGO;
DROP PROCEDURE IF EXISTS ELIMINAR_AMIGO;
DROP PROCEDURE IF EXISTS BLOQUEAR_USUARIO;

DELIMITER $ 
CREATE PROCEDURE AGREGAR_AMIGO(
	IN _fid_usuario_a INT,
    IN _fid_usuario_b INT 
)
BEGIN
	-- En caso ya exista la relación
	IF EXISTS (SELECT * FROM Relacion WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a)) THEN
        UPDATE Relacion 
        SET amistad = 1, activo = 1
        WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a);
    ELSE
        INSERT INTO Relacion (_fid_usuario_a, _fid_usuario_b, amistad, bloqueo, activo) 
        VALUES (usuario_a, usuario_b, 1, 0, 1);
    END IF;
END $

CREATE PROCEDURE ELIMINAR_AMIGO(
	IN _fid_usuario_a INT,
    IN _fid_usuario_b INT 
)
BEGIN
	UPDATE Relacion 
    SET amistad = 0
    WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a);
END $

CREATE PROCEDURE BLOQUEAR_USUARIO(
	IN _fid_usuario_a INT,
    IN _fid_usuario_b INT 
)
BEGIN
	-- En caso ya exista la relación
	IF EXISTS (SELECT * FROM Relacion WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a)) THEN
        UPDATE Relacion 
        SET bloqueo = 1, activo = 1
        WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a);
    ELSE
        INSERT INTO Relacion (_fid_usuario_a, _fid_usuario_b, amistad, bloqueo, activo) 
        VALUES (usuario_a, usuario_b, 0, 1, 1);
    END IF;
END $DROP PROCEDURE IF EXISTS INSERTAR_TIPOMONEDA;
DELIMITER $
CREATE PROCEDURE INSERTAR_TIPOMONEDA(
	OUT _id_tipo_moneda INT,
	IN _nombre VARCHAR(50),
	IN _codigo VARCHAR(3),
	IN _cambio_de_dolares DECIMAL(10,2)
)
BEGIN
	INSERT INTO TipoMoneda(nombre, codigo, cambio_de_dolares, fecha_cambio, activo)
    VALUES (_nombre, _codigo, _cambio_de_dolares, SYSDATE(), 1);
    SET _id_tipo_moneda = @@last_insert_id;
END$	

DROP PROCEDURE IF EXISTS LISTAR_TIPOMONEDAS;
DELIMITER $
CREATE PROCEDURE LISTAR_TIPOMONEDAS()
BEGIN
	SELECT * FROM TipoMoneda WHERE activo = 1;
END$	

DROP PROCEDURE IF EXISTS ACTUALIZAR_TIPOMONEDA;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_TIPOMONEDA(
	IN _id_tipo_moneda INT,
	IN _nombre VARCHAR(50),
	IN _codigo VARCHAR(3),
	IN _cambio_de_dolares DECIMAL(10,2)
)
BEGIN
	UPDATE TipoMoneda
	SET nombre = _nombre,
		codigo = _codigo,
		cambio_de_dolares = _cambio_de_dolares,
		fecha_cambio = SYSDATE()
	WHERE id_tipo_moneda = _id_tipo_moneda;
END$	

DROP PROCEDURE IF EXISTS ELIMINAR_TIPOMONEDA;
DELIMITER $
CREATE PROCEDURE ELIMINAR_TIPOMONEDA(
	IN _id_tipo_moneda INT
)
BEGIN
	UPDATE TipoMoneda
	SET activo = 0
	WHERE id_tipo_moneda = _id_tipo_moneda;
END$	

DROP PROCEDURE IF EXISTS CREAR_USUARIO;
DELIMITER $
CREATE PROCEDURE CREAR_USUARIO(
	OUT _ID_USUARIO INT,
    IN _NOMBRE_CUENTA VARCHAR(100),
    IN _NOMBRE_PERFIL VARCHAR(100),
    IN _CORREO VARCHAR(100),
    IN _TELEFONO VARCHAR(100),
    IN _CONTRASENIA VARCHAR(100),
    IN _EDAD INT,
    IN _FECHA_NACIMIENTO DATE,
    IN _VERIFICADO TINYINT,
    IN _EXPERIENCIA_NIVEL INT,
    IN _NIVEL INT,
    IN _EXPERIENCIA INT,
    IN _FID_PAIS INT
)
BEGIN
	INSERT INTO Usuario(NOMBRE_CUENTA, NOMBRE_PERFIL, CORREO, TELEFONO,
						CONTRASENIA, EDAD, FECHA_NACIMIENTO, VERIFICADO,
                        EXPERIENCIA_NIVEL, NIVEL, EXPERIENCIA, FID_PAIS, ACTIVO)
	VALUES (_NOMBRE_CUENTA, _NOMBRE_PERFIL, _CORREO, _TELEFONO,
			_CONTRASENIA, _EDAD, _FECHA_NACIMIENTO, _VERIFICADO,
			_EXPERIENCIA_NIVEL, _NIVEL, _EXPERIENCIA, _FID_PAIS, true);
    SET _ID_USUARIO = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ACTUALIZAR_USUARIO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_USUARIO(
	IN _ID_USUARIO INT,
    IN _NOMBRE_CUENTA VARCHAR(100),
    IN _NOMBRE_PERFIL VARCHAR(100),
    IN _CORREO VARCHAR(100),
    IN _TELEFONO VARCHAR(100),
    IN _CONTRASENIA VARCHAR(100),
    IN _EDAD INT,
    IN _FECHA_NACIMIENTO DATE,
    IN _VERIFICADO TINYINT,
    IN _EXPERIENCIA_NIVEL INT,
    IN _NIVEL INT,
    IN _EXPERIENCIA INT,
    IN _FID_PAIS INT
)
BEGIN
	UPDATE Usuario SET NOMBRE_CUENTA = _NOMBRE_CUENTA, NOMBRE_PERFIL = _NOMBRE_PERFIL,
					   CORREO = _CORREO, TELEFONO = _TELEFONO, CONTRASENIA = _CONTRASENIA,
                       EDAD = _EDAD, FECHA_NACIMIENTO = _FECHA_NACIMIENTO, VERIFICADO = _VERIFICADO,
                       EXPERIENCIA_NIVEL = _EXPERIENCIA_NIVEL, NIVEL = _NIVEL, EXPERIENCIA = _EXPERIENCIA,
                       FID_PAIS = _FID_PAIS
	WHERE UID = _ID_USUARIO;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS SUSPENDER_USUARIO;
DELIMITER $
CREATE PROCEDURE SUSPENDER_USUARIO(
	IN _ID_USUARIO INT
)
BEGIN
	UPDATE Usuario SET ACTIVO = NOT ACTIVO WHERE UID = _ID_USUARIO;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ELIMINAR_USUARIO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_USUARIO(
	IN _ID_USUARIO INT
)
BEGIN
	DELETE FROM Usuario WHERE UID = _ID_USUARIO;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_USUARIO;
DELIMITER $
CREATE PROCEDURE LISTAR_USUARIO()
BEGIN
	SELECT * FROM Usuario;
END $
DELIMITER ;