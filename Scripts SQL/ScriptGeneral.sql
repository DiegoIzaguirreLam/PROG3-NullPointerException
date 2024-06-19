/* DROPS  */
DROP TABLE IF EXISTS Relacion;
DROP TABLE IF EXISTS MedallaUsuario;
DROP TABLE IF EXISTS ForoUsuario;
DROP TABLE IF EXISTS ProductoEtiqueta;
DROP TABLE IF EXISTS ProductoAdquirido_Coleccion;
DROP TABLE IF EXISTS LogroDesbloqueado;
DROP TABLE IF EXISTS Logro;
DROP TABLE IF EXISTS Juego;
DROP TABLE IF EXISTS Software;
DROP TABLE IF EXISTS BandaSonora;
DROP TABLE IF EXISTS ProductoAdquirido;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Coleccion;
DROP TABLE IF EXISTS Biblioteca;
DROP TABLE IF EXISTS Etiqueta;
DROP TABLE IF EXISTS GestorSanciones;
DROP TABLE IF EXISTS Mensaje;
DROP TABLE IF EXISTS Hilo;
DROP TABLE IF EXISTS Subforo;
DROP TABLE IF EXISTS Foro;
DROP TABLE IF EXISTS Perfil;
DROP TABLE IF EXISTS Medalla;
DROP TABLE IF EXISTS Movimiento;
DROP TABLE IF EXISTS Cartera;
DROP TABLE IF EXISTS Notificacion;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Pais;
DROP TABLE IF EXISTS TipoMoneda;
DROP TABLE IF EXISTS PalabrasProhibidas;

/* CREACION DE TABLAS */
/* PAQUETE USUARIO */
CREATE TABLE TipoMoneda(
	id_tipo_moneda INT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	codigo CHAR(3) NOT NULL,
	simbolo CHAR(3) NOT NULL,
	cambio_de_dolares DECIMAL(10,2) NOT NULL,
	fecha_cambio DATE NOT NULL,
	activo TINYINT NOT NULL,
	PRIMARY KEY(id_tipo_moneda)
)ENGINE=InnoDB;

CREATE TABLE Pais(
	id_pais INT AUTO_INCREMENT,
	fid_moneda INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    codigo CHAR(3) NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_pais),
	FOREIGN KEY(fid_moneda) REFERENCES TipoMoneda(id_tipo_moneda)
)ENGINE=InnoDB;

CREATE TABLE Usuario(
    UID INT AUTO_INCREMENT NOT NULL,
    nombre_cuenta VARCHAR(100) UNIQUE NOT NULL,
    nombre_perfil VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    contrasenia VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    verificado TINYINT NOT NULL,
    fid_pais INT NOT NULL,
    activo TINYINT NOT NULL,
    foto_url VARCHAR(200) DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
    PRIMARY KEY(UID),
    FOREIGN KEY(fid_pais) REFERENCES Pais(id_pais)
) ENGINE=InnoDB;

CREATE TABLE Relacion (
    id_relacion INT AUTO_INCREMENT PRIMARY KEY,
    fid_usuario_actuador INT NOT NULL,
    fid_usuario_destino INT NOT NULL,
    tipo_relacion ENUM('amistad', 'bloqueo') NOT NULL,
    fecha_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin DATETIME DEFAULT NULL,
    activo TINYINT DEFAULT 1,
    FOREIGN KEY (fid_usuario_actuador) REFERENCES Usuario(UID),
    FOREIGN KEY (fid_usuario_destino) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Notificacion(
	id_notificacion INT AUTO_INCREMENT,
    tipo VARCHAR(30) NOT NULL,
    mensaje VARCHAR(200) NOT NULL,
    fid_usuario INT NOT NULL,
	revisada BOOLEAN NOT NULL,
	activo TINYINT NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY(id_notificacion),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

/* PAQUETE JUGADOR */
CREATE TABLE Cartera(
	id_cartera INT AUTO_INCREMENT,
    fid_usuario INT,
    fondos DECIMAL(10,2) NOT NULL,
    cantidad_movimientos INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_cartera),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Movimiento(
	id_movimiento INT AUTO_INCREMENT,
    id_transaccion VARCHAR(100) NOT NULL,
    fecha_transaccion DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    metodo_pago VARCHAR(100),
	activo TINYINT NOT NULL,
    fid_cartera INT NOT NULL,
    PRIMARY KEY(id_movimiento),
    FOREIGN KEY(fid_cartera) REFERENCES Cartera(id_cartera)
)ENGINE=InnoDB;

/*PAQUETE COMUNIDAD*/
CREATE TABLE Foro(
	id_foro INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    origen_foro VARCHAR(100) NOT NULL,
    oculto TINYINT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_foro)
)ENGINE=InnoDB;

/* Crear tabla Foro_Usuario */
CREATE TABLE ForoUsuario(
	id_Relacion_ForoUsuario INT AUTO_INCREMENT,
	fid_foro INT NOT NULL,
	fid_usuario INT NOT NULL,
	es_creador TINYINT NOT NULL,
	es_suscriptor TINYINT NOT NULL,
	activo TINYINT NOT NULL,
	PRIMARY KEY(id_Relacion_ForoUsuario),
	FOREIGN KEY(fid_foro) REFERENCES Foro(id_foro),
	FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;


CREATE TABLE Subforo(
	id_subforo INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    fid_foro int NOT NULL,
    oculto TINYINT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_subforo),
    FOREIGN KEY(fid_foro) REFERENCES Foro(id_foro)
)ENGINE=InnoDB;

CREATE TABLE Hilo(
	id_hilo INT AUTO_INCREMENT,
    fijado TINYINT NOT NULL,
    nro_mensajes INT NOT NULL,
    fecha_creacion DATE NOT NULL,
    fecha_modificacion DATE NOT NULL,
	imagen_url VARCHAR(200) NOT NULL,
    fid_subforo INT NOT NULL,
    fid_creador INT NOT NULL,
    oculto TINYINT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_hilo),
    FOREIGN KEY(fid_subforo) REFERENCES Subforo(id_subforo),
    FOREIGN KEY(fid_creador) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Mensaje(
	id_mensaje INT AUTO_INCREMENT,
    contenido VARCHAR(300) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    oculto TINYINT NOT NULL,
    fecha_max_edicion DATE,
    padre INT NULL,
    fid_hilo INT NOT NULL,
    fid_usuario INT NOT NULL,
	activo INT NOT NULL,
    PRIMARY KEY(id_mensaje),
    FOREIGN KEY(fid_hilo) REFERENCES Hilo(id_hilo),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID),
    FOREIGN KEY(padre) REFERENCES Mensaje(id_mensaje)
)ENGINE=InnoDB;

CREATE TABLE GestorSanciones(
	id_gestor INT AUTO_INCREMENT,
	fid_usuario INT UNIQUE,
    fin_ban DATE NULL,
    cant_faltas INT NOT NULL,
    cant_baneos INT NOT NULL,
    contador_faltas INT NOT NULL,
    contador_palabras INT NOT NULL,
    contador_baneos INT NOT NULL,
    max_faltas INT NOT NULL,
    max_baneos INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_gestor),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

/*PAQUETE BIBLIOTECA*/
CREATE TABLE Biblioteca(
	id_biblioteca INT AUTO_INCREMENT,
	fid_usuario INT,
    PRIMARY KEY(id_biblioteca),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Coleccion(
	id_coleccion INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    fid_biblioteca INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_coleccion),
    FOREIGN KEY(fid_biblioteca) REFERENCES Biblioteca(id_biblioteca)
)ENGINE=InnoDB;

/*PAQUETE PRODUCTO*/
CREATE TABLE Proveedor(
	id_proveedor INT AUTO_INCREMENT,
    razon_social VARCHAR(100) NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_proveedor)
)ENGINE=InnoDB;

CREATE TABLE Etiqueta(
	id_etiqueta INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_etiqueta)
)ENGINE=InnoDB;

CREATE TABLE Producto(
	id_producto INT AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    precio DECIMAL(5,2) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    espacio_disco DECIMAL(10,2) NOT NULL,
    logo_url VARCHAR(200) NOT NULL,
    portada_url VARCHAR(200) NOT NULL,
    tipo_producto ENUM('JUEGO', 'BANDASONORA', 'SOFTWARE'),
    fid_proveedor INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_producto),
    FOREIGN KEY(fid_proveedor) REFERENCES Proveedor(id_proveedor)
)ENGINE=InnoDB;

CREATE TABLE ProductoEtiqueta(
	fid_producto INT NOT NULL,
	fid_etiqueta INT NOT NULL,
	activo TINYINT NOT NULL,
	PRIMARY KEY(fid_producto, fid_etiqueta),
	FOREIGN KEY(fid_producto) REFERENCES Producto(id_producto),
	FOREIGN KEY(fid_etiqueta) REFERENCES Etiqueta(id_etiqueta)
)ENGINE=InnoDB;

CREATE TABLE ProductoAdquirido(
	id_producto_adquirido INT AUTO_INCREMENT,
    fecha_adquisicion DATE NOT NULL,
    fecha_ejecucion DATE,
    tiempo_uso TIME NOT NULL,
    actualizado TINYINT NOT NULL,
    oculto TINYINT NOT NULL,
    fid_biblioteca INT NOT NULL,
    fid_producto INT NOT NULL,
    fid_movimiento INT,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_producto_adquirido),
    FOREIGN KEY(fid_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY(fid_biblioteca) REFERENCES Biblioteca(id_biblioteca),
    FOREIGN KEY(fid_movimiento) REFERENCES Movimiento(id_movimiento)
)ENGINE=InnoDB;

CREATE TABLE ProductoAdquirido_Coleccion (
    fid_coleccion INT NOT NULL,
    fid_producto_adquirido INT NOT NULL,
	activo TINYINT NOT NULL,
	PRIMARY KEY(fid_coleccion, fid_producto_adquirido),
	FOREIGN KEY(fid_coleccion) REFERENCES Coleccion(id_coleccion),
	FOREIGN KEY(fid_producto_adquirido) REFERENCES ProductoAdquirido(id_producto_adquirido)
)ENGINE=InnoDB;

CREATE TABLE Juego(
	id_juego INT,
    requisitos_minimos VARCHAR(200),
    requisitos_recomendados VARCHAR(200),
    multijugador TINYINT NOT NULL,
    PRIMARY KEY(id_juego),
    FOREIGN KEY(id_juego) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE Software(
	id_software INT,
    requisitos VARCHAR(200),
    licencia VARCHAR(40) NOT NULL,
    PRIMARY KEY(id_software),
    FOREIGN KEY(id_software) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE BandaSonora(
	id_banda_sonora INT,
    artista VARCHAR(100) NOT NULL,
    compositor VARCHAR(100) NOT NULL,
    duracion TIME NOT NULL,
    PRIMARY KEY(id_banda_sonora),
    FOREIGN KEY(id_banda_sonora) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE Logro(
	id_logro INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    fid_juego INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_logro),
    FOREIGN KEY(fid_juego) REFERENCES Juego(id_juego)
)ENGINE=InnoDB;

CREATE TABLE LogroDesbloqueado(
	id_logro_desbloqueado INT AUTO_INCREMENT,
    fecha_desbloqueo DATE NOT NULL,
	fid_logro INT NOT NULL,
	fid_producto_adquirido INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_logro_desbloqueado),
	FOREIGN KEY(fid_logro) REFERENCES Logro(id_logro),
	FOREIGN KEY(fid_producto_adquirido) REFERENCES ProductoAdquirido(id_producto_adquirido)
)ENGINE=InnoDB;

CREATE TABLE PalabrasProhibidas(
	id_palabra INT AUTO_INCREMENT,
	palabra VARCHAR(100) NOT NULL,
	PRIMARY KEY(id_palabra)
)ENGINE=InnoDB;

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


DROP PROCEDURE IF EXISTS BUSCAR_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE BUSCAR_BIBLIOTECA(
	IN _fid_usuario INT
)
BEGIN
	SELECT * FROM Biblioteca WHERE fid_usuario = _fid_usuario;
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
	UPDATE Coleccion SET activo = false where id_coleccion = _id_coleccion;
END$


DROP PROCEDURE IF EXISTS LISTAR_COLECCIONES;
DELIMITER $
CREATE PROCEDURE LISTAR_COLECCIONES(
	IN _fid_biblioteca INT
)
BEGIN
	SELECT * FROM Coleccion WHERE fid_biblioteca = _fid_biblioteca AND activo=1;
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
    _precio,_descripcion,_espacio_disco,'JUEGO',_logo_url,_portada_url,_fid_proveedor, _activo);
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

DROP PROCEDURE IF EXISTS LISTAR_LOGROS_X_ID_JUEGO;
DELIMITER $
CREATE PROCEDURE LISTAR_LOGROS_X_ID_JUEGO(
	IN _id_juego INT
)
BEGIN
	SELECT l.id_logro, l.nombre as nombre_logro, l.descripcion as descripcion_logro, p.id_producto, p.titulo,
    p.fecha_publicacion, p.precio, p.descripcion as descripcion_producto, p.espacio_disco, p.activo as producto_activo,
    j.multijugador, j.requisitos_minimos, j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = l.fid_juego
    WHERE l.activo = 1 AND j.id_juego=_id_juego;
END$


DROP PROCEDURE IF EXISTS INSERTAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE INSERTAR_LOGRODESBLOQUEADO(
	OUT _id_logro_desbloqueado INT,
    IN _fid_logro INT,
    IN _fid_producto_adquirido INT
)
BEGIN
    INSERT INTO LogroDesbloqueado(fecha_desbloqueo,fid_logro,fid_producto_adquirido, activo) 
    VALUES (CURDATE(),_fid_logro,_fid_producto_adquirido, 1);
    SET _id_logro_desbloqueado = @@last_insert_id;
END$

DROP PROCEDURE IF EXISTS LISTAR_LOGRODESBLOQUEADOPRODUCTO;
DELIMITER $
CREATE PROCEDURE LISTAR_LOGRODESBLOQUEADOPRODUCTO(
	IN _id_producto_adquirido INT
)
BEGIN
	SELECT ld.id_logro_desbloqueado, ld.fecha_desbloqueo, l.id_logro, l.nombre as nombre_logro, l.descripcion as descripcion_logro
    FROM LogroDesbloqueado ld
    INNER JOIN Logro l ON l.id_logro = ld.fid_logro
    WHERE ld.activo = 1 AND l.activo = 1
    AND ld.fid_producto_adquirido = _id_producto_adquirido;
END$


DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT,
    IN _fecha_desbloqueo DATE
)
BEGIN
	UPDATE LogroDesbloqueado
    SET fecha_desbloqueo = _fecha_desbloqueado
	WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

DROP PROCEDURE IF EXISTS ELIMINAR_LOGRODESBLOQUEADO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_LOGRODESBLOQUEADO(
	IN _id_logro_desbloqueado INT
)
BEGIN
	UPDATE LogroDesbloqueado SET activo = 0 WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$



-- ----------------------------------------------------------------------------------------
-- Autor: Fabricio
-- ----------------------------------------------------------------------------------------
-- Procedimiento que enlista todos los logros que tiene un usuario
-- Recopila la información de la Fecha de Desbloqueo, Nombre del
-- Logro, Descripción del Logro, Título del Juego y la URL del Logo.
-- ----------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS LISTAR_LOGROS_POR_USUARIO;
-- ----------------------------------------------------------------------------------------
DELIMITER $ 
CREATE PROCEDURE LISTAR_LOGROS_POR_USUARIO (
    IN _id_usuario INT
)
BEGIN
    SELECT ld.id_logro_desbloqueado AS "ID del Logro Desbloqueado",
		   ld.fecha_desbloqueo AS "Fecha de Desbloqueo",
		   lo.id_logro AS "ID del Logro",
		   lo.nombre AS "Nombre del Logro",
           lo.descripcion AS "Descripción del Logro",
           pr.id_producto AS "ID del Juego",
           pr.titulo AS "Título del Juego",
           pr.logo_url AS "URL del Logo"
    FROM LogroDesbloqueado ld
    INNER JOIN Logro             lo ON ld.fid_logro = lo.id_logro
    INNER JOIN Juego             ju ON lo.fid_juego = ju.id_juego
    INNER JOIN Producto          pr ON ju.id_juego  = pr.id_producto
    INNER JOIN ProductoAdquirido pa ON ld.fid_producto_adquirido = pa.id_producto_adquirido
    INNER JOIN Biblioteca 		 bl	ON pa.fid_biblioteca = bl.id_biblioteca
    WHERE ld.activo = true AND
		  lo.activo = true AND
          pr.activo = true AND
          bl.fid_usuario= _id_usuario;
END $
-- ----------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS
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
    WHERE p.activo = 1;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS_X_ETIQUETA;
DELIMITER $
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
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS_X_TITULO_DESARROLLADOR;
DELIMITER $
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
DELIMITER ;

DROP PROCEDURE IF EXISTS BUSCAR_PRODUCTO;
DELIMITER $
CREATE PROCEDURE BUSCAR_PRODUCTO(
	IN _id_producto INT
)
BEGIN
	SELECT p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo, pr.activo as proveedor_activo
    FROM Producto p
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 and p.id_producto = _id_producto;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOS_DESTACADOS;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOS_DESTACADOS(
)
BEGIN
	select pa.fid_producto, COUNT(*) as num_adquiridos FROM ProductoAdquirido pa GROUP BY pa.fid_producto ORDER BY COUNT(*) DESC LIMIT 3; 
END$

DELIMITER ;

DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO(
	OUT _id_producto_adquirido INT,
	IN _fid_biblioteca INT,
	IN _fid_producto INT,
    IN _fid_movimiento INT
)
BEGIN
	INSERT INTO ProductoAdquirido
    (fecha_adquisicion,tiempo_uso,actualizado, oculto,
    fid_biblioteca, fid_producto, fid_movimiento, activo)
    VALUES(CURDATE(), CAST('00:00:00' AS TIME),false, false,
    _fid_biblioteca,_fid_producto, _fid_movimiento, 1);
    SET _id_producto_adquirido = @@last_insert_id;
END$



DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOSADQUIRIDOS_X_ID_BIBLIOTECA;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOSADQUIRIDOS_X_ID_BIBLIOTECA(
	IN _id_biblioteca INT
)
BEGIN
    SELECT pa.id_producto_adquirido, pa.fecha_adquisicion, pa.fecha_ejecucion, pa.tiempo_uso, pa.actualizado,
    pa.oculto, pa.fid_biblioteca, p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo as proveedor_activo, pa.fid_biblioteca as id_biblioteca
    FROM ProductoAdquirido pa
    INNER JOIN Producto p ON p.id_producto = pa.fid_producto
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 and pa.fid_biblioteca = _id_biblioteca;
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

DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOSADQUIRIDOS_X_ID_COLECCION;
DELIMITER $
CREATE PROCEDURE LISTAR_PRODUCTOSADQUIRIDOS_X_ID_COLECCION(
	IN _id_coleccion INT
)
BEGIN
    SELECT pa.id_producto_adquirido, pa.fecha_adquisicion, pa.fecha_ejecucion, pa.tiempo_uso, pa.actualizado,
    pa.oculto, pa.fid_biblioteca, p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion, p.espacio_disco, p.logo_url, p.portada_url,
    p.tipo_producto, j.requisitos_minimos, j.requisitos_recomendados, j.multijugador,
    bs.artista, bs.compositor, bs.duracion, s.requisitos, s.licencia, pr.id_proveedor, pr.razon_social, pr.activo as proveedor_activo, pa.fid_biblioteca as id_biblioteca
    FROM ProductoAdquirido_Coleccion pac, ProductoAdquirido pa
    INNER JOIN Producto p ON p.id_producto = pa.fid_producto
    LEFT JOIN Juego j ON p.id_producto = j.id_juego
    LEFT JOIN BandaSonora bs ON p.id_producto = bs.id_banda_sonora
    LEFT JOIN Software s ON p.id_producto = s.id_software
    INNER JOIN Proveedor pr ON pr.id_proveedor = p.fid_proveedor
    WHERE p.activo = 1 and 
    pac.fid_coleccion = _id_coleccion and pac.fid_producto_adquirido = pa.id_producto_adquirido and pa.activo = 1 and pac.activo=1;
END$

DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO_COLECCION;
DELIMITER $
CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO_COLECCION(
	IN _fid_coleccion INT,
    IN _fid_producto_adquirido INT
)
BEGIN
	INSERT INTO ProductoAdquirido_Coleccion(fid_coleccion, fid_producto_adquirido, activo)
    VALUES (_fid_coleccion, _fid_producto_adquirido, 1)
    ON DUPLICATE KEY UPDATE activo = 1;
END$

select * from ProductoAdquirido_Coleccion;

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
	INSERT INTO ProductoEtiqueta(fid_producto,fid_etiqueta,activo)
    VALUES(_fid_producto, _fid_etiqueta,1)
    ON DUPLICATE KEY UPDATE activo = 1;
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
	UPDATE ProductoEtiqueta 
    SET activo = 0
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
	SELECT * FROM Proveedor WHERE activo=1;
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
    SET activo = 0
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
DROP PROCEDURE IF EXISTS LISTAR_FOROS;
DROP PROCEDURE IF EXISTS BUSCAR_FORO;
DROP PROCEDURE IF EXISTS LISTAR_CREADOS;
DROP PROCEDURE IF EXISTS LISTAR_SUSCRITOS;
DROP PROCEDURE IF EXISTS MOSTRAR_SUBFOROS_POR_FORO;
DROP PROCEDURE IF EXISTS EDITAR_FORO;
DROP PROCEDURE IF EXISTS DESACTIVAR_FORO;
DROP PROCEDURE IF EXISTS ELIMINAR_FORO;

DELIMITER $ 
CREATE PROCEDURE CREAR_FORO(
	OUT _id_foro INT ,
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)

BEGIN
	INSERT INTO Foro(nombre,descripcion,
    origen_foro,oculto, activo) VALUES (_nombre,_descripcion,
    _origen_foro,0, 1);
	SET _id_foro = @@last_insert_id;

END $

CREATE PROCEDURE LISTAR_FOROS()
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro c INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_creador = 1 AND c.activo = 1;
END$

CREATE PROCEDURE BUSCAR_FORO(
	IN _nombre VARCHAR(100)
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro c INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_creador = 1 AND c.activo = 1 AND nombre LIKE CONCAT('%',_nombre,'%');
END$

CREATE PROCEDURE LISTAR_CREADOS(
	IN _iduser INT
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro c INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_creador = 1 AND c.activo = 1 AND f.fid_usuario = _iduser;
END$

CREATE PROCEDURE LISTAR_SUSCRITOS(
	IN _iduser INT
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, c.fid_usuario as id_user FROM Foro o INNER JOIN ForoUsuario f ON f.fid_foro = id_foro AND f.es_suscriptor = 1 AND o.activo = 1 AND f.fid_usuario = _iduser AND f.activo = 1 INNER JOIN ForoUsuario c ON c.fid_foro = id_foro WHERE c.es_creador = 1 AND c.activo = 1;
END$

CREATE PROCEDURE MOSTRAR_SUBFOROS_POR_FORO(
	in _id_foro INT 
)
BEGIN
	SELECT * FROM Subforo WHERE fid_foro = _id_foro 
    AND oculto = 0;

END $

CREATE PROCEDURE EDITAR_FORO(
	IN _id_foro INT,
	IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _origen_foro VARCHAR(100)
)
BEGIN
	UPDATE Foro SET nombre = _nombre,
    descripcion = _descripcion,
    origen_foro = _origen_foro 
    WHERE id_foro = _id_foro; 

END $

CREATE PROCEDURE DESACTIVAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE Foro SET oculto = 1
    WHERE id_foro = _id_foro; 

END $

CREATE PROCEDURE ELIMINAR_FORO(
	IN _id_foro INT
)
BEGIN
	UPDATE Foro SET activo = 0
    WHERE id_foro = _id_foro; 

END $


DROP PROCEDURE IF EXISTS CREAR_RELACION_FORO;
DROP PROCEDURE IF EXISTS ELIMINAR_RELACION_FORO;
DROP PROCEDURE IF EXISTS SUSCRIBIR_RELACION;
DROP PROCEDURE IF EXISTS LISTAR_SUSCRITOS_FOROUSER;
DROP PROCEDURE IF EXISTS DESUSCRIBIR_RELACION_FORO;
DROP PROCEDURE IF EXISTS LISTAR_SUSCRIPTORES;

DELIMITER $
CREATE PROCEDURE CREAR_RELACION_FORO(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	INSERT INTO ForoUsuario (fid_foro, fid_usuario, es_creador, es_suscriptor, activo)
	VALUES (_fid_foro, _fid_usuario, 1, 0, 1);
END$
CREATE PROCEDURE SUSCRIBIR_RELACION(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	INSERT INTO ForoUsuario (fid_foro, fid_usuario, es_creador, es_suscriptor, activo)
	VALUES (_fid_foro, _fid_usuario, 0, 1, 1);
END$
CREATE PROCEDURE ELIMINAR_RELACION_FORO(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	UPDATE ForoUsuario SET activo=0 
	WHERE fid_foro = _fid_foro AND fid_usuario = _fid_usuario AND es_creador = 1;
END$
CREATE PROCEDURE DESUSCRIBIR_RELACION_FORO(
	IN _fid_foro INT,
	IN _fid_usuario INT
)
BEGIN
	UPDATE ForoUsuario SET activo=0 
	WHERE fid_foro = _fid_foro AND fid_usuario = _fid_usuario AND es_suscriptor = 1;
END$
CREATE PROCEDURE LISTAR_SUSCRITOS_FOROUSER(
	IN _fid_usuario INT
)
BEGIN
	SELECT id_foro, nombre, descripcion, origen_foro, f.fid_usuario as id_user FROM Foro INNER JOIN ForoUsuario f ON f.fid_foro = id_foro WHERE fid_usuario = _fid_usuario AND f.es_suscriptor = 1 AND f.activo = 1;
END$

CREATE PROCEDURE LISTAR_SUSCRIPTORES(
	IN _fid_foro INT
)
BEGIN
	SELECT fid_usuario FROM ForoUsuario WHERE fid_foro = _fid_foro AND es_suscriptor = 1 AND es_creador = 0 AND activo = 1;
END$DROP PROCEDURE IF EXISTS CREAR_GESTOR;
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


DROP PROCEDURE IF EXISTS INSERTAR_GESTOR;
DELIMITER $ 
CREATE PROCEDURE INSERTAR_GESTOR(
	OUT _id_gestor INT ,
    IN _fid_usuario INT,
    IN _contador_faltas INT,
    IN _contador_baneos INT,
    IN _contador_palabras INT,
    IN _max_faltas INT,
    IN _max_baneos INT,
    IN _cant_baneos INT,
    IN _cant_faltas INT
)
BEGIN
	INSERT INTO GestorSanciones(fid_usuario, contador_faltas,
    contador_baneos,contador_palabras,
    max_faltas,max_baneos,
    cant_baneos, cant_faltas,
	activo)
    VALUES (_fid_usuario, _contador_faltas,
    _contador_baneos,contador_palabras,
    _max_faltas,_max_baneos,
    _cant_baneos, _cant_faltas,
    true);
	SET _id_gestor = @@last_insert_id;
END $

DROP PROCEDURE IF EXISTS BUSCAR_GESTOR;
DELIMITER $ 
CREATE PROCEDURE BUSCAR_GESTOR(
	in _fid_usuario INT 
)
BEGIN
	SELECT * FROM GestorSanciones
    WHERE fid_usuario = _fid_usuario;
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
	UPDATE GestorSanciones SET
    contador_faltas = _contador_faltas,
    contador_baneos = _contador_baneos,
    contador_palabras = _contador_palabras,
    max_faltas = _max_faltas,
    max_baneos = _max_baneos,
    cant_baneos = _cant_baneos,
    cant_faltas = _cant_faltas,
    fin_ban = _fin_ban
    WHERE id_gestor = _id_gestor; 
END $DROP PROCEDURE IF EXISTS CREAR_HILO;
DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJES_POR_HILO;
DROP PROCEDURE IF EXISTS EDITAR_HILO;
DROP PROCEDURE IF EXISTS DESACTIVAR_HILO;
DROP PROCEDURE IF EXISTS ELIMINAR_HILO;

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
	INSERT INTO Hilo(fijado,fecha_creacion,
    fecha_modificacion,fid_subforo,fid_creador, imagen_url,
    nro_mensajes,oculto, activo)
    VALUES (_fijado,_fecha_creacion,
    _fecha_modificacion,_id_subforo,
    _id_usuario, _imagen_url, 0,0, 1);
	SET _id_hilo = @@last_insert_id;

END $

DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJES_POR_HILO(
	in _id_hilo INT 
)
BEGIN
	SELECT id_mensaje, contenido, fecha_publicacion, fecha_max_edicion, fid_usuario, nombre_perfil , foto_url FROM Mensaje, Usuario 
	WHERE fid_hilo = _id_hilo AND UID = fid_usuario
    AND oculto = 0;

END $

DELIMITER $ 
CREATE PROCEDURE EDITAR_HILO(
	IN _id_hilo INT,
    IN _id_subforo INT,
    IN _fijado TINYINT,
    IN _fecha_modificacion DATE,
	IN _imagen_url VARCHAR(200)
)
BEGIN
	UPDATE Hilo SET fijado = _fijado, fid_subforo = _id_subforo,
    fecha_modificacion = _fecha_modificacion , imagen_url = _imagen_url
    WHERE id_hilo = _id_hilo; 
END $

DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE Hilo SET oculto = 1
    WHERE id_hilo = _id_hilo; 

END $

DELIMITER $ 
CREATE PROCEDURE ELIMINAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE Hilo SET activo = 0
    WHERE id_hilo = _id_hilo; 

END $


DROP PROCEDURE IF EXISTS CREAR_SUBFORO;
DROP PROCEDURE IF EXISTS MOSTRAR_HILOS_POR_SUBFORO;
DROP PROCEDURE IF EXISTS EDITAR_SUBFORO;
DROP PROCEDURE IF EXISTS DESACTIVAR_SUBFORO;

DELIMITER $ 
CREATE PROCEDURE CREAR_SUBFORO(
	OUT _id_subforo INT ,
	IN _id_foro INT,
    IN _nombre VARCHAR(100)
)
BEGIN
	INSERT INTO Subforo(fid_foro,nombre,oculto, activo) 
    VALUES (_id_foro,_nombre,0, 1);
	SET _id_subforo = @@last_insert_id;

END $

DELIMITER $ 
CREATE PROCEDURE MOSTRAR_HILOS_POR_SUBFORO(
	in _id_subforo INT 
)
BEGIN
	SELECT id_hilo, nro_mensajes, imagen_url, fecha_creacion, fecha_modificacion, fid_creador, nombre_perfil, foto_url FROM Hilo, Usuario WHERE 
    fid_subforo = _id_subforo AND UID = fid_creador
    AND oculto = 0;
END $


DELIMITER $ 
CREATE PROCEDURE EDITAR_SUBFORO(
	IN _id_subforo INT,
	IN _nombre VARCHAR(100)
)
BEGIN
	UPDATE Subforo SET nombre = _nombre
    WHERE id_subforo = _id_subforo; 

END $

DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_SUBFORO(
	IN _id_subforo INT
)
BEGIN
	UPDATE Foro SET oculto = 1
    WHERE id_subforo = _id_subforo; 

END $
DROP PROCEDURE IF EXISTS CREAR_MENSAJE;
DROP PROCEDURE IF EXISTS MOSTRAR_MENSAJE;
DROP PROCEDURE IF EXISTS EDITAR_MENSAJE;
DROP PROCEDURE IF EXISTS DESACTIVAR_MENSAJE;
DROP PROCEDURE IF EXISTS ELIMINAR_MENSAJE;

DELIMITER $ 
CREATE PROCEDURE CREAR_MENSAJE(
	OUT _id_mensaje INT,
    IN _contenido VARCHAR(300),
    IN _fecha_publicacion DATE,
    IN _fecha_max_edicion DATE,
    IN _id_hilo INT,
    IN _id_usuario INT
)
BEGIN
	INSERT INTO Mensaje(contenido,fecha_publicacion,
    fecha_max_edicion,
    fid_hilo,fid_usuario,oculto, activo)
    VALUES (_contenido,_fecha_publicacion,
    _fecha_max_edicion,
    _id_hilo,_id_usuario,0, 1);
	SET _id_mensaje = @@last_insert_id;
    UPDATE Hilo SET nro_mensajes = nro_mensajes +1 
    WHERE id_hilo = _id_hilo;

END $

DELIMITER $ 
CREATE PROCEDURE MOSTRAR_MENSAJE(
	in _id_mensaje INT 
)
BEGIN
	SELECT * FROM mensaje 
    WHERE id_mensaje = _id_mensaje 
    AND oculto = 0;

END $

DELIMITER $ 
CREATE PROCEDURE EDITAR_MENSAJE(
	IN _id_mensaje INT,
    IN _id_hilo INT,
    IN _contenido VARCHAR(300),
    IN _fecha_max_edicion DATE
)
BEGIN
	UPDATE Mensaje SET contenido = _contenido,
    fid_hilo = _id_hilo,
    fecha_max_edicion = _fecha_max_edicion
    WHERE id_mensaje = _id_mensaje; 
END $

DELIMITER $ 
CREATE PROCEDURE DESACTIVAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE Mensaje SET oculto = 1
    WHERE id_mensaje = _id_mensaje; 

END $

DELIMITER $ 
CREATE PROCEDURE ELIMINAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE Mensaje SET activo = 0
    WHERE id_mensaje = _id_mensaje; 

END $
DROP PROCEDURE IF EXISTS BUSCAR_PALABRA;
DELIMITER $
CREATE PROCEDURE BUSCAR_PALABRA(
    IN _palabra VARCHAR(100)
)
BEGIN
    SELECT *
    FROM PalabrasProhibidas
    WHERE palabra = md5(_palabra);
END $
DELIMITER ;DROP PROCEDURE IF EXISTS INSERTAR_CARTERA;
DELIMITER $
CREATE PROCEDURE INSERTAR_CARTERA(
	OUT _ID_CARTERA INT,
    IN _FID_USUARIO INT,
    IN _FONDOS DECIMAL(10, 2),
    IN _CANT_MOVIMIENTOS INT
)
BEGIN
	INSERT INTO Cartera(FID_USUARIO, FONDOS, cantidad_movimientos, ACTIVO)
	VALUES (_FID_USUARIO, _FONDOS, _CANT_MOVIMIENTOS, true);
    SET _ID_CARTERA = @@last_insert_id;
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
	UPDATE Cartera SET FONDOS = _FONDOS, cantidad_movimientos = _CANT_MOVIMIENTOS WHERE ID_CARTERA = _ID_CARTERA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS BUSCAR_CARTERA;
DELIMITER $
CREATE PROCEDURE BUSCAR_CARTERA(
	IN _fid_usuario INT
)
BEGIN
	SELECT * FROM Cartera WHERE fid_usuario = _fid_usuario;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS CREAR_MOVIMIENTO;
DELIMITER $
CREATE PROCEDURE CREAR_MOVIMIENTO(
	OUT _ID_MOVIMIENTO INT,
    IN _ID_TRANSACCION VARCHAR(100),
    IN _FECHA_TRANSACCION DATE,
    IN _MONTO DECIMAL(10, 2),
    IN _TIPO VARCHAR(100),
    IN _METODO_PAGO VARCHAR(100),
    IN _FID_CARTERA INT
)
BEGIN
	INSERT INTO Movimiento(ID_TRANSACCION, FECHA_TRANSACCION, MONTO, TIPO, METODO_PAGO, FID_CARTERA, activo)
	VALUES (_ID_TRANSACCION, _FECHA_TRANSACCION, _MONTO, _TIPO, _METODO_PAGO, _FID_CARTERA, 1);
	SET _ID_MOVIMIENTO = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_MOVIMIENTOS;
DELIMITER $
CREATE PROCEDURE LISTAR_MOVIMIENTOS(
	IN _FID_CARTERA INT
)
BEGIN
	SELECT id_movimiento, id_transaccion, fecha_transaccion as fecha, monto, tipo, metodo_pago, fid_cartera FROM Movimiento WHERE FID_CARTERA = _FID_CARTERA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS BUSCAR_MOVIMIENTO;
DELIMITER $
CREATE PROCEDURE BUSCAR_MOVIMIENTO(
	IN _ID_MOVIMIENTO INT
)
BEGIN
	SELECT id_movimiento, id_transaccion, fecha_transaccion as fecha, monto, tipo, metodo_pago, fid_cartera FROM Movimiento WHERE ID_MOVIMIENTO = _ID_MOVIMIENTO;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS CREAR_NOTIFICACION;
DELIMITER $
CREATE PROCEDURE CREAR_NOTIFICACION(
	OUT _ID_NOTIFICACION INT,
    IN _TIPO VARCHAR(30),
    IN _MENSAJE VARCHAR(200),
    IN _FID_USUARIO INT
)
BEGIN
	INSERT INTO Notificacion(TIPO, MENSAJE, FID_USUARIO, REVISADA, ACTIVO, FECHA)
    VALUES (_TIPO, _MENSAJE, _FID_USUARIO, FALSE, TRUE, CURDATE());
    SET _ID_NOTIFICACION = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ELIMINAR_NOTIFICACION;
DELIMITER $
CREATE PROCEDURE ELIMINAR_NOTIFICACION(
	IN _ID_NOTIFICACION INT
)
BEGIN
	UPDATE Notificacion SET ACTIVO = FALSE WHERE ID_NOTIFICACION = _ID_NOTIFICACION;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS ACTUALIZAR_NOTIFICACION;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_NOTIFICACION(
	IN _ID_NOTIFICACION INT,
    IN _TIPO VARCHAR(30),
    IN _MENSAJE VARCHAR(200),
    IN _FID_USUARIO INT,
    IN _REVISADA TINYINT
)
BEGIN
	UPDATE Notificacion 
    SET TIPO = _TIPO, MENSAJE = _MENSAJE, FID_USUARIO = _FID_USUARIO, REVISADA=_REVISADA
    WHERE ID_NOTIFICACION = _ID_NOTIFICACION;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_NOTIFICACIONES;
DELIMITER $
CREATE PROCEDURE LISTAR_NOTIFICACIONES(
	IN _FID_USUARIO INT
)
BEGIN
	SELECT * FROM Notificacion WHERE FID_USUARIO = _FID_USUARIO AND ACTIVO = TRUE;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_NOTIFICACIONES_USUARIO;
DELIMITER $
CREATE PROCEDURE ELIMINAR_NOTIFICACIONES_USUARIO(
	IN _FID_USUARIO INT
)
BEGIN
	UPDATE Notificacion SET ACTIVO = FALSE WHERE FID_USUARIO = _FID_USUARIO;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS MARCAR_NOTIFICACION_LEIDA;
DELIMITER $
CREATE PROCEDURE MARCAR_NOTIFICACION_LEIDA(
	IN _id_notificacion INT
)
BEGIN
	UPDATE Notificacion SET revisada = true WHERE id_notificacion = _id_notificacion;
END$
DELIMITER ;
DROP PROCEDURE IF EXISTS CREAR_PAIS;
DELIMITER $
CREATE PROCEDURE CREAR_PAIS(
	OUT _ID_PAIS INT,
    IN _NOMBRE VARCHAR(100),
    IN _CODIGO CHAR(3),
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
	SELECT p.id_pais, p.nombre as nombre_pais, p.codigo as codigo_pais, m.id_tipo_moneda, 
    m.nombre as nombre_moneda, m.codigo as codigo_moneda, m.simbolo, m.cambio_de_dolares, m.fecha_cambio, m.activo as moneda_activa
    FROM Pais p
    INNER JOIN TipoMoneda m ON m.id_tipo_moneda = p.fid_moneda
    WHERE p.activo = 1 AND p.id_pais = _id_pais;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PAISES;
DELIMITER $
CREATE PROCEDURE LISTAR_PAISES()
BEGIN
	SELECT p.id_pais, p.nombre as nombre_pais, p.codigo as codigo_pais, m.id_tipo_moneda, 
    m.nombre as nombre_moneda, m.codigo as codigo_moneda, m.simbolo, m.cambio_de_dolares, m.fecha_cambio, m.activo as moneda_activa
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
DELIMITER ;


DROP PROCEDURE IF EXISTS AGREGAR_AMIGO;
DROP PROCEDURE IF EXISTS ELIMINAR_AMIGO;
DROP PROCEDURE IF EXISTS BLOQUEAR_USUARIO;

DELIMITER $

-- Este procedimiento agrega un nuevo registro de amigo.
-- No se debe llamar a este procedimiento si ya existe un registro
-- activo de amigo entre esos usuarios. No se debe llamar a este
-- procedimiento si existe una relación de bloqueo entre los usuarios.
CREATE PROCEDURE AGREGAR_AMIGO (
    IN _fid_usuario_actuador INT,
    IN _fid_usuario_destino INT
)
BEGIN
    -- Insertar una nueva relación de amistad
    INSERT INTO Relacion (fid_usuario_actuador, fid_usuario_destino, tipo_relacion, fecha_inicio, activo)
    VALUES (_fid_usuario_actuador, _fid_usuario_destino, 'amistad', CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'), TRUE);
END$

-- Este procedimiento desactiva el único registro activo de amistad
-- que debería existir entre los dos usuarios. No se debe llamar a
-- este procedimiento si no existe esa relación de amistad activa.
-- Los parámetros pueden intercambiarse porque la relación de amistar
-- la puede terminar cualquiera de los dos amigos.
CREATE PROCEDURE ELIMINAR_AMIGO (
    IN _fid_usuario_actuador INT,
    IN _fid_usuario_destino INT
)
BEGIN
    -- Desactivar la relación de amistad actual y establecer fecha_fin
    UPDATE Relacion
    SET activo = FALSE,
        fecha_fin = CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')
    WHERE tipo_relacion = 'amistad'
      AND activo = TRUE
      AND (
           (fid_usuario_actuador = _fid_usuario_actuador AND fid_usuario_destino = _fid_usuario_destino)
		   OR
           (fid_usuario_actuador = _fid_usuario_destino AND fid_usuario_destino = _fid_usuario_actuador)
      );
END$

-- Este procedimiento desactiva cualquier relación de amistad activa
-- y agrega un registro de tipo bloqueo entre ambos usuarios. Este
-- método debe llamarse una sola vez para el par de usuarios
-- porque el bloqueo es permanente. Cualquiera de los dos usuarios
-- puede bloquear al otro.
CREATE PROCEDURE BLOQUEAR_USUARIO (
    IN _fid_usuario_actuador INT,
    IN _fid_usuario_destino INT
)
BEGIN
    -- Desactivar cualquier relación de amistad activa actual y establecer fecha_fin
    UPDATE Relacion
    SET activo = FALSE,
        fecha_fin = CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')
    WHERE tipo_relacion = 'amistad'
      AND activo = TRUE
      AND (
           (fid_usuario_actuador = _fid_usuario_actuador AND fid_usuario_destino = _fid_usuario_destino)
		   OR
           (fid_usuario_actuador = _fid_usuario_destino AND fid_usuario_destino = _fid_usuario_actuador)
      );
    
    -- Insertar una nueva relación de bloqueo
    INSERT INTO Relacion (fid_usuario_actuador, fid_usuario_destino, tipo_relacion, fecha_inicio, activo)
    VALUES (_fid_usuario_actuador, _fid_usuario_destino, 'bloqueo', CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'), TRUE);
END $

DELIMITER ;DROP PROCEDURE IF EXISTS INSERTAR_TIPOMONEDA;
DELIMITER $
CREATE PROCEDURE INSERTAR_TIPOMONEDA(
	OUT _id_tipo_moneda INT,
	IN _nombre VARCHAR(50),
	IN _codigo CHAR(3),
    IN _simbolo CHAR(3),
	IN _cambio_de_dolares DECIMAL(10,2)
)
BEGIN
	INSERT INTO TipoMoneda(nombre, codigo, simbolo, cambio_de_dolares, fecha_cambio, activo)
    VALUES (_nombre, _codigo, _simbolo, _cambio_de_dolares, SYSDATE(), 1);
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
	IN _codigo CHAR(3),
	IN _simbolo CHAR(3),
	IN _cambio_de_dolares DECIMAL(10,2)
)
BEGIN
	UPDATE TipoMoneda
	SET nombre = _nombre,
		codigo = _codigo,
        simbolo = _simbolo,
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
DROP PROCEDURE IF EXISTS ACTUALIZAR_USUARIO;
DROP PROCEDURE IF EXISTS ELIMINAR_USUARIO;
DROP PROCEDURE IF EXISTS BUSCAR_USUARIO_POR_ID;
DROP PROCEDURE IF EXISTS SUSPENDER_USUARIO;
DROP PROCEDURE IF EXISTS LISTAR_USUARIO;
DROP PROCEDURE IF EXISTS BUSCAR_USUARIO_X_NOMBRE_CUENTA;
DROP PROCEDURE IF EXISTS VERIFICAR_USUARIO;
DROP PROCEDURE IF EXISTS LISTAR_USUARIOS_X_NOMBRE_CUENTA;
DROP PROCEDURE IF EXISTS LISTAR_AMIGOS_X_USUARIO;
DROP PROCEDURE IF EXISTS LISTAR_BLOQUEADOS_X_USUARIO;
DROP PROCEDURE IF EXISTS LISTAR_USUARIOS_QUE_BLOQUEARON;

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
    IN _FID_PAIS INT
)
BEGIN
    INSERT INTO Usuario(nombre_cuenta, nombre_perfil, correo, telefono,
                        contrasenia, edad, fecha_nacimiento, verificado,
                        fid_pais, activo)
    VALUES (_NOMBRE_CUENTA, _NOMBRE_PERFIL, _CORREO, _TELEFONO,
            MD5(_CONTRASENIA), _EDAD, _FECHA_NACIMIENTO, _VERIFICADO,
            _FID_PAIS, true);
    SET _ID_USUARIO = LAST_INSERT_ID();
END $


CREATE PROCEDURE ACTUALIZAR_USUARIO(
    IN _ID_USUARIO INT,
    IN _NOMBRE_CUENTA VARCHAR(100),
    IN _NOMBRE_PERFIL VARCHAR(100),
    IN _CORREO VARCHAR(100),
    IN _TELEFONO VARCHAR(100),
    IN _EDAD INT,
    IN _FECHA_NACIMIENTO DATE,
    IN _VERIFICADO TINYINT,
    IN _FID_PAIS INT,
    IN _FOTO_URL VARCHAR(200)
)
BEGIN
    UPDATE Usuario SET 
        nombre_cuenta = _NOMBRE_CUENTA,
        nombre_perfil = _NOMBRE_PERFIL,
        correo = _CORREO,
        telefono = _TELEFONO,
        edad = _EDAD,
        fecha_nacimiento = _FECHA_NACIMIENTO,
        verificado = _VERIFICADO,
        fid_pais = _FID_PAIS,
        foto_url = _FOTO_URL
    WHERE UID = _ID_USUARIO;
END $


CREATE PROCEDURE SUSPENDER_USUARIO(
	IN _ID_USUARIO INT
)
BEGIN
	UPDATE Usuario SET ACTIVO = NOT ACTIVO WHERE UID = _ID_USUARIO;
END $




CREATE PROCEDURE ELIMINAR_USUARIO(
	IN _ID_USUARIO INT
)
BEGIN
	DELETE FROM Usuario WHERE UID = _ID_USUARIO;
END $



CREATE PROCEDURE LISTAR_USUARIO()
BEGIN
	SELECT * FROM Usuario;
END $


CREATE PROCEDURE BUSCAR_USUARIO_X_NOMBRE_CUENTA(
	IN _nombre_cuenta VARCHAR(100)
)
BEGIN
    SELECT u.UID, u.nombre_cuenta, u.nombre_perfil, u.correo, u.telefono,
    u.contrasenia, u.edad, u.fecha_nacimiento, u.verificado, u.activo,
    u.fid_pais, p.nombre as 'nombre_pais', p.fid_moneda,
    m.nombre as 'nombre_moneda', m.cambio_de_dolares,
    m.codigo as 'codigo_moneda', m.simbolo as 'simbolo_moneda',
    u.foto_url as 'foto_url'
    FROM Usuario u
    INNER JOIN Pais p ON p.id_pais = u.fid_pais
    INNER JOIN TipoMoneda m ON p.fid_moneda = m.id_tipo_moneda
    WHERE _nombre_cuenta LIKE nombre_cuenta;
END$


CREATE PROCEDURE BUSCAR_USUARIO_POR_ID (
	IN _uid INT
)
BEGIN
    SELECT u.UID, u.nombre_cuenta, u.nombre_perfil, u.correo, u.telefono,
    u.contrasenia, u.edad, u.fecha_nacimiento, u.verificado, u.activo,
    u.fid_pais, p.nombre as 'nombre_pais', p.fid_moneda,
    m.nombre as 'nombre_moneda', m.cambio_de_dolares,
    m.codigo as 'codigo_moneda', m.simbolo as 'simbolo_moneda',
    u.foto_url as 'foto_url'
    FROM Usuario u
    INNER JOIN Pais p ON p.id_pais = u.fid_pais
    INNER JOIN TipoMoneda m ON p.fid_moneda = m.id_tipo_moneda
    WHERE u.UID = _uid AND u.activo = TRUE;
END$


CREATE PROCEDURE VERIFICAR_USUARIO (
	IN _nombre_cuenta VARCHAR(100),
    IN _contrasenia VARCHAR(100)
)
BEGIN
    SELECT u.UID, u.nombre_cuenta, u.nombre_perfil, u.correo, u.telefono,
    u.contrasenia, u.edad, u.fecha_nacimiento, u.verificado, u.activo, u.foto_url,
    u.fid_pais, p.nombre as 'nombre_pais', p.fid_moneda,
    m.nombre as 'nombre_moneda', m.cambio_de_dolares, m.codigo as 'codigo_moneda', m.simbolo as 'simbolo_moneda'
    FROM Usuario u
    INNER JOIN Pais p ON p.id_pais = u.fid_pais
    INNER JOIN TipoMoneda m ON p.fid_moneda = m.id_tipo_moneda
    WHERE u.nombre_cuenta = _nombre_cuenta AND u.contrasenia = md5(_contrasenia);
END$


-- Enlista todos los usuarios que coincidan con el nombre ingresado
CREATE PROCEDURE LISTAR_USUARIOS_X_NOMBRE_CUENTA(
	IN _nombre_cuenta VARCHAR(100)
)
BEGIN
    SELECT u.UID, u.nombre_cuenta, u.nombre_perfil, u.correo, u.telefono,
		   u.contrasenia, u.edad, u.fecha_nacimiento, u.verificado, u.activo,
           u.fid_pais, p.nombre as 'nombre_pais',  p.fid_moneda,
           m.nombre as 'nombre_moneda', m.cambio_de_dolares,
           m.codigo as 'codigo_moneda', m.simbolo as 'simbolo_moneda',
           u.foto_url as 'foto_url'
    FROM Usuario u
    INNER JOIN Pais p ON p.id_pais = u.fid_pais
    INNER JOIN TipoMoneda m ON p.fid_moneda = m.id_tipo_moneda
    WHERE nombre_cuenta LIKE CONCAT('%', _nombre_cuenta, '%');
END$

CREATE PROCEDURE LISTAR_AMIGOS_X_USUARIO (
    IN _id_usuario INT
)
BEGIN
    SELECT u.UID, u.nombre_cuenta, u.nombre_perfil, u.correo, u.telefono,
    	   u.contrasenia, u.edad, u.fecha_nacimiento, u.verificado, u.activo,
    	   u.fid_pais, p.nombre as 'nombre_pais', p.fid_moneda,
		   m.nombre as 'nombre_moneda', m.cambio_de_dolares,
           m.codigo as 'codigo_moneda', m.simbolo as 'simbolo_moneda',
           u.foto_url as 'foto_url'
    FROM Usuario u
    INNER JOIN Pais p ON p.id_pais = u.fid_pais
    INNER JOIN TipoMoneda m ON p.fid_moneda = m.id_tipo_moneda
    INNER JOIN Relacion r ON (r.fid_usuario_actuador = _id_usuario AND r.fid_usuario_destino = u.UID OR 
                              r.fid_usuario_actuador = u.UID       AND r.fid_usuario_destino = _id_usuario)
    WHERE r.tipo_relacion = 'amistad' AND r.activo = true AND u.activo = true;
END $

CREATE PROCEDURE LISTAR_BLOQUEADOS_X_USUARIO (
    IN _id_usuario INT
)
BEGIN
    SELECT u.UID, u.nombre_cuenta, u.nombre_perfil, u.correo, u.telefono,
    	   u.contrasenia, u.edad, u.fecha_nacimiento, u.verificado, u.activo,
    	   u.fid_pais, p.nombre as 'nombre_pais', p.fid_moneda,
		   m.nombre as 'nombre_moneda', m.cambio_de_dolares,
           m.codigo as 'codigo_moneda', m.simbolo as 'simbolo_moneda',
           u.foto_url as 'foto_url'
    FROM Usuario u
    INNER JOIN Pais p ON p.id_pais = u.fid_pais
    INNER JOIN TipoMoneda m ON p.fid_moneda = m.id_tipo_moneda
    INNER JOIN Relacion r ON (r.fid_usuario_actuador = _id_usuario AND r.fid_usuario_destino = u.UID)
    WHERE r.tipo_relacion = 'bloqueo' AND r.activo = true AND u.activo = true;
END$

CREATE PROCEDURE LISTAR_USUARIOS_QUE_BLOQUEARON (
    IN _id_usuario INT
)
BEGIN
    SELECT u.UID, u.nombre_cuenta, u.nombre_perfil, u.correo, u.telefono,
    	   u.contrasenia, u.edad, u.fecha_nacimiento, u.verificado, u.activo,
    	   u.fid_pais, p.nombre as 'nombre_pais', p.fid_moneda,
		   m.nombre as 'nombre_moneda', m.cambio_de_dolares,
           m.codigo as 'codigo_moneda', m.simbolo as 'simbolo_moneda',
           u.foto_url as 'foto_url'
    FROM Usuario u
    INNER JOIN Pais p ON p.id_pais = u.fid_pais
    INNER JOIN TipoMoneda m ON p.fid_moneda = m.id_tipo_moneda
    INNER JOIN Relacion r ON (r.fid_usuario_actuador = u.UID AND r.fid_usuario_destino = _id_usuario)
    WHERE r.tipo_relacion = 'bloqueo' AND r.activo = true AND u.activo = true;
END$


DELIMITER ;
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Sol', 'PEN', 'S/.', 3.73);
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Euro', 'EUR', '€', 0.91);
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Dólar', 'USD', '$', 1);

CALL CREAR_PAIS(@id_pais, 'Peru', 'PER', 1);
CALL CREAR_PAIS(@id_pais, 'Francia', 'FR', 2);
CALL CREAR_PAIS(@id_pais, 'Estados Unidos', 'US', 3);
CALL CREAR_PAIS(@id_pais, 'España', 'ES', 2);

CALL INSERTAR_PROVEEDOR(@id_proveedor, 'RoboTopo Games');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Team Blueberry');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Kristjan Skutta');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'MMOs para todos');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Beths Game Studios');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'THS');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Igora Studios');
CALL INSERTAR_PROVEEDOR(@id_proveedor, '2D Guy');

CALL INSERTAR_JUEGO(@id_juego, 1, 'Geometry Dash', '2013-08-13', 5, 'Juego de ritmo y figuras', 10.00, 'https://1000logos.net/wp-content/uploads/2022/05/Logo-Geometry-Dash.png', 'https://resources.crowdcontrol.live/images/GeometryDash/banner.jpg', 1, 'Core i5 10th Generation', 'Core i7 12th Generation', 1);
CALL INSERTAR_BANDASONORA(@id_banda_sonora, 2, 'Hollow Knight - Official Soundtrack', '2024-04-20', 0.00, 'Soundtrack Oficial del juego Hollow Knight, captura una vasta parte del mundo subterráneo del juego', 15.00, 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/d0/02/e3/d002e325-299d-f87f-a737-7d7ad3c628ae/840095520225.jpg/1200x1200bf-60.jpg', 'https://cdn.cloudflare.steamstatic.com/steam/apps/598190/header.jpg?t=1581550241', 1, 'Christopher Larkin', 'Christopher Larkin', '01:04:20');
CALL INSERTAR_SOFTWARE(@id_software, 3, 'Wallpaper Engine', '2016-10-10', 4, 'Aplicacion para fondos de pantalla en alta calidad y animados', 20.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShoRHLNX2m9GQ-ziMfqlaSkfZH8m5YnhovOAWASmw8Dg&s', 'https://cdn.akamai.steamstatic.com/steam/apps/431960/header.jpg?t=1665921297', 1, 'Core i5 7th Generation', 'GPL');
CALL INSERTAR_JUEGO(@id_juego, 4, 'Maplestory', '2012-08-09', 0, 'Únete a la aventura del MMORPG en 2D más grande del mundo.', 1536, 'https://cdn2.steamgriddb.com/grid/5ca15b56b207cea5903395718b794fec.png', 'https://mmos.com/wp-content/uploads/2015/10/pocket-maplestory-banner.jpg', 1, 'Intel Core 2 Duo de 3,0 GHz', 'Intel Core i3 de 4,0 GHz', 1);
CALL INSERTAR_JUEGO(@id_juego, 4, 'Guild Wars 2', '2022-08-23', 0, 'Juego de rol online con combates de acción trepidante y con una profunda personalización de personajes', 7168, 'https://www.pngitem.com/pimgs/m/195-1956338_guild-wars-2-logo-png-transparent-png.png', 'https://i.imgur.com/BFkJ9BI.jpeg', 1, 'Intel Core i3 3.4 GHz', 'Intel Core i5', 1);
CALL INSERTAR_JUEGO(@id_juego, 5, 'Fallout 4', '2015-11-10', 5, 'Juego de rol de acción ambientado en un mundo post-apocalíptico', 8.00, 'https://imgur.com/Wlj77jZ', 'https://cdn.cloudflare.steamstatic.com/steam/apps/377160/header.jpg?t=1629138088', 1, 'Intel Core i5-2300 2.8 GHz', 'Intel Core i7-4790 3.6 GHz', 1);
CALL INSERTAR_SOFTWARE(@id_software, 6, 'Lossless Scaling', '2018-12-28', 7, 'La utilidad de juegos todo en uno para escalado y generación de frames', 150.00, 'https://styles.redditmedia.com/t5_aonbpu/styles/communityIcon_h19ct7wozz4d1.png', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/993090/header.jpg', 1, 'Intel HD Graphics', 'LS1');
CALL INSERTAR_BANDASONORA(@id_banda_sonora, 2, 'Nine Sols Soundtrack', '2024-05-29', 6, 'Contenido adicional para los niveles más profundos del videojuego Nine Sols', 600, 'https://imgur.com/a/L8dyI4P', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1913930/header.jpg?t=1717416666', 1, 'Hunter Wang', 'Hsiaotzu Lee', '03:15:10');
CALL INSERTAR_SOFTWARE(@id_software, 7, 'Aseprite', '2016-02-22', 20, 'Herramienta de arte pixelado para crear animaciones 2D, sprites y cualquier tipo de gráficos para juegos', 80, 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Logo_Aseprite.svg/1200px-Logo_Aseprite.svg.png', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/431730/header.jpg?t=1712679350', 1, 'Windows 8, 10, 11', 'MIT');
CALL INSERTAR_JUEGO(@id_juego, 5, 'DOOM', '2016-05-12', 20, 'Shooter en primera persona renovado de su versión lanzada el 10 de diciembre de 1993', 5500, 'https://mir-s3-cdn-cf.behance.net/project_modules/1400_opt_1/36116d43018691.57e09e24e07ca.jpg', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/379720/header.jpg?t=1692892793', 1, 'Intel Core i5-2400/AMD FX-8320 o superior', 'Intel Core i7-3770/AMD FX-8350 o superior', 1);
CALL INSERTAR_JUEGO(@id_juego, 8, 'World Of Goo', '2008-10-13', 10, 'Juego de puzzles/construcción basados en la física creado íntegramente por sólo dos tipos', 100, 'https://assets1.ignimgs.com/2017/02/15/world-of-goo---button-1487120649951.jpg', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/22000/header.jpg?t=1587578439', 1, 'Windows XP or Vista', 'NVIDIA GeForce 6100', 0);


CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 1", "Lograste pasar el nivel 1", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 2", "Lograste pasar el nivel 2", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 3", "Lograste pasar el nivel 3", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Nivel 50", "Llegaste al nivel 50", 1, 4);
CALL INSERTAR_LOGRO(@id_logro, "Amigos", "Hiciste tu primer amigo", 1, 4);
CALL INSERTAR_LOGRO(@id_logro, "Mist", "Conociste a Mist", 1, 4);
CALL INSERTAR_LOGRO(@id_logro, "Nivel 50 Mago", "Llegaste a nivel 50 con la clase Mago", 1, 5);
CALL INSERTAR_LOGRO(@id_logro, "Nivel 50 Guerrero", "Llegaste a nivel 50 con la clase Guerrero", 1, 5);
CALL INSERTAR_LOGRO(@id_logro, "Superviviente Nato", "Llegaste al nivel 5", 1, 6);
CALL INSERTAR_LOGRO(@id_logro, "Trotamundos imparable", "Llegaste al nivel 25", 1, 6);
CALL INSERTAR_LOGRO(@id_logro, "Parca", "Lograste ser la parca por 5 minutos", 1, 10);
CALL INSERTAR_LOGRO(@id_logro, "Double Kill", "Venciste a dos jugadores por tu cuenta", 1, 10);
call INSERTAR_ETIQUETA(@id_etiqueta,'Terror');
call INSERTAR_ETIQUETA(@id_etiqueta,'Puzzle');
call INSERTAR_ETIQUETA(@id_etiqueta,'RPG');
call INSERTAR_ETIQUETA(@id_etiqueta,'Casual');
call INSERTAR_ETIQUETA(@id_etiqueta,'Accion');
call INSERTAR_ETIQUETA(@id_etiqueta,'Utilidad');
call INSERTAR_PRODUCTOETIQUETA(1, 2);
call INSERTAR_PRODUCTOETIQUETA(1, 5);
call INSERTAR_PRODUCTOETIQUETA(3, 2);
call INSERTAR_PRODUCTOETIQUETA(3, 5);
call INSERTAR_PRODUCTOETIQUETA(4, 3);
call INSERTAR_PRODUCTOETIQUETA(4, 4);
call INSERTAR_PRODUCTOETIQUETA(5, 2);
call INSERTAR_PRODUCTOETIQUETA(5, 5);
call INSERTAR_PRODUCTOETIQUETA(6, 5);
call INSERTAR_PRODUCTOETIQUETA(6, 2);
call INSERTAR_PRODUCTOETIQUETA(7, 6);
call INSERTAR_PRODUCTOETIQUETA(8, 6);
call INSERTAR_PRODUCTOETIQUETA(10, 5);
call INSERTAR_PRODUCTOETIQUETA(11, 2);
call INSERTAR_PRODUCTOETIQUETA(11, 4);

CALL CREAR_USUARIO(@id_usuario, 'cuenta_sofia', 'Sofia', 'a20210750@pucp.edu.pe', '123456789', 'password_sofia', 19, '2004-07-01', 1, 4, 2, 5, 1);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca, @id_usuario);
call INSERTAR_CARTERA(@id_cartera, @id_usuario, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor, @id_usuario, 0, 0, 0, 3, 3, 0, 0);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,1);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,2);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,3);
call INSERTAR_COLECCION(@_id_coleccion, 'Favoritos', @id_biblioteca);
call INSERTAR_COLECCION(@_id_coleccion, 'Frecuentes', @id_biblioteca);
CALL CREAR_NOTIFICACION(@id_notificacion, "BIBLIOTECA", "Se ha agregado un nuevo producto: Hollow Knight a tu Biblioteca", @id_usuario);
CALL CREAR_NOTIFICACION(@id_notificacion, "AMIGOS", "Ahora eres amigo de Juan", @id_usuario);
CALL CREAR_NOTIFICACION(@id_notificacion, "FOROS", "Hay un nuevo mensaje en el foro A", @id_usuario);
CALL CREAR_NOTIFICACION(@id_notificacion, "JUEGOS", "Has conseguido un nuevo logro en Geometry Dash", @id_usuario);





CALL CREAR_USUARIO(@id_usuario, 'cuenta_fabricio', 'Fabricio', 'a20214115@pucp.edu.pe', '987654321', 'password_fabricio', 20, '2003-12-06', 1, 1, 3, 4, 2);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca, @id_usuario);
call INSERTAR_CARTERA(@id_cartera, @id_usuario, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor, @id_usuario, 0, 0, 0, 3, 3, 0, 0);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,1);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,2);

UPDATE ProductoAdquirido SET fecha_ejecucion='2024-05-29', tiempo_uso='01:20:23' where id_producto_adquirido=1;
UPDATE ProductoAdquirido SET fecha_ejecucion='2024-05-29', tiempo_uso='00:18:38' where id_producto_adquirido=3;
-- Usuarios de Prueba para Amigos
CALL CREAR_USUARIO(@id_usuario, 'cuenta_lucia', 'Lucia', 'lucia@gmail.com', '987654322', 'password_lucia', 25, '1998-05-10', 1, 2, 4, 10, 2);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_jose', 'Jose', 'jose@hotmail.com', '987654323', 'password_jose', 30, '1993-08-15', 0, 3, 2, 5, 1);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_maria', 'Maria', 'maria@yahoo.com', '987654324', 'password_maria', 22, '2001-03-20', 1, 4, 5, 8, 2);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_juan', 'Juan', 'juan@gmail.com', '987654325', 'password_juan', 28, '1995-11-11', 0, 1, 3, 6, 1);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_ana', 'Ana', 'ana@hotmail.com', '987654326', 'password_ana', 26, '1997-02-25', 1, 2, 4, 7, 2);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_pedro', 'Pedro', 'pedro@yahoo.com', '987654327', 'password_pedro', 29, '1994-07-30', 0, 3, 2, 9, 1);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_carla', 'Carla', 'carla@gmail.com', '987654328', 'password_carla', 24, '1999-01-14', 1, 4, 5, 12, 2);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_andres', 'Andres', 'andres@hotmail.com', '987654329', 'password_andres', 27, '1996-06-18', 0, 1, 3, 11, 1);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_sara', 'Sara', 'sara@yahoo.com', '987654330', 'password_sara', 23, '2000-09-23', 1, 2, 4, 13, 2);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_david', 'David', 'david@gmail.com', '987654331', 'password_david', 31, '1992-12-12', 0, 3, 2, 14, 1);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_alejandra', 'Alejandra', 'alejandra@hotmail.com', '987654332', 'password_alejandra', 19, '2004-04-04', 1, 4, 5, 15, 2);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_javier', 'Javier', 'javier@yahoo.com', '987654333', 'password_javier', 32, '1991-10-28', 0, 1, 3, 16, 1);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_elena', 'Elena', 'elena@gmail.com', '987654334', 'password_elena', 21, '2002-05-05', 1, 2, 4, 17, 2);
CALL CREAR_USUARIO(@id_usuario, 'cuenta_martin', 'Martin', 'martin@hotmail.com', '987654335', 'password_martin', 33, '1990-07-07', 0, 3, 2, 18, 1);

-- Crear la relación de amigos entre ellos
CALL AGREGAR_AMIGO(2, 3);
CALL AGREGAR_AMIGO(2, 4);
CALL AGREGAR_AMIGO(2, 5);
CALL AGREGAR_AMIGO(3, 4);
CALL AGREGAR_AMIGO(3, 6);
CALL AGREGAR_AMIGO(4, 5);
CALL AGREGAR_AMIGO(4, 7);
CALL AGREGAR_AMIGO(5, 6);
CALL AGREGAR_AMIGO(5, 8);
CALL AGREGAR_AMIGO(6, 9);
CALL AGREGAR_AMIGO(7, 8);
CALL AGREGAR_AMIGO(7, 10);
CALL AGREGAR_AMIGO(8, 9);
CALL AGREGAR_AMIGO(8, 11);
CALL AGREGAR_AMIGO(9, 12);
CALL AGREGAR_AMIGO(10, 11);
CALL AGREGAR_AMIGO(10, 13);
CALL AGREGAR_AMIGO(11, 12);
CALL AGREGAR_AMIGO(11, 14);
CALL AGREGAR_AMIGO(12, 13);
CALL AGREGAR_AMIGO(13, 14);
CALL AGREGAR_AMIGO(13, 15);
CALL AGREGAR_AMIGO(14, 15);
CALL AGREGAR_AMIGO(14, 16);
CALL AGREGAR_AMIGO(15, 16);
CALL AGREGAR_AMIGO(15, 17);
CALL AGREGAR_AMIGO(16, 17);
