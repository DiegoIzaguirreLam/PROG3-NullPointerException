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