DROP PROCEDURE IF EXISTS AGREGAR_AMIGO;
DROP PROCEDURE IF EXISTS ELIMINAR_AMIGO;
DROP PROCEDURE IF EXISTS BLOQUEAR_USUARIO;
DROP PROCEDURE IF EXISTS LISTAR_AMIGOS_POR_USUARIO;

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
        INSERT INTO Relacion (fid_usuarioa, fid_usuariob, amistad, bloqueo, activo) 
        VALUES (_fid_usuario_a, _fid_usuario_b, 1, 0, 1);
    END IF;

END $

CREATE PROCEDURE ELIMINAR_AMIGO(
    IN _fid_usuario_a INT,
    IN _fid_usuario_b INT 
)
BEGIN
    UPDATE Relacion 
    SET amistad = 0
    WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) 
       OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a);
END $

CREATE PROCEDURE BLOQUEAR_USUARIO(
    IN _fid_usuario_a INT,
    IN _fid_usuario_b INT 
)
BEGIN
    -- En caso ya exista la relación
    IF EXISTS (SELECT * FROM Relacion WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a)) THEN
        UPDATE Relacion 
        SET amistad = 0, bloqueo = 1, activo = 1
        WHERE (fid_usuarioa = _fid_usuario_a AND fid_usuariob = _fid_usuario_b) OR (fid_usuarioa = _fid_usuario_b AND fid_usuariob = _fid_usuario_a);
    ELSE
        INSERT INTO Relacion (fid_usuarioa, fid_usuariob, amistad, bloqueo, activo) 
        VALUES (_fid_usuario_a, _fid_usuario_b, 0, 1, 1);
    END IF;
END $

CREATE PROCEDURE LISTAR_AMIGOS_POR_USUARIO(
	IN _id_usuario INT
)
BEGIN
	SELECT fid_usuarioa AS "ID Usuario A",
		   fid_usuariob AS "ID Usuario B",
           amistad      AS "Amistad",
           bloqueo      AS "Bloqueo"
    FROM Relacion
    WHERE (fid_usuarioa = _id_usuario OR
		  fid_usuariob = _id_usuario) AND
          amistad = TRUE AND
          activo = TRUE;
END $