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

