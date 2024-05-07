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
DROP TABLE IF EXISTS Expositor;
DROP TABLE IF EXISTS Comentario;
DROP TABLE IF EXISTS Perfil;
DROP TABLE IF EXISTS Medalla;
DROP TABLE IF EXISTS Movimiento;
DROP TABLE IF EXISTS Cartera;
DROP TABLE IF EXISTS Notificacion;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Pais;
DROP TABLE IF EXISTS TipoMoneda;

/* CREACION DE TABLAS */
/* PAQUETE USUARIO */
CREATE TABLE TipoMoneda(
	id_tipo_moneda INT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	codigo VARCHAR(3) NOT NULL,
	cambio_de_dolares DECIMAL(10,2) NOT NULL,
	fecha_cambio DATE NOT NULL,
	activo TINYINT NOT NULL,
	PRIMARY KEY(id_tipo_moneda)
)ENGINE=InnoDB;

CREATE TABLE Pais(
	id_pais INT AUTO_INCREMENT,
	fid_moneda INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    codigo VARCHAR(3) NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_pais),
	FOREIGN KEY(fid_moneda) REFERENCES TipoMoneda(id_tipo_moneda)
)ENGINE=InnoDB;

CREATE TABLE Usuario(
	UID INT AUTO_INCREMENT NOT NULL,
    nombre_cuenta VARCHAR(100) NOT NULL,
    nombre_perfil VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    contrasenia VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    verificado TINYINT NOT NULL,
    experiencia_nivel INT NOT NULL,
    nivel INT NOT NULL,
    experiencia INT NOT NULL,
    fid_pais INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(UID),
    FOREIGN KEY(fid_pais) REFERENCES Pais(id_pais)
)ENGINE=InnoDB;

CREATE TABLE Relacion(
	fid_usuarioa INT NOT NULL,
	fid_usuariob INT NOT NULL,
	amistad TINYINT NOT NULL,
	bloqueo TINYINT NOT NULL,
	activo TINYINT NOT NULL,
	PRIMARY KEY(fid_usuarioa, fid_usuariob),
	FOREIGN KEY(fid_usuarioa) REFERENCES Usuario(UID),
	FOREIGN KEY(fid_usuariob) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Notificacion(
	id_notificacion INT AUTO_INCREMENT,
    tipo VARCHAR(30) NOT NULL,
    mensaje VARCHAR(200) NOT NULL,
    fid_usuario INT NOT NULL,
	revisada BOOLEAN NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_notificacion),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

/* PAQUETE JUGADOR */
CREATE TABLE Cartera(
	id_cartera INT,
    fondos DECIMAL(10,2) NOT NULL,
    cantidad_movimientos INT NOT NULL,
	activo TINYINT NOT NULL,
    FOREIGN KEY(id_cartera) REFERENCES Usuario(UID),
    PRIMARY KEY(id_cartera)
)ENGINE=InnoDB;

CREATE TABLE Movimiento(
	id_movimiento INT AUTO_INCREMENT,
    id_transaccion VARCHAR(100) NOT NULL,
    fecha_transaccion DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    metodo_pago VARCHAR(100) NOT NULL,
	activo TINYINT NOT NULL,
    fid_cartera INT NOT NULL,
    PRIMARY KEY(id_movimiento),
    FOREIGN KEY(fid_cartera) REFERENCES Cartera(id_cartera)
)ENGINE=InnoDB;

CREATE TABLE Medalla(
	id_medalla INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    experiencia INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_medalla)
)ENGINE=InnoDB;

/* Crear tabla Medalla_Jugador */
CREATE TABLE MedallaUsuario(
	fid_usuario INT,
	fid_medalla INT,
	activo TINYINT NOT NULL,
	PRIMARY KEY(fid_usuario, fid_medalla),
	FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID),
	FOREIGN KEY(fid_medalla) REFERENCES Medalla(id_medalla)
)ENGINE=InnoDB;


/* PAQUETE PERFIL */
CREATE TABLE Perfil(
	id_perfil INT,
	usuario_id INT UNIQUE,
    foto_url VARCHAR(200),
    oculto TINYINT NOT NULL,
    PRIMARY KEY(id_perfil),
    FOREIGN KEY(usuario_id) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Expositor(
	id_expositor INT AUTO_INCREMENT,
    fid_perfil INT NOT NULL,
    oculto TINYINT NOT NULL,
    activo TINYINT NOT NULL,
    PRIMARY KEY(id_expositor),
    FOREIGN KEY(fid_perfil) REFERENCES Perfil(id_perfil)
)ENGINE=InnoDB;

CREATE TABLE Comentario(
	id_comentario INT AUTO_INCREMENT,
    texto VARCHAR(100) NOT NULL,
    nro_likes INT NOT NULL,
    oculto TINYINT NOT NULL,
    fecha_publicacion DATE NOT NULL,
    fecha_maxedicion DATE,
    fid_perfil_comentado INT NOT NULL,
    fid_usuario_comentarista INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_comentario),
    FOREIGN KEY(fid_perfil_comentado) REFERENCES Perfil(id_perfil),
    FOREIGN KEY(fid_usuario_comentarista) REFERENCES Usuario(UID)
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
	fid_foro INT NOT NULL,
	fid_usuario INT NOT NULL,
	PRIMARY KEY(fid_foro, fid_usuario),
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
	id_gestor INT,
	id_usuario INT UNIQUE,
    fin_ban DATE NOT NULL,
    cant_faltas INT NOT NULL,
    cant_baneos INT NOT NULL,
    contador_faltas INT NOT NULL,
    contador_palabras INT NOT NULL,
    contador_baneos INT NOT NULL,
    max_faltas INT NOT NULL,
    max_baneos INT NOT NULL,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_gestor),
    FOREIGN KEY(id_usuario) REFERENCES Usuario(UID)
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
    descripcion VARCHAR(100) NOT NULL,
    espacio_disco DECIMAL(5,2) NOT NULL,
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
    fid_expositor INT,
    fid_movimiento INT,
	activo TINYINT NOT NULL,
    PRIMARY KEY(id_producto_adquirido),
    FOREIGN KEY(fid_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY(fid_biblioteca) REFERENCES Biblioteca(id_biblioteca),
    FOREIGN KEY(fid_expositor) REFERENCES Expositor(id_expositor),
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
	id_producto INT UNIQUE,
    requisitos_minimos VARCHAR(200),
    requisitos_recomendados VARCHAR(200),
    multijugador TINYINT NOT NULL,
    PRIMARY KEY(id_juego),
    FOREIGN KEY(id_producto) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE Software(
	id_software INT,
	id_producto INT UNIQUE,
    requisitos VARCHAR(200),
    licencia VARCHAR(40) NOT NULL,
    PRIMARY KEY(id_software),
    FOREIGN KEY(id_producto) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE BandaSonora(
	id_banda_sonora INT,
	id_producto INT UNIQUE,
    artista VARCHAR(100) NOT NULL,
    compositor VARCHAR(100) NOT NULL,
    duracion TIME NOT NULL,
    PRIMARY KEY(id_banda_sonora),
    FOREIGN KEY(id_producto) REFERENCES Producto(id_producto)
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

