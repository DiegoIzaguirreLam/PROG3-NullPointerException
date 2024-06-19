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