/* DROPS  */
DROP TABLE IF EXISTS Relacion;
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
    fid_hilo INT NOT NULL,
    fid_usuario INT NOT NULL,
	activo INT NOT NULL,
    PRIMARY KEY(id_mensaje),
    FOREIGN KEY(fid_hilo) REFERENCES Hilo(id_hilo),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
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
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Biblioteca.sql 
-- ------------------------------------------------------------------------------------- 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDBandaSonora.sql 
-- ------------------------------------------------------------------------------------- 
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
    IN _espacio_disco DECIMAL(10,2),
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
    IN _espacio_disco DECIMAL(10,2),
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
 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDBiblioteca.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_BIBLIOTECA;
DROP PROCEDURE IF EXISTS BUSCAR_BIBLIOTECA;

DELIMITER $

CREATE PROCEDURE INSERTAR_BIBLIOTECA(
    OUT _id_biblioteca INT,
    IN _fid_usuario INT
)
BEGIN
    -- Insertar nueva biblioteca para el usuario
    INSERT INTO Biblioteca(fid_usuario)
    VALUES (_fid_usuario);
    
    -- Obtener el último ID insertado
    SET _id_biblioteca = @@last_insert_id;
END$

CREATE PROCEDURE BUSCAR_BIBLIOTECA(
    IN _fid_usuario INT
)
BEGIN
    -- Buscar biblioteca por ID de usuario
    SELECT * FROM Biblioteca WHERE fid_usuario = _fid_usuario;
END$

DELIMITER ;
 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDColeccion.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_COLECCION;
DROP PROCEDURE IF EXISTS ACTUALIZAR_COLECCION;
DROP PROCEDURE IF EXISTS ELIMINAR_COLECCION;
DROP PROCEDURE IF EXISTS LISTAR_COLECCIONES;

DELIMITER $

CREATE PROCEDURE INSERTAR_COLECCION(
    OUT _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
    INSERT INTO Coleccion(nombre, fid_biblioteca, activo)
    VALUES (_nombre, _fid_biblioteca, 1);
    SET _id_coleccion = LAST_INSERT_ID();
END$

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

CREATE PROCEDURE ELIMINAR_COLECCION(
    IN _id_coleccion INT
)
BEGIN
    UPDATE Coleccion
    SET activo = false 
    WHERE id_coleccion = _id_coleccion;
END$

CREATE PROCEDURE LISTAR_COLECCIONES(
    IN _fid_biblioteca INT
)
BEGIN
    SELECT * FROM Coleccion 
    WHERE fid_biblioteca = _fid_biblioteca AND activo = 1;
END$

DELIMITER ;
 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDEtiqueta.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_ETIQUETA;
DROP PROCEDURE IF EXISTS LISTAR_ETIQUETAS;
DROP PROCEDURE IF EXISTS ACTUALIZAR_ETIQUETA;
DROP PROCEDURE IF EXISTS ELIMINAR_ETIQUETA;

DELIMITER $

CREATE PROCEDURE INSERTAR_ETIQUETA(
    OUT _id_etiqueta INT,
    IN _nombre VARCHAR(100)
)
BEGIN
    INSERT INTO Etiqueta (nombre, activo)
    VALUES (_nombre, 1);
    SET _id_etiqueta = @@last_insert_id;
END$

CREATE PROCEDURE LISTAR_ETIQUETAS()
BEGIN
    SELECT * FROM Etiqueta;
END$

CREATE PROCEDURE ACTUALIZAR_ETIQUETA(
    IN _id_etiqueta INT,
    IN _nombre VARCHAR(100)
)
BEGIN
    UPDATE Etiqueta
    SET nombre = _nombre
    WHERE id_etiqueta = _id_etiqueta;
END$

CREATE PROCEDURE ELIMINAR_ETIQUETA(
    IN _id_etiqueta INT
)
BEGIN
    UPDATE Etiqueta SET activo = 0 WHERE id_etiqueta = _id_etiqueta;
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDJuego.sql 
-- ------------------------------------------------------------------------------------- 
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
    IN _espacio_disco DECIMAL(10,2),
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
    IN _espacio_disco DECIMAL(10,2),
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
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDLogro.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_LOGRO;
DROP PROCEDURE IF EXISTS LISTAR_LOGROS;
DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRO;
DROP PROCEDURE IF EXISTS ELIMINAR_LOGRO;
DROP PROCEDURE IF EXISTS BUSCAR_LOGRO;
DROP PROCEDURE IF EXISTS LISTAR_LOGROS_X_ID_JUEGO;

DELIMITER $

CREATE PROCEDURE INSERTAR_LOGRO(
    OUT _id_logro INT,
    IN _nombre VARCHAR(100),
    IN _descripcion VARCHAR(200),
    IN _activo TINYINT,
    IN _fid_juego INT
)
BEGIN
    INSERT INTO Logro(nombre, descripcion, fid_juego, activo)
    VALUES (_nombre, _descripcion, _fid_juego, _activo);
    SET _id_logro = LAST_INSERT_ID();
END$

CREATE PROCEDURE LISTAR_LOGROS()
BEGIN
    SELECT l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro,
    p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion AS descripcion_producto,
    p.espacio_disco, p.activo AS producto_activo, j.multijugador, j.requisitos_minimos,
    j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = j.id_juego
    WHERE l.activo = 1;
END$

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

CREATE PROCEDURE ELIMINAR_LOGRO(
    IN _id_logro INT
)
BEGIN
    UPDATE Logro
    SET activo = false
    WHERE id_logro = _id_logro;
END$

CREATE PROCEDURE BUSCAR_LOGRO(
    IN _id_logro INT
)
BEGIN
    SELECT l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro,
    l.activo AS logro_activo, p.id_producto, p.titulo, p.fecha_publicacion, p.precio,
    p.descripcion AS descripcion_producto, p.espacio_disco, p.activo AS producto_activo,
    j.multijugador, j.requisitos_minimos, j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = j.id_juego
    WHERE l.id_logro = _id_logro;
END$

CREATE PROCEDURE LISTAR_LOGROS_X_ID_JUEGO(
    IN _id_juego INT
)
BEGIN
    SELECT l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro,
    p.id_producto, p.titulo, p.fecha_publicacion, p.precio, p.descripcion AS descripcion_producto,
    p.espacio_disco, p.activo AS producto_activo, j.multijugador, j.requisitos_minimos,
    j.requisitos_recomendados
    FROM Logro l
    INNER JOIN Juego j ON j.id_juego = l.fid_juego
    INNER JOIN Producto p ON p.id_producto = j.id_juego
    WHERE l.activo = 1 AND j.id_juego = _id_juego;
END$

DELIMITER ;
 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDLogroDesbloqueado.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_LOGRODESBLOQUEADO;
DROP PROCEDURE IF EXISTS LISTAR_LOGRODESBLOQUEADOPRODUCTO;
DROP PROCEDURE IF EXISTS ACTUALIZAR_LOGRODESBLOQUEADO;
DROP PROCEDURE IF EXISTS ELIMINAR_LOGRODESBLOQUEADO;
DROP PROCEDURE IF EXISTS LISTAR_LOGROS_POR_USUARIO;

DELIMITER $

CREATE PROCEDURE INSERTAR_LOGRODESBLOQUEADO(
    OUT _id_logro_desbloqueado INT,
    IN _fid_logro INT,
    IN _fid_producto_adquirido INT
)
BEGIN
    INSERT INTO LogroDesbloqueado (fecha_desbloqueo, fid_logro, fid_producto_adquirido, activo) 
    VALUES (DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), _fid_logro, _fid_producto_adquirido, 1);
    SET _id_logro_desbloqueado = @@last_insert_id;
END$

CREATE PROCEDURE LISTAR_LOGRODESBLOQUEADOPRODUCTO(
    IN _id_producto_adquirido INT
)
BEGIN
    SELECT ld.id_logro_desbloqueado, ld.fecha_desbloqueo, l.id_logro, l.nombre AS nombre_logro, l.descripcion AS descripcion_logro
    FROM LogroDesbloqueado ld
    INNER JOIN Logro l ON ld.fid_logro = l.id_logro
    WHERE ld.activo = 1 AND l.activo = 1
    AND ld.fid_producto_adquirido = _id_producto_adquirido;
END$

CREATE PROCEDURE ACTUALIZAR_LOGRODESBLOQUEADO(
    IN _id_logro_desbloqueado INT,
    IN _fecha_desbloqueo DATE
)
BEGIN
    UPDATE LogroDesbloqueado
    SET fecha_desbloqueo = _fecha_desbloqueo
    WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

CREATE PROCEDURE ELIMINAR_LOGRODESBLOQUEADO(
    IN _id_logro_desbloqueado INT
)
BEGIN
    UPDATE LogroDesbloqueado SET activo = 0 WHERE id_logro_desbloqueado = _id_logro_desbloqueado;
END$

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
    INNER JOIN Logro lo ON ld.fid_logro = lo.id_logro
    INNER JOIN Producto pr ON lo.fid_juego = pr.id_producto
    INNER JOIN ProductoAdquirido pa ON ld.fid_producto_adquirido = pa.id_producto_adquirido
    INNER JOIN Biblioteca bl ON pa.fid_biblioteca = bl.id_biblioteca
    WHERE ld.activo = 1 AND
          lo.activo = 1 AND
          pr.activo = 1 AND
          bl.fid_usuario = _id_usuario;
END$

DELIMITER ;
 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDProducto.sql 
-- ------------------------------------------------------------------------------------- 
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
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDProductoAdquirido.sql 
-- ------------------------------------------------------------------------------------- 
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
    VALUES (DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), CAST('00:00:00' AS TIME), false, false, _fid_biblioteca, _fid_producto, _fid_movimiento, 1);
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
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDProductoAdquiridoColeccion.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOADQUIRIDO_COLECCION;
DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOADQUIRIDO_COLECCION;

DELIMITER $

CREATE PROCEDURE INSERTAR_PRODUCTOADQUIRIDO_COLECCION(
    IN _fid_coleccion INT,
    IN _fid_producto_adquirido INT
)
BEGIN
    INSERT INTO ProductoAdquirido_Coleccion (fid_coleccion, fid_producto_adquirido, activo)
    VALUES (_fid_coleccion, _fid_producto_adquirido, 1)
    ON DUPLICATE KEY UPDATE activo = 1;
END$

CREATE PROCEDURE ELIMINAR_PRODUCTOADQUIRIDO_COLECCION(
    IN _fid_coleccion INT,
    IN _fid_producto_adquirido INT
)
BEGIN
    UPDATE ProductoAdquirido_Coleccion
    SET activo = 0
    WHERE fid_coleccion = _fid_coleccion AND fid_producto_adquirido = _fid_producto_adquirido;
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDProductoEtiqueta.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_PRODUCTOETIQUETA;
DROP PROCEDURE IF EXISTS LISTAR_PRODUCTOETIQUETA;
DROP PROCEDURE IF EXISTS ELIMINAR_PRODUCTOETIQUETA;

DELIMITER $

CREATE PROCEDURE INSERTAR_PRODUCTOETIQUETA(
    IN _fid_producto INT,
    IN _fid_etiqueta INT
)
BEGIN
    INSERT INTO ProductoEtiqueta(fid_producto, fid_etiqueta, activo)
    VALUES (_fid_producto, _fid_etiqueta, 1)
    ON DUPLICATE KEY UPDATE activo = 1;
END$

CREATE PROCEDURE LISTAR_PRODUCTOETIQUETA()
BEGIN
    SELECT * FROM ProductoEtiqueta;
END$

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

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDProveedor.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_PROVEEDOR;
DROP PROCEDURE IF EXISTS LISTAR_PROVEEDORES;
DROP PROCEDURE IF EXISTS ACTUALIZAR_PROVEEDOR;
DROP PROCEDURE IF EXISTS ELIMINAR_PROVEEDOR;

DELIMITER $

CREATE PROCEDURE INSERTAR_PROVEEDOR(
    OUT _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
    INSERT INTO Proveedor(razon_social, activo)
    VALUES (_razon_social, 1);
    SET _id_proveedor = LAST_INSERT_ID();
END$

CREATE PROCEDURE LISTAR_PROVEEDORES()
BEGIN
    SELECT * FROM Proveedor WHERE activo = 1;
END$

CREATE PROCEDURE ACTUALIZAR_PROVEEDOR(
    IN _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
    UPDATE Proveedor
    SET razon_social = _razon_social
    WHERE id_proveedor = _id_proveedor;
END$

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

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUDSoftware.sql 
-- ------------------------------------------------------------------------------------- 
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
    IN _espacio_disco DECIMAL(10,2),
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
    IN _espacio_disco DECIMAL(10,2),
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
 
 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Comunidad.sql 
-- ------------------------------------------------------------------------------------- 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUD_Foro.sql 
-- ------------------------------------------------------------------------------------- 
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

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUD_ForoUsuario.sql 
-- ------------------------------------------------------------------------------------- 
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
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUD_GestorSanciones.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_GESTOR;
DROP PROCEDURE IF EXISTS BUSCAR_GESTOR;
DROP PROCEDURE IF EXISTS EDITAR_GESTOR;

DELIMITER $

CREATE PROCEDURE INSERTAR_GESTOR(
    OUT _id_gestor INT,
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
    INSERT INTO GestorSanciones (
        fid_usuario, contador_faltas, contador_baneos, contador_palabras,
        max_faltas, max_baneos, cant_baneos, cant_faltas, activo
    )
    VALUES (
        _fid_usuario, _contador_faltas, _contador_baneos, _contador_palabras,
        _max_faltas, _max_baneos, _cant_baneos, _cant_faltas, true
    );
    SET _id_gestor = @@last_insert_id;
END$

CREATE PROCEDURE BUSCAR_GESTOR(
    IN _fid_usuario INT
)
BEGIN
    SELECT * FROM GestorSanciones
    WHERE fid_usuario = _fid_usuario;
END$

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
    UPDATE GestorSanciones
    SET contador_faltas = _contador_faltas,
        contador_baneos = _contador_baneos,
        contador_palabras = _contador_palabras,
        max_faltas = _max_faltas,
        max_baneos = _max_baneos,
        cant_baneos = _cant_baneos,
        cant_faltas = _cant_faltas,
        fin_ban = _fin_ban
    WHERE id_gestor = _id_gestor;
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUD_Hilo.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS CREAR_HILO;
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

CREATE PROCEDURE MOSTRAR_MENSAJES_POR_HILO(
	in _id_hilo INT 
)
BEGIN
	SELECT id_mensaje, contenido, fecha_publicacion, fecha_max_edicion, fid_usuario, nombre_perfil , foto_url FROM Mensaje, Usuario 
	WHERE fid_hilo = _id_hilo AND UID = fid_usuario
    AND oculto = 0;

END $

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

CREATE PROCEDURE DESACTIVAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE Hilo SET oculto = 1
    WHERE id_hilo = _id_hilo; 

END $

CREATE PROCEDURE ELIMINAR_HILO(
	IN _id_hilo INT
)
BEGIN
	UPDATE Hilo SET activo = 0
    WHERE id_hilo = _id_hilo; 

END $

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUD_mensaje.sql 
-- ------------------------------------------------------------------------------------- 
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

CREATE PROCEDURE MOSTRAR_MENSAJE(
	in _id_mensaje INT 
)
BEGIN
	SELECT * FROM mensaje 
    WHERE id_mensaje = _id_mensaje 
    AND oculto = 0;

END $

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

CREATE PROCEDURE DESACTIVAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE Mensaje SET oculto = 1
    WHERE id_mensaje = _id_mensaje; 

END $

CREATE PROCEDURE ELIMINAR_MENSAJE(
	IN _id_mensaje INT
)
BEGIN
	UPDATE Mensaje SET activo = 0
    WHERE id_mensaje = _id_mensaje; 

END $

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: CRUD_Subforo.sql 
-- ------------------------------------------------------------------------------------- 
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

CREATE PROCEDURE MOSTRAR_HILOS_POR_SUBFORO(
	in _id_subforo INT 
)
BEGIN
	SELECT id_hilo, nro_mensajes, imagen_url, fecha_creacion, fecha_modificacion,
		   fid_creador, nombre_perfil, foto_url
	FROM Hilo, Usuario
	WHERE fid_subforo = _id_subforo AND
		  UID = fid_creador
    AND oculto = 0;
END $
 
CREATE PROCEDURE EDITAR_SUBFORO(
	IN _id_subforo INT,
	IN _nombre VARCHAR(100)
)
BEGIN
	UPDATE Subforo SET nombre = _nombre
    WHERE id_subforo = _id_subforo; 

END $

CREATE PROCEDURE DESACTIVAR_SUBFORO(
	IN _id_subforo INT
)
BEGIN
	UPDATE Foro SET oculto = 1
    WHERE id_subforo = _id_subforo; 

END $

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Palabras_prohibidas.sql 
-- ------------------------------------------------------------------------------------- 
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

DELIMITER ; 
 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Usuario.sql 
-- ------------------------------------------------------------------------------------- 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Cartera.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_CARTERA;
DROP PROCEDURE IF EXISTS ACTUALIZAR_CARTERA;
DROP PROCEDURE IF EXISTS BUSCAR_CARTERA;

DELIMITER $

CREATE PROCEDURE INSERTAR_CARTERA(
    OUT _ID_CARTERA INT,
    IN _FID_USUARIO INT,
    IN _FONDOS DECIMAL(10, 2),
    IN _CANT_MOVIMIENTOS INT
)
BEGIN
    INSERT INTO Cartera (FID_USUARIO, FONDOS, cantidad_movimientos, ACTIVO)
    VALUES (_FID_USUARIO, _FONDOS, _CANT_MOVIMIENTOS, true);
    SET _ID_CARTERA = @@last_insert_id;
END$

CREATE PROCEDURE ACTUALIZAR_CARTERA(
    IN _ID_CARTERA INT,
    IN _FONDOS DECIMAL(10, 2),
    IN _CANT_MOVIMIENTOS INT
)
BEGIN
    UPDATE Cartera
    SET FONDOS = _FONDOS, cantidad_movimientos = _CANT_MOVIMIENTOS
    WHERE ID_CARTERA = _ID_CARTERA;
END$

CREATE PROCEDURE BUSCAR_CARTERA(
    IN _fid_usuario INT
)
BEGIN
    SELECT * FROM Cartera WHERE FID_USUARIO = _fid_usuario;
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Movimiento.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS CREAR_MOVIMIENTO;
DROP PROCEDURE IF EXISTS LISTAR_MOVIMIENTOS;
DROP PROCEDURE IF EXISTS BUSCAR_MOVIMIENTO;

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
END$

CREATE PROCEDURE LISTAR_MOVIMIENTOS(
    IN _FID_CARTERA INT
)
BEGIN
    SELECT id_movimiento, id_transaccion, fecha_transaccion AS fecha, monto, tipo, metodo_pago, fid_cartera 
    FROM Movimiento 
    WHERE FID_CARTERA = _FID_CARTERA;
END$

CREATE PROCEDURE BUSCAR_MOVIMIENTO(
    IN _ID_MOVIMIENTO INT
)
BEGIN
    SELECT id_movimiento, id_transaccion, fecha_transaccion AS fecha, monto, tipo, metodo_pago, fid_cartera 
    FROM Movimiento 
    WHERE ID_MOVIMIENTO = _ID_MOVIMIENTO;
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Notificacion.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS CREAR_NOTIFICACION;
DROP PROCEDURE IF EXISTS ELIMINAR_NOTIFICACION;
DROP PROCEDURE IF EXISTS ACTUALIZAR_NOTIFICACION;
DROP PROCEDURE IF EXISTS LISTAR_NOTIFICACIONES;
DROP PROCEDURE IF EXISTS ELIMINAR_NOTIFICACIONES_USUARIO;
DROP PROCEDURE IF EXISTS MARCAR_NOTIFICACION_LEIDA;

DELIMITER $

CREATE PROCEDURE CREAR_NOTIFICACION(
    OUT _ID_NOTIFICACION INT,
    IN _TIPO VARCHAR(30),
    IN _MENSAJE VARCHAR(200),
    IN _FID_USUARIO INT
)
BEGIN
    INSERT INTO Notificacion (TIPO, MENSAJE, FID_USUARIO, REVISADA, ACTIVO, FECHA)
    VALUES (_TIPO, _MENSAJE, _FID_USUARIO, FALSE, TRUE, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')));
    SET _ID_NOTIFICACION = LAST_INSERT_ID();
END$

CREATE PROCEDURE ELIMINAR_NOTIFICACION(
    IN _ID_NOTIFICACION INT
)
BEGIN
    UPDATE Notificacion SET ACTIVO = FALSE WHERE ID_NOTIFICACION = _ID_NOTIFICACION;
END$

CREATE PROCEDURE ACTUALIZAR_NOTIFICACION(
    IN _ID_NOTIFICACION INT,
    IN _TIPO VARCHAR(30),
    IN _MENSAJE VARCHAR(200),
    IN _FID_USUARIO INT,
    IN _REVISADA TINYINT
)
BEGIN
    UPDATE Notificacion 
    SET TIPO = _TIPO, MENSAJE = _MENSAJE, FID_USUARIO = _FID_USUARIO, REVISADA = _REVISADA
    WHERE ID_NOTIFICACION = _ID_NOTIFICACION;
END$

CREATE PROCEDURE LISTAR_NOTIFICACIONES(
    IN _FID_USUARIO INT
)
BEGIN
    SELECT * FROM Notificacion WHERE FID_USUARIO = _FID_USUARIO AND ACTIVO = TRUE ORDER BY FECHA DESC;
END$

CREATE PROCEDURE ELIMINAR_NOTIFICACIONES_USUARIO(
    IN _FID_USUARIO INT
)
BEGIN
    UPDATE Notificacion SET ACTIVO = FALSE WHERE FID_USUARIO = _FID_USUARIO;
END$

CREATE PROCEDURE MARCAR_NOTIFICACION_LEIDA(
    IN _id_notificacion INT
)
BEGIN
    UPDATE Notificacion SET REVISADA = TRUE WHERE ID_NOTIFICACION = _id_notificacion;
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Pais.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS CREAR_PAIS;
DROP PROCEDURE IF EXISTS BUSCAR_PAIS;
DROP PROCEDURE IF EXISTS LISTAR_PAISES;
DROP PROCEDURE IF EXISTS ACTUALIZAR_PAIS;

DELIMITER $

CREATE PROCEDURE CREAR_PAIS(
    OUT _ID_PAIS INT,
    IN _NOMBRE VARCHAR(100),
    IN _CODIGO CHAR(3),
    IN _FID_MONEDA INT
)
BEGIN
    INSERT INTO Pais (NOMBRE, CODIGO, ACTIVO, FID_MONEDA)
    VALUES (_NOMBRE, _CODIGO, 1, _FID_MONEDA);
    SET _ID_PAIS = @@last_insert_id;
END$

CREATE PROCEDURE BUSCAR_PAIS(
    IN _ID_PAIS INT
)
BEGIN
    SELECT p.id_pais, p.nombre AS nombre_pais, p.codigo AS codigo_pais,
           m.id_tipo_moneda, m.nombre AS nombre_moneda, m.codigo AS codigo_moneda,
           m.simbolo, m.cambio_de_dolares, m.fecha_cambio, m.activo AS moneda_activa
    FROM Pais p
    INNER JOIN TipoMoneda m ON m.id_tipo_moneda = p.fid_moneda
    WHERE p.activo = 1 AND p.id_pais = _ID_PAIS;
END$

CREATE PROCEDURE LISTAR_PAISES()
BEGIN
    SELECT p.id_pais, p.nombre AS nombre_pais, p.codigo AS codigo_pais,
           m.id_tipo_moneda, m.nombre AS nombre_moneda, m.codigo AS codigo_moneda,
           m.simbolo, m.cambio_de_dolares, m.fecha_cambio, m.activo AS moneda_activa
    FROM Pais p
    INNER JOIN TipoMoneda m ON m.id_tipo_moneda = p.fid_moneda
    WHERE p.activo = 1;
END$

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
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Relacion.sql 
-- ------------------------------------------------------------------------------------- 
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

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: TipoMoneda.sql 
-- ------------------------------------------------------------------------------------- 
DROP PROCEDURE IF EXISTS INSERTAR_TIPOMONEDA;
DROP PROCEDURE IF EXISTS LISTAR_TIPOMONEDAS;
DROP PROCEDURE IF EXISTS ACTUALIZAR_TIPOMONEDA;
DROP PROCEDURE IF EXISTS ELIMINAR_TIPOMONEDA;

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
    VALUES (_nombre, _codigo, _simbolo, _cambio_de_dolares, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), 1);
    SET _id_tipo_moneda = @@last_insert_id;
END$

CREATE PROCEDURE LISTAR_TIPOMONEDAS()
BEGIN
    SELECT * FROM TipoMoneda WHERE activo = 1;
END$

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
        fecha_cambio = DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))
    WHERE id_tipo_moneda = _id_tipo_moneda;
END$

CREATE PROCEDURE ELIMINAR_TIPOMONEDA(
    IN _id_tipo_moneda INT
)
BEGIN
    UPDATE TipoMoneda
    SET activo = 0
    WHERE id_tipo_moneda = _id_tipo_moneda;
END$

DELIMITER ; 
-- ------------------------------------------------------------------------------------- 
-- ARCHIVO: Usuario.sql 
-- ------------------------------------------------------------------------------------- 
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
 
-- -------------------------------------------------------------------------------------------
--												MONEDAS
-- -------------------------------------------------------------------------------------------
-- Insertamos Nuevo Sol Peruano y almacenamos su ID
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda_pen, 'Nuevo Sol Peruano', 'PEN', 'S/', 3.73);

-- Insertamos Dólar Estadounidense y almacenamos su ID
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda_usd, 'Dólar Estadounidense', 'USD', '$', 1);

-- Insertamos Euro y almacenamos su ID
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda_eur, 'Euro', 'EUR', '€', 0.93);



-- ---------------------------------------------------------------------------------------------
--												PAISES
-- ---------------------------------------------------------------------------------------------
-- Insertamos Perú con la moneda Nuevo Sol Peruano
CALL CREAR_PAIS(@id_pais_per, 'Perú', 'PER', @id_tipo_moneda_pen);

-- Insertamos Estados Unidos con la moneda Dólar Estadounidense
CALL CREAR_PAIS(@id_pais_usa, 'Estados Unidos', 'USA', @id_tipo_moneda_usd);

-- Insertamos España con la moneda Euro
CALL CREAR_PAIS(@id_pais_esp, 'España', 'ESP', @id_tipo_moneda_eur);

-- Insertamos Alemania con la moneda Euro
CALL CREAR_PAIS(@id_pais_deu, 'Alemania', 'DEU', @id_tipo_moneda_eur);

-- Insertamos Francia con la moneda Euro
CALL CREAR_PAIS(@id_pais_fra, 'Francia', 'FRA', @id_tipo_moneda_eur);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												USUARIOS
-- ---------------------------------------------------------------------------------------------
-- Usuarios en Perú
CALL CREAR_USUARIO(@id_usuario_fabricio, 'cuenta_fabricio', 'Fabricio', 
				   'fabricio@gmail.com', '937462819', 'fabricio', 
				   TIMESTAMPDIFF(YEAR, '1995-12-09', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1995-12-09', 1, @id_pais_per);

CALL CREAR_USUARIO(@id_usuario_ana, 'cuenta_ana', 'Ana', 
				   'ana@gmail.com', '987654321', 'ana', 
				   TIMESTAMPDIFF(YEAR, '1988-04-23', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1988-04-23', 1, @id_pais_per);

CALL CREAR_USUARIO(@id_usuario_julio, 'cuenta_julio', 'Julio', 
				   'julio@yahoo.com', '923456789', 'julio', 
				   TIMESTAMPDIFF(YEAR, '1990-07-15', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1990-07-15', 0, @id_pais_per);

-- Usuarios en Estados Unidos
CALL CREAR_USUARIO(@id_usuario_sofia, 'cuenta_sofia', 'Sofia', 
				   'sofia@hotmail.com', '982746573', 'sofia', 
				   TIMESTAMPDIFF(YEAR, '2000-05-11', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '2000-05-11', 0, @id_pais_usa);

CALL CREAR_USUARIO(@id_usuario_john, 'cuenta_john', 'John', 
				   'john@gmail.com', '932457689', 'john', 
				   TIMESTAMPDIFF(YEAR, '1985-03-03', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1985-03-03', 1, @id_pais_usa);

CALL CREAR_USUARIO(@id_usuario_emily, 'cuenta_emily', 'Emily', 
				   'emily@yahoo.com', '945678234', 'emily', 
				   TIMESTAMPDIFF(YEAR, '1992-11-25', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1992-11-25', 1, @id_pais_usa);

-- Usuarios en España
CALL CREAR_USUARIO(@id_usuario_pablo, 'cuenta_pablo', 'Pablo', 
				   'pablo@gmail.com', '912345678', 'pablo', 
				   TIMESTAMPDIFF(YEAR, '1993-06-14', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1993-06-14', 0, @id_pais_esp);

CALL CREAR_USUARIO(@id_usuario_maria, 'cuenta_maria', 'Maria', 
				   'maria@yahoo.com', '923456789', 'maria', 
				   TIMESTAMPDIFF(YEAR, '1987-09-10', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1987-09-10', 1, @id_pais_esp);

CALL CREAR_USUARIO(@id_usuario_luis, 'cuenta_luis', 'Luis', 
				   'luis@hotmail.com', '932156789', 'luis', 
				   TIMESTAMPDIFF(YEAR, '1999-01-20', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1999-01-20', 0, @id_pais_esp);

-- Usuarios en Alemania
CALL CREAR_USUARIO(@id_usuario_hans, 'cuenta_hans', 'Hans', 
				   'hans@gmail.com', '914567890', 'hans', 
				   TIMESTAMPDIFF(YEAR, '1984-12-30', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1984-12-30', 1, @id_pais_deu);

CALL CREAR_USUARIO(@id_usuario_anna, 'cuenta_anna', 'Anna', 
				   'anna@hotmail.com', '923456123', 'anna', 
				   TIMESTAMPDIFF(YEAR, '1996-07-19', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1996-07-19', 0, @id_pais_deu);

CALL CREAR_USUARIO(@id_usuario_fritz, 'cuenta_fritz', 'Fritz', 
				   'fritz@yahoo.com', '937654321', 'fritz', 
				   TIMESTAMPDIFF(YEAR, '1995-10-05', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1995-10-05', 1, @id_pais_deu);

-- Usuarios en Francia
CALL CREAR_USUARIO(@id_usuario_pierre, 'cuenta_pierre', 'Pierre', 
				   'pierre@gmail.com', '915678234', 'pierre', 
				   TIMESTAMPDIFF(YEAR, '1982-11-02', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1982-11-02', 1, @id_pais_fra);

CALL CREAR_USUARIO(@id_usuario_claire, 'cuenta_claire', 'Claire', 
				   'claire@yahoo.com', '923456789', 'claire', 
				   TIMESTAMPDIFF(YEAR, '1997-04-12', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1997-04-12', 0, @id_pais_fra);

CALL CREAR_USUARIO(@id_usuario_jean, 'cuenta_jean', 'Jean', 
				   'jean@hotmail.com', '937654987', 'jean', 
				   TIMESTAMPDIFF(YEAR, '1989-08-22', DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima'))),
				   '1989-08-22', 1, @id_pais_fra);
---------------------------------------------------------------------------------------------



-- -------------------------------------------------------------------------------------------
--											ASIGNACIÓN DE foto_url A USUARIOS
-- -------------------------------------------------------------------------------------------
-- Usuarios en Perú
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_fabricioFoto.png' WHERE UID = @id_usuario_fabricio;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_anaFoto.png' WHERE UID = @id_usuario_ana;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_julioFoto.jpeg' WHERE UID = @id_usuario_julio;

-- Usuarios en Estados Unidos
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_sofiaFoto.jpg' WHERE UID = @id_usuario_sofia;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_johnFoto.jpg' WHERE UID = @id_usuario_john;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_emilyFoto.png' WHERE UID = @id_usuario_emily;

-- Usuarios en España
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_pabloFoto.jpg' WHERE UID = @id_usuario_pablo;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_mariaFoto.png' WHERE UID = @id_usuario_maria;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_luisFoto.jpg' WHERE UID = @id_usuario_luis;

-- Usuarios en Alemania
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_hansFoto.png' WHERE UID = @id_usuario_hans;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_annaFoto.jpg' WHERE UID = @id_usuario_anna;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_fritzFoto.png' WHERE UID = @id_usuario_fritz;

-- Usuarios en Francia
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_pierreFoto.png' WHERE UID = @id_usuario_pierre;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_claireFoto.jpg' WHERE UID = @id_usuario_claire;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_jeanFoto.jpg' WHERE UID = @id_usuario_jean;
---------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------
--												CARTERA
-- ---------------------------------------------------------------------------------------------
-- Cartera para Usuarios en Perú
CALL INSERTAR_CARTERA(@id_cartera_fabricio, @id_usuario_fabricio, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_ana, @id_usuario_ana, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_julio, @id_usuario_julio, 0, 0);

-- Cartera para Usuarios en Estados Unidos
CALL INSERTAR_CARTERA(@id_cartera_sofia, @id_usuario_sofia, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_john, @id_usuario_john, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_emily, @id_usuario_emily, 0, 0);

-- Cartera para Usuarios en España
CALL INSERTAR_CARTERA(@id_cartera_pablo, @id_usuario_pablo, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_maria, @id_usuario_maria, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_luis, @id_usuario_luis, 0, 0);

-- Cartera para Usuarios en Alemania
CALL INSERTAR_CARTERA(@id_cartera_hans, @id_usuario_hans, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_anna, @id_usuario_anna, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_fritz, @id_usuario_fritz, 0, 0);

-- Cartera para Usuarios en Francia
CALL INSERTAR_CARTERA(@id_cartera_pierre, @id_usuario_pierre, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_claire, @id_usuario_claire, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_jean, @id_usuario_jean, 0, 0);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												BIBLIOTECA
-- ---------------------------------------------------------------------------------------------
-- Biblioteca para Usuarios en Perú
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_fabricio, @id_usuario_fabricio);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_ana, @id_usuario_ana);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_julio, @id_usuario_julio);

-- Biblioteca para Usuarios en Estados Unidos
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_sofia, @id_usuario_sofia);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_john, @id_usuario_john);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_emily, @id_usuario_emily);

-- Biblioteca para Usuarios en España
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_pablo, @id_usuario_pablo);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_maria, @id_usuario_maria);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_luis, @id_usuario_luis);

-- Biblioteca para Usuarios en Alemania
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_hans, @id_usuario_hans);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_anna, @id_usuario_anna);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_fritz, @id_usuario_fritz);

-- Biblioteca para Usuarios en Francia
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_pierre, @id_usuario_pierre);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_claire, @id_usuario_claire);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_jean, @id_usuario_jean);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												PROVEEDOR
-- ---------------------------------------------------------------------------------------------
-- Proveedor para Juegos
CALL INSERTAR_PROVEEDOR(@id_proveedor_assassins_creed, 'Ubisoft');
CALL INSERTAR_PROVEEDOR(@id_proveedor_resident_evil, 'Capcom');
CALL INSERTAR_PROVEEDOR(@id_proveedor_geometry_dash, 'RobTop Games');
CALL INSERTAR_PROVEEDOR(@id_proveedor_maplestory, 'Nexon');
CALL INSERTAR_PROVEEDOR(@id_proveedor_guild_wars_2, 'ArenaNet');
CALL INSERTAR_PROVEEDOR(@id_proveedor_fallout_4, 'Bethesda Softworks');
CALL INSERTAR_PROVEEDOR(@id_proveedor_doom, 'Bethesda Softworks');
CALL INSERTAR_PROVEEDOR(@id_proveedor_world_of_goo, '2D Boy');

-- Proveedor para Software
CALL INSERTAR_PROVEEDOR(@id_proveedor_wallpaper_engine, 'Wallpaper Engine');
CALL INSERTAR_PROVEEDOR(@id_proveedor_lossless_scaling, 'Lossless Scaling');
CALL INSERTAR_PROVEEDOR(@id_proveedor_aseprite, 'Aseprite');

-- Proveedor para Bandas Sonoras
CALL INSERTAR_PROVEEDOR(@id_proveedor_hollow_knight_soundtrack, 'Team Cherry');
CALL INSERTAR_PROVEEDOR(@id_proveedor_nine_sols_soundtrack, 'Nine Sols');
CALL INSERTAR_PROVEEDOR(@id_proveedor_sparking_zero, 'Spike Chunsoft');




-- ---------------------------------------------------------------------------------------------
--												ETIQUETAS
-- ---------------------------------------------------------------------------------------------
-- Etiqueta Terror
CALL INSERTAR_ETIQUETA(@id_etiqueta_terror, 'Terror');

-- Etiqueta Puzzle
CALL INSERTAR_ETIQUETA(@id_etiqueta_puzzle, 'Puzzle');

-- Etiqueta RPG
CALL INSERTAR_ETIQUETA(@id_etiqueta_rpg, 'RPG');

-- Etiqueta Casual
CALL INSERTAR_ETIQUETA(@id_etiqueta_casual, 'Casual');

-- Etiqueta Accion
CALL INSERTAR_ETIQUETA(@id_etiqueta_accion, 'Accion');

-- Etiqueta Utilidad
CALL INSERTAR_ETIQUETA(@id_etiqueta_utilidad, 'Utilidad');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												JUEGO
-- ---------------------------------------------------------------------------------------------
-- Juego: Assassin's Creed Odyssey
CALL INSERTAR_JUEGO(@id_juego_assassins_creed, @id_proveedor_assassins_creed, 
					'Assassin''s Creed Odyssey', '2018-10-05', 59.99, 
					'Viaja a la Antigua Grecia y vive épicas aventuras como un espartano.', 
					5000.0, 'Uploads/Productos/Logo-AssassinsCreedOdyssey.png',
					'Uploads/Productos/Header-AssassinsCreedOdyssey.jpg', 
					1, 'Intel Core i5, 8 GB RAM, GTX 970',
					'Intel Core i7, 16 GB RAM, GTX 1080 Ti', 1);
				
-- Juego: Resident Evil 5: Gold Edition
CALL INSERTAR_JUEGO(@id_juego_resident_evil, @id_proveedor_resident_evil, 
					'Resident Evil 5: Gold Edition', '2015-03-27', 29.99, 
					'Revive la acción y el terror con Chris Redfield y Sheva Alomar en África.', 
					2500.0, 'Uploads/Productos/Logo-ResidentEvil5.png',
					'Uploads/Productos/Header-ResidentEvil5.jpg', 
					1, 'Intel Core i3, 4 GB RAM, GTX 560',
					'Intel Core i5, 8 GB RAM, GTX 760', 1);
				
-- Juego: Geometry Dash
CALL INSERTAR_JUEGO(@id_juego_geometry_dash, @id_proveedor_geometry_dash, 
					'Geometry Dash', '2013-08-13', 3.99, 
					'Supera obstáculos geométricos en este juego de plataformas rítmico.', 
					100.0, 'Uploads/Productos/Logo-GeometryDash.png',
					'Uploads/Productos/Header-GeometryDash.jpg', 
					1, 'Procesador de 2.0 GHz, 1 GB RAM, Gráficos integrados',
					'Procesador de 2.4 GHz, 2 GB RAM, Gráficos dedicados', 0);

-- Juego: Maplestory
CALL INSERTAR_JUEGO(@id_juego_maplestory, @id_proveedor_maplestory, 
					'Maplestory', '2003-04-29', 1.0, 
					'Adéntrate en el mundo colorido y fantástico de Maplestory.', 
					200.0, 'Uploads/Productos/Logo-Maplestory.png',
					'Uploads/Productos/Header-Maplestory.jpg', 
					1, 'Pentium 3 a 800 MHz, 256 MB RAM, Gráficos 3D',
					'Pentium 4 a 1.5 GHz, 512 MB RAM, Gráficos acelerados', 1);

-- Juego: Guild Wars 2
CALL INSERTAR_JUEGO(@id_juego_guild_wars_2, @id_proveedor_guild_wars_2, 
					'Guild Wars 2', '2012-08-28', 29.99, 
					'Explora Tyria y lucha en un mundo en constante cambio.', 
					5000.0, 'Uploads/Productos/Logo-GuildWars2.png',
					'Uploads/Productos/Header-GuildWars2.jpeg', 
					1, 'Intel Core 2 Duo, 2 GB RAM, GeForce 7800',
					'Intel Core i5, 4 GB RAM, GeForce GTX 560', 1);

-- Juego: Fallout 4
CALL INSERTAR_JUEGO(@id_juego_fallout_4, @id_proveedor_fallout_4, 
					'Fallout 4', '2015-11-10', 39.99, 
					'Explora un mundo post-apocalíptico lleno de peligros y posibilidades.', 
					3000.0, 'Uploads/Productos/Logo-Fallout4.png',
					'Uploads/Productos/Header-Fallout4.jpg', 
					1, 'Intel Core i5, 8 GB RAM, GTX 780',
					'Intel Core i7, 8 GB RAM, GTX 1080', 0);
				
-- Juego: DOOM
CALL INSERTAR_JUEGO(@id_juego_doom, @id_proveedor_doom, 
					'DOOM', '2016-05-13', 19.99, 
					'Elimina demonios en Marte con un arsenal de armas increíbles.', 
					2500.0, 'Uploads/Productos/Logo-DOOM.png', 'Uploads/Productos/Header-DOOM.jpg', 
					1, 'Intel Core i5, 8 GB RAM, GTX 670',
					'Intel Core i7, 16 GB RAM, GTX 970', 1);
				
-- Juego: World Of Goo
CALL INSERTAR_JUEGO(@id_juego_world_of_goo, @id_proveedor_world_of_goo, 
					'World Of Goo', '2008-10-13', 9.99, 
					'Construye estructuras con criaturas adhesivas en este juego de puzzles.', 
					50, 'Uploads/Productos/Logo-WorldOfGoo.jpg',
					'Uploads/Productos/Header-WorldOfGoo.jpg', 
					1, 'Procesador de 1.0 GHz, 512 MB RAM, Gráficos integrados',
					'Procesador de 1.5 GHz, 1 GB RAM, Gráficos dedicados', 0);
                    
-- Juego: Sparking Zero
CALL INSERTAR_JUEGO(@id_juego_sparking_zero, @id_proveedor_sparking_zero, 
					'Sparking! Zero', '2024-05-11', 69.99, 
					'Recopilando lo mejor de todos los juegos de la franquicia Dragon Ball.', 
					7000, 'Uploads/Productos/Logo-SparkingZero.png',
					'Uploads/Productos/Header-SparkingZero.jpg', 
					1, 'Procesador i5 y un sistema operativo de 64 bits',
					'Procesador i7 y un sistema operativo de 64 bits', 1);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												BANDAS SONORAS
-- ---------------------------------------------------------------------------------------------
-- Banda Sonora: Hollow Knight - Official Soundtrack
CALL INSERTAR_BANDASONORA(@id_banda_sonora_hollow_knight,
						  @id_proveedor_hollow_knight_soundtrack,
						  'Hollow Knight - Official Soundtrack', '2017-02-10', 9.99,
						  'Banda sonora oficial del aclamado juego de acción y aventura Hollow Knight.', 
						  50, 'Uploads/Productos/Logo-HollowKnightSoundtrack.jpg',
						  'Uploads/Productos/Header-HollowKnightSoundtrack.jpg', 
						  1, 'Christopher Larkin', 'Christopher Larkin', '01:42:16');

-- Banda Sonora: Nine Sols Soundtrack
CALL INSERTAR_BANDASONORA(@id_banda_sonora_nine_sols, @id_proveedor_nine_sols_soundtrack,
						  'Nine Sols Soundtrack', '2022-04-15', 14.99,
						  'Banda sonora del juego indie Nine Sols, mezclando elementos electrónicos y atmosféricos.', 
						  80, 'Uploads/Productos/Logo-NineSolsSoundtrack.png',
						  'Uploads/Productos/Header-NineSolsSoundtrack.jpg', 
						  1, 'Samuel Laflamme', 'Samuel Laflamme', '01:18:45');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												SOFTWARE
-- ---------------------------------------------------------------------------------------------
-- Software: Wallpaper Engine
CALL INSERTAR_SOFTWARE(@id_software_wallpaper_engine, @id_proveedor_wallpaper_engine,
					   'Wallpaper Engine', '2016-10-16', 3.99,
					   'Permite usar vídeos y aplicaciones interactivas como fondos de pantalla.', 
					   10, 'Uploads/Productos/Logo-WallpaperEngine.png',
					   'Uploads/Productos/Header-WallpaperEngine.jpg', 
					   1, 'Windows 7 (64-bit), 1 GB RAM, DirectX 11', 'Freeware');

-- Software: Lossless Scaling
CALL INSERTAR_SOFTWARE(@id_software_lossless_scaling, @id_proveedor_lossless_scaling,
					   'Lossless Scaling', '2018-05-29', 9.99,
					   'Herramienta para escalar imágenes y gráficos sin pérdida de calidad.', 
					   20, 'Uploads/Productos/Logo-LosslessScaling.png',
					   'Uploads/Productos/Header-LosslessScaling.jpg', 
					   1, 'Windows 10 (64-bit), 2 GB RAM, DirectX 12', 'Propietaria');

-- Software: Aseprite
CALL INSERTAR_SOFTWARE(@id_software_aseprite, @id_proveedor_aseprite,
					   'Aseprite', '2016-02-22', 19.99,
					   'Editor de gráficos y animaciones para crear sprites y pixel art.', 
					   30, 'Uploads/Productos/Logo-Aseprite.png',
					   'Uploads/Productos/Header-Aseprite.jpg', 
					   1, 'Windows 8 (64-bit), 4 GB RAM, OpenGL 3.3', 'Open Source');
---------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------
--											PRODUCTO - ETIQUETA
-- ---------------------------------------------------------------------------------------------
-- Juegos y sus etiquetas
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_assassins_creed, 5); -- Accion
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_assassins_creed, 3); -- RPG

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_resident_evil, 1); -- Terror
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_resident_evil, 5); -- Accion

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_geometry_dash, 4); -- Casual
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_geometry_dash, 6); -- Utilidad

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_maplestory, 3); -- RPG
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_maplestory, 4); -- Casual

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_guild_wars_2, 3); -- RPG
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_guild_wars_2, 5); -- Accion

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_fallout_4, 5); -- Accion
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_fallout_4, 3); -- RPG

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_doom, 5); -- Accion
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_doom, 1); -- Terror

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_world_of_goo, 4); -- Casual
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_world_of_goo, 6); -- Utilidad

-- Bandas Sonoras y sus etiquetas
CALL INSERTAR_PRODUCTOETIQUETA(@id_banda_sonora_hollow_knight, 2); -- Puzzle

CALL INSERTAR_PRODUCTOETIQUETA(@id_banda_sonora_nine_sols, 1); -- Terror

-- Software y sus etiquetas
CALL INSERTAR_PRODUCTOETIQUETA(@id_software_wallpaper_engine, 6); -- Utilidad

CALL INSERTAR_PRODUCTOETIQUETA(@id_software_lossless_scaling, 6); -- Utilidad

CALL INSERTAR_PRODUCTOETIQUETA(@id_software_aseprite, 6); -- Utilidad
CALL INSERTAR_PRODUCTOETIQUETA(@id_software_aseprite, 2); -- Puzzle

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_sparking_zero, 5);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												LOGROS
-- ---------------------------------------------------------------------------------------------
-- Logros del juego Assassin's Creed Odyssey
CALL INSERTAR_LOGRO(@id_logro_ac_odyssey_1,
					'Héroe de Esparta', 'Completa la historia principal del juego.',
					1, @id_juego_assassins_creed);

CALL INSERTAR_LOGRO(@id_logro_ac_odyssey_2,
					'Maestro del Olimpo', 'Alcanza el nivel máximo de experiencia.',
					1, @id_juego_assassins_creed);

CALL INSERTAR_LOGRO(@id_logro_ac_odyssey_3,
					'Conquistador', 'Completa todas las conquistas del juego.',
					1, @id_juego_assassins_creed);

-- Logros del juego Resident Evil 5: Gold Edition
CALL INSERTAR_LOGRO(@id_logro_resident_evil_5_1, 'Superviviente',
					'Sobrevive a todas las oleadas de enemigos en el modo Mercenarios.',
					1, @id_juego_resident_evil);

CALL INSERTAR_LOGRO(@id_logro_resident_evil_5_2, 'Explorador',
					'Descubre todos los secretos ocultos en las zonas de juego.',
					1, @id_juego_resident_evil);

-- Logros del juego Geometry Dash
CALL INSERTAR_LOGRO(@id_logro_geometry_dash_1, 'Ritmo Perfecto',
					'Completa cualquier nivel sin perder ritmo ni cometer errores.',
					1, @id_juego_geometry_dash);

-- Logros del juego Maplestory
CALL INSERTAR_LOGRO(@id_logro_maplestory_1, 'Explorador del Mundo',
					'Explora todas las regiones disponibles del juego.',
					1, @id_juego_maplestory);

-- Logros del juego Guild Wars 2
CALL INSERTAR_LOGRO(@id_logro_guild_wars_2_1, 'Leyenda Viviente',
					'Alcanza el rango de leyenda en el modo JcJ.',
					1, @id_juego_guild_wars_2);

CALL INSERTAR_LOGRO(@id_logro_guild_wars_2_2, 'Rey de la Colina',
					'Domina todas las fortalezas y torres en el mundo del juego.',
					1, @id_juego_guild_wars_2);

-- Logros del juego Fallout 4
CALL INSERTAR_LOGRO(@id_logro_fallout_4_1, 'Libertador',
					'Libera a todas las facciones principales del yugo de la opresión.',
					1, @id_juego_fallout_4);

-- Logros del juego DOOM
CALL INSERTAR_LOGRO(@id_logro_doom_1, 'Destructor de Demonios',
					'Aniquila a todos los jefes demoníacos en el Infierno.',
					1, @id_juego_doom);

CALL INSERTAR_LOGRO(@id_logro_doom_2, 'Inmortal',
					'Completa el juego en el nivel de dificultad más alto sin morir.',
					1, @id_juego_doom);

-- Logros del juego World of Goo
CALL INSERTAR_LOGRO(@id_logro_world_of_goo_1, 'Arquitecto Estelar',
					'Construye la torre más alta con Goo Balls en el Mundo Goo.',
					1, @id_juego_world_of_goo);

CALL INSERTAR_LOGRO(@id_logro_world_of_goo_2, 'Ingeniero de Puentes',
					'Construye puentes que soporten el peso de todos los Goo Balls.',
					1, @id_juego_world_of_goo);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												FOROS
-- ---------------------------------------------------------------------------------------------
-- Foro de Assassin's Creed Odyssey
CALL CREAR_FORO(@id_foro_ac_odyssey,
				'Odyssey Fans',
				'Foro para discutir todo sobre Assassin''s Creed Odyssey.',
				'Fabricio');

-- Foro de Resident Evil 5: Gold Edition
CALL CREAR_FORO(@id_foro_resident_evil_5,
				'RE5 Gold Community',
				'Comunidad para fanáticos de Resident Evil 5: Gold Edition.',
				'Ana');

-- Foro de Geometry Dash
CALL CREAR_FORO(@id_foro_geometry_dash,
				'Dashers Community',
				'Comunidad de jugadores de Geometry Dash para compartir niveles y consejos.',
				'Julio');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												SUBFOROS
-- ---------------------------------------------------------------------------------------------
-- Subforos de Assassin's Creed Odyssey
CALL CREAR_SUBFORO(@id_subforo_ac_odyssey_1,
				   @id_foro_ac_odyssey,
				   'Guías y Consejos');

CALL CREAR_SUBFORO(@id_subforo_ac_odyssey_2,
				   @id_foro_ac_odyssey,
				   'Discusión General');

CALL CREAR_SUBFORO(@id_subforo_ac_odyssey_3,
				   @id_foro_ac_odyssey,
				   'Problemas Técnicos');

-- Subforos de Resident Evil 5: Gold Edition
CALL CREAR_SUBFORO(@id_subforo_resident_evil_5_1,
				   @id_foro_resident_evil_5,
				   'Estrategias y Trucos');

CALL CREAR_SUBFORO(@id_subforo_resident_evil_5_2,
				   @id_foro_resident_evil_5,
				   'Modo Mercenarios');

CALL CREAR_SUBFORO(@id_subforo_resident_evil_5_3,
				   @id_foro_resident_evil_5,
				   'Soporte Técnico');

-- Subforos de Geometry Dash
CALL CREAR_SUBFORO(@id_subforo_geometry_dash_1,
				   @id_foro_geometry_dash,
				   'Creación de Niveles');

CALL CREAR_SUBFORO(@id_subforo_geometry_dash_2,
				   @id_foro_geometry_dash,
				   'Desafíos y Competencias');

CALL CREAR_SUBFORO(@id_subforo_geometry_dash_3,
				   @id_foro_geometry_dash,
				   'Ayuda y Consejos');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												HILOS
-- ---------------------------------------------------------------------------------------------
-- Hilos en los subforos de Assassin's Creed Odyssey
CALL CREAR_HILO(@id_hilo_ac_odyssey_1, @id_subforo_ac_odyssey_1,
				@id_usuario_fabricio, 0, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/AssassinsCreedHilo1.jpg');

CALL CREAR_HILO(@id_hilo_ac_odyssey_2, @id_subforo_ac_odyssey_2,
				@id_usuario_ana, 1, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/AssassinsCreedHilo2.jpg');

CALL CREAR_HILO(@id_hilo_ac_odyssey_3, @id_subforo_ac_odyssey_3,
				@id_usuario_julio, 0, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/AssassinsCreedHilo3.jpg');

-- Hilos en los subforos de Resident Evil 5: Gold Edition
CALL CREAR_HILO(@id_hilo_resident_evil_5_1, @id_subforo_resident_evil_5_1,
				@id_usuario_sofia, 1, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/ResidentEvilHilo1.jpg');

CALL CREAR_HILO(@id_hilo_resident_evil_5_2, @id_subforo_resident_evil_5_2,
				@id_usuario_john, 0, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/ResidentEvilHilo2.jpg');

CALL CREAR_HILO(@id_hilo_resident_evil_5_3, @id_subforo_resident_evil_5_3,
				@id_usuario_emily, 0, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/ResidentEvilHilo3.jpg');

-- Hilos en los subforos de Geometry Dash
CALL CREAR_HILO(@id_hilo_geometry_dash_1, @id_subforo_geometry_dash_1,
				@id_usuario_pablo, 0, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/GeometryDashHilo1.jpg');

CALL CREAR_HILO(@id_hilo_geometry_dash_2, @id_subforo_geometry_dash_2,
				@id_usuario_maria, 1, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/GeometryDashHilo2.jpg');

CALL CREAR_HILO(@id_hilo_geometry_dash_3, @id_subforo_geometry_dash_3,
				@id_usuario_luis, 0, DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')),
				'Uploads/GeometryDashHilo3.jpg');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												MENSAJES
-- ---------------------------------------------------------------------------------------------
-- Mensajes en los hilos del subforo de Assassin's Creed Odyssey
CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_1_1,
				   'Aquí tienes una guía completa para completar las misiones principales.',
				   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
				   @id_hilo_ac_odyssey_1, @id_usuario_fabricio);

CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_1_2,
    			   'Gracias por la guía, me ha sido muy útil.',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
				   @id_hilo_ac_odyssey_1, @id_usuario_ana);

CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_2_1,
    			   '¿Alguien más ha tenido problemas con el rendimiento del juego?',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_ac_odyssey_2, @id_usuario_julio);

CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_3_1,
    			   'Estoy experimentando errores gráficos extraños. ¿Alguna solución?',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_ac_odyssey_3, @id_usuario_ana);

-- Mensajes en los hilos del subforo de Resident Evil 5: Gold Edition
CALL CREAR_MENSAJE(@id_mensaje_resident_evil_5_1_1,
    			   'Aquí está mi estrategia para vencer a Wesker en el modo mercenarios.',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_resident_evil_5_1, @id_usuario_sofia);

CALL CREAR_MENSAJE(@id_mensaje_resident_evil_5_2_1,
    			   '¿Cuál es tu mejor tiempo en el modo mercenarios?',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_resident_evil_5_2, @id_usuario_john);

CALL CREAR_MENSAJE(@id_mensaje_resident_evil_5_3_1,
    			   'Mi juego se congela después de la cinemática. ¿Alguna solución?',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_resident_evil_5_3, @id_usuario_emily);

-- Mensajes en los hilos del subforo de Geometry Dash
CALL CREAR_MENSAJE(@id_mensaje_geometry_dash_1_1,
    			   'Aquí comparto mi nuevo nivel creado. ¡Espero que les guste!',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_geometry_dash_1, @id_usuario_pablo);

CALL CREAR_MENSAJE(@id_mensaje_geometry_dash_2_1,
    			   '¿Alguien quiere participar en un desafío de niveles difíciles?',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_geometry_dash_2, @id_usuario_maria);

CALL CREAR_MENSAJE(@id_mensaje_geometry_dash_3_1,
    			   'Necesito ayuda para pasar el nivel "Deadlocked". ¿Algún consejo?',
    			   DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), DATE_ADD(DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Lima')), INTERVAL 7 DAY),
    			   @id_hilo_geometry_dash_3, @id_usuario_luis);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--										  GESTOR DE SANCIONES
-- ---------------------------------------------------------------------------------------------
-- Gestores de Sanciones para los usuarios de Perú
CALL INSERTAR_GESTOR(@id_gestor_fabricio, @id_usuario_fabricio, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_ana, @id_usuario_ana, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_julio, @id_usuario_julio, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de Estados Unidos
CALL INSERTAR_GESTOR(@id_gestor_sofia, @id_usuario_sofia, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_john, @id_usuario_john, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_emily, @id_usuario_emily, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de España
CALL INSERTAR_GESTOR(@id_gestor_pablo, @id_usuario_pablo, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_maria, @id_usuario_maria, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_luis, @id_usuario_luis, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de Alemania
CALL INSERTAR_GESTOR(@id_gestor_hans, @id_usuario_hans, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_anna, @id_usuario_anna, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_fritz, @id_usuario_fritz, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de Francia
CALL INSERTAR_GESTOR(@id_gestor_pierre, @id_usuario_pierre, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_claire, @id_usuario_claire, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_jean, @id_usuario_jean, 0, 0, 0, 3, 3, 0, 0);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--											FORO - USUARIO
-- ---------------------------------------------------------------------------------------------
-- Creadores de los foros

-- Creador del foro de Assassin's Creed Odyssey
CALL CREAR_RELACION_FORO(@id_foro_ac_odyssey, @id_usuario_fabricio);

-- Creador del foro de Resident Evil 5: Gold Edition
CALL CREAR_RELACION_FORO(@id_foro_resident_evil_5, @id_usuario_ana);

-- Creador del foro de Geometry Dash
CALL CREAR_RELACION_FORO(@id_foro_geometry_dash, @id_usuario_julio);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--											PALABRAS PROHIBIDAS
-- ---------------------------------------------------------------------------------------------
-- Inserción de palabras prohibidas en el sistema

INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('maldición'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('grosería'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('insulto'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('despectivo'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('ofensa'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('vulgaridad'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('blasfemia'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('denigrante'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('difamación'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('obscenidad'));
-- -------------------------------------------------------------------------------------------