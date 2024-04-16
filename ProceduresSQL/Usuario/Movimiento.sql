DROP PROCEDURE IF EXISTS CREAR_MOVIMIENTO;
DELIMITER $
CREATE PROCEDURE CREAR_MOVIMIENTO(
	OUT _ID_MOVIMIENTO INT,
    IN _ID_TRANSACCION VARCHAR(100),
    IN _FECHA_TRANSACCION DATE,
    IN _MONTO_PAGO DECIMAL(10, 2),
    IN _TIPO VARCHAR(100),
    IN _METODO_PAGO VARCHAR(100),
    IN _FID_CARTERA INT
)
BEGIN
	INSERT INTO MOVIMIENTO(ID_TRANSACCION, FECHA_TRANSACCION, MONTO_PAGO, TIPO, METODO_PAGO, FID_CARTERA)
	VALUES (_ID_TRANSACCION, _FECHA_TRANSACCION, _MONTO_PAGO, _TIPO, _METODO_PAGO, _FID_CARTERA);
	SET _ID_MOVIMIENTO = @@last_insert_id;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_MOVIMIENTOS;
DELIMITER $
CREATE PROCEDURE LISTAR_MOVIMIENTOS(
	IN _FID_CARTERA INT
)
BEGIN
	SELECT * FROM MOVIMIENTO WHERE FID_CARTERA = _FID_CARTERA;
END $
DELIMITER ;
DROP PROCEDURE IF EXISTS BUSCAR_MOVIMIENTO;
DELIMITER $
CREATE PROCEDURE BUSCAR_MOVIMIENTO(
	IN _ID_MOVIMIENTO INT
)
BEGIN
	SELECT * FROM MOVIMIENTO WHERE ID_MOVIMIENTO = _ID_MOVIMIENTO;
END $
DELIMITER ;