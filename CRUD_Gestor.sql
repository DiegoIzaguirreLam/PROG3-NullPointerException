DROP PROCEDURE IF EXISTS CREAR_GESTOR;
DELIMITER $ 
CREATE PROCEDURE CREAR_GESTOR(
	OUT _id_gestor INT ,
    IN _id_usuario INT,
    IN _contador_faltas INT,
    IN _contador_baneos INT,
    IN _max_faltas INT,
    IN _max_baneos INT
)
BEGIN
	INSERT INTO hilo(id_gestor,contador_faltas,
    contador_baneos,
    max_faltas,max_baneos)
    VALUES (_id_usuario,_contador_faltas,
    _contador_baneos,
    _max_faltas,_max_baneos);
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
    IN _max_faltas INT,
    IN _max_baneos INT
)
BEGIN
	UPDATE gestorsanciones SET
    contador_faltas = _contador_faltas,
    contador_baneos = _contador_baneos,
    max_faltas = _max_faltas,
    max_baneos = _max_baneos 
    WHERE id_gestor = _id_gestor; 
END $



/*Pruebas*/


