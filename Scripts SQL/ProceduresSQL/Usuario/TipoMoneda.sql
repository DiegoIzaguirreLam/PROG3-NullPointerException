DROP PROCEDURE IF EXISTS INSERTAR_TIPOMONEDA;
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

