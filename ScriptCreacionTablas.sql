/* DROPS */
DROP TABLE IF EXISTS Pais;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Notificacion;
DROP TABLE IF EXISTS Cartera;
DROP TABLE IF EXISTS Movimiento;
DROP TABLE IF EXISTS Medalla;
DROP TABLE IF EXISTS Perfil;
DROP TABLE IF EXISTS Expositor;
DROP TABLE IF EXISTS Comentario;
DROP TABLE IF EXISTS Foro;
DROP TABLE IF EXISTS Subforo;
DROP TABLE IF EXISTS Hilo;
DROP TABLE IF EXISTS Mensaje;
DROP TABLE IF EXISTS GestorSanciones;
DROP TABLE IF EXISTS Biblioteca;
DROP TABLE IF EXISTS Coleccion;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Etiqueta;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS ProductoAdquirido;
DROP TABLE IF EXISTS Juego;
DROP TABLE IF EXISTS Software;
DROP TABLE IF EXISTS BandaSonora;
DROP TABLE IF EXISTS Logro;
DROP TABLE IF EXISTS LogroDesbloqueado;
DROP TABLE IF EXISTS Inventario;
DROP TABLE IF EXISTS InventarioActivo;
DROP TABLE IF EXISTS Objeto;
DROP TABLE IF EXISTS Cromo;
DROP TABLE IF EXISTS ObjetoUsable;
DROP TABLE IF EXISTS ObjetoObtenido;

/* CREACION DE TABLAS */
/* PAQUETE USUARIO */
CREATE TABLE Pais(
	id_pais INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    moneda VARCHAR(3),
    PRIMARY KEY(id_pais)
)ENGINE=InnoDB;

CREATE TABLE Usuario(
	UID INT,
    nombre_cuenta VARCHAR(100),
    nombre_perfil VARCHAR(100),
    correo VARCHAR(100),
    telefono VARCHAR(15),
    contrasenia VARCHAR(100),
    edad INT,
    fecha_nacimiento DATE,
    verificado TINYINT,
    experiencia_nivel INT,
    nivel INT,
    experiencia INT,
    fid_pais INT,
    PRIMARY KEY(UID),
    FOREIGN KEY(fid_pais) REFERENCES Pais(id_pais)
)ENGINE=InnoDB;

CREATE TABLE Notificacion(
	id_notificacion INT AUTO_INCREMENT,
    tipo VARCHAR(30),
    mensaje VARCHAR(200),
    fid_usuario INT,
    PRIMARY KEY(id_notificacion),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

/* PAQUETE JUGADOR */
CREATE TABLE Cartera(
	id_cartera INT,
    fondos DECIMAL(10,2),
    cantidad_movimientos INT,
    FOREIGN KEY(id_cartera) REFERENCES Usuario(UID),
    PRIMARY KEY(id_cartera)
)ENGINE=InnoDB;

CREATE TABLE Movimiento(
	id_movimiento INT AUTO_INCREMENT,
    id_transaccion VARCHAR(100),
    fecha_transaccion DATE,
    monto DECIMAL(10,2),
    tipo VARCHAR(100),
    metodo_pago VARCHAR(100),
    fid_cartera INT,
    PRIMARY KEY(id_movimiento),
    FOREIGN KEY(fid_cartera) REFERENCES Cartera(id_cartera)
)ENGINE=InnoDB;

CREATE TABLE Medalla(
	id_medalla INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    experiencia INT,
    PRIMARY KEY(id_medalla)
)ENGINE=InnoDB;

/* Crear tabla Medalla_Jugador */

/* PAQUETE PERFIL */
CREATE TABLE Perfil(
	id_perfil INT,
    PRIMARY KEY(id_perfil),
    FOREIGN KEY(id_perfil) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Expositor(
	id_expositor INT AUTO_INCREMENT,
    fid_perfil INT,
    PRIMARY KEY(id_expositor),
    FOREIGN KEY(fid_perfil) REFERENCES Perfil(id_perfil)
)ENGINE=InnoDB;

CREATE TABLE Comentario(
	id_comentario INT AUTO_INCREMENT,
    texto VARCHAR(100),
    nro_likes INT,
    fid_perfil_comentarista INT,
    fid_usuario INT,
    PRIMARY KEY(id_comentario),
    FOREIGN KEY(fid_perfil_comentarista) REFERENCES Perfil(id_perfil),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

/*PAQUETE COMUNIDAD*/
CREATE TABLE Foro(
	id_foro INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion VARCHAR(200),
    origen_foro VARCHAR(100),
    PRIMARY KEY(id_foro)
)ENGINE=InnoDB;

/* Crear tabla Foro_Usuario */

CREATE TABLE Subforo(
	id_subforo INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    fid_foro int,
    PRIMARY KEY(id_subforo),
    FOREIGN KEY(fid_foro) REFERENCES Foro(id_foro)
)ENGINE=InnoDB;

CREATE TABLE Hilo(
	id_hilo INT AUTO_INCREMENT,
    fijado TINYINT,
    nro_mensajes INT,
    fecha_creacion DATE,
    fecha_modificacion DATE,
    fid_subforo INT,
    PRIMARY KEY(id_hilo),
    FOREIGN KEY(fid_subforo) REFERENCES Subforo(id_subforo)
)ENGINE=InnoDB;

CREATE TABLE Mensaje(
	id_mensaje INT AUTO_INCREMENT,
    contenido VARCHAR(300),
    fecha_publicacion DATE,
    fid_hilo INT,
    fid_usuario INT,
    PRIMARY KEY(id_mensaje),
    FOREIGN KEY(fid_hilo) REFERENCES Hilo(id_hilo),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

/* Crear tabla Subforo_Sanciones? */

CREATE TABLE GestorSanciones(
	id_gestor INT AUTO_INCREMENT,
    contador_faltas INT,
    contador_baneos INT,
    max_faltas INT,
    max_baneos INT,
    fid_usuario INT,
    PRIMARY KEY(id_gestor),
    FOREIGN KEY(fid_usuario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

/*PAQUETE BIBLIOTECA*/
CREATE TABLE Biblioteca(
	id_biblioteca INT,
    PRIMARY KEY(id_biblioteca),
    FOREIGN KEY(id_biblioteca) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE Coleccion(
	id_coleccion INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    fid_biblioteca INT,
    PRIMARY KEY(id_coleccion),
    FOREIGN KEY(fid_biblioteca) REFERENCES Biblioteca(id_biblioteca)
)ENGINE=InnoDB;

/*PAQUETE PRODUCTO*/
CREATE TABLE Proveedor(
	id_proveedor INT AUTO_INCREMENT,
    razon_social VARCHAR(100),
    PRIMARY KEY(id_proveedor)
)ENGINE=InnoDB;

CREATE TABLE Etiqueta(
	id_etiqueta INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    PRIMARY KEY(id_etiqueta)
)ENGINE=InnoDB;

CREATE TABLE Producto(
	id_producto INT AUTO_INCREMENT,
    titulo VARCHAR(100),
    fecha_publicacion DATE,
    precio DECIMAL(5,2),
    descripcion VARCHAR(100),
    espacio_disco DECIMAL(5,2),
    fid_proveedor INT,
    PRIMARY KEY(id_producto),
    FOREIGN KEY(fid_proveedor) REFERENCES Proveedor(id_proveedor)
)ENGINE=InnoDB;

CREATE TABLE ProductoAdquirido(
	id_producto_adquirido INT AUTO_INCREMENT,
    fecha_adquisicion DATE,
    fecha_ejecucion DATE,
    tiempo_uso TIME,
    actualizado TINYINT,
    fid_biblioteca INT,
    fid_producto INT,
    /*fid_coleccion INT NULL,*/
    PRIMARY KEY(id_producto_adquirido),
    FOREIGN KEY(fid_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY(fid_biblioteca) REFERENCES Biblioteca(id_biblioteca)
    /*FOREIGN KEY(fid_coleccion) REFERENCES Producto(id_coleccion)*/
)ENGINE=InnoDB;

/* Crear tabla ProductoAdquirido_Coleccion */

CREATE TABLE Juego(
	id_juego INT AUTO_INCREMENT,
    requisitos_minimos VARCHAR(200),
    requisitos_recomendados VARCHAR(200),
    multijugador TINYINT,
    PRIMARY KEY(id_juego),
    FOREIGN KEY(id_juego) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE Software(
	id_software INT,
    requisitos VARCHAR(200),
    licencia VARCHAR(40),
    PRIMARY KEY(id_software),
    FOREIGN KEY(id_software) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE BandaSonora(
	id_banda_sonora INT,
    artista VARCHAR(100),
    compositor VARCHAR(100),
    duracion TIME,
    PRIMARY KEY(id_banda_sonora),
    FOREIGN KEY(id_banda_sonora) REFERENCES Producto(id_producto)
)ENGINE=InnoDB;

CREATE TABLE Logro(
	id_logro INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion VARCHAR(200),
    fid_juego INT,
    PRIMARY KEY(id_logro),
    FOREIGN KEY(fid_juego) REFERENCES Juego(id_juego)
)ENGINE=InnoDB;

CREATE TABLE LogroDesbloqueado(
	id_logro_desbloqueado INT AUTO_INCREMENT,
    fecha_desbloqueo TIME,
	fid_logro INT,
    PRIMARY KEY(id_logro_desbloqueado),
	FOREIGN KEY(fid_logro) REFERENCES Logro(id_logro)
)ENGINE=InnoDB;

/*PAQUETE INVENTARIO*/
CREATE TABLE Inventario(
	id_inventario INT,
    cantidad_gemas INT,
    PRIMARY KEY(id_inventario),
    FOREIGN KEY(id_inventario) REFERENCES Usuario(UID)
)ENGINE=InnoDB;

CREATE TABLE InventarioActivo(
	id_activo INT,
    nro_objetos INT,
	fid_inventario INT,
    PRIMARY KEY(id_activo),
	FOREIGN KEY(fid_inventario) REFERENCES Inventario(id_inventario)
)ENGINE=InnoDB;

CREATE TABLE Objeto(
	id_objeto INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    PRIMARY KEY(id_objeto)
)ENGINE=InnoDB;

CREATE TABLE Cromo(
	id_cromo INT,
    url VARCHAR(100),
    PRIMARY KEY(id_cromo),
    FOREIGN KEY(id_cromo) REFERENCES Objeto(id_objeto)
)ENGINE=InnoDB;

CREATE TABLE ObjetoUsable(
	id_objeto_usable INT,
    tipo VARCHAR(100),
    PRIMARY KEY(id_objeto_usable),
    FOREIGN KEY(id_objeto_usable) REFERENCES Objeto(id_objeto)
)ENGINE=InnoDB;

CREATE TABLE ObjetoObtenido(
	id_objeto_obtenido INT,
    fecha_obtencion TIME,
	fid_activo INT,
    PRIMARY KEY(id_objeto_obtenido),
	FOREIGN KEY(fid_activo) REFERENCES InventarioActivo(id_activo)
)ENGINE=InnoDB;