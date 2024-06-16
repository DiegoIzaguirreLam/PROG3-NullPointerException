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