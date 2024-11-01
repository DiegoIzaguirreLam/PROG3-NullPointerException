DROP PROCEDURE IF EXISTS INSERTAR_CARTERA;
DROP PROCEDURE IF EXISTS ACTUALIZAR_CARTERA;
DROP PROCEDURE IF EXISTS BUSCAR_CARTERA;

DELIMITER $

CREATE PROCEDURE INSERTAR_CARTERA(
    OUT _ID_CARTERA INT,
    IN _FID_USUARIO INT,
    IN _FONDOS DECIMAL(10, 2),
    IN _CANT_MOVIMIENTOS INT
)
BEGIN
    INSERT INTO Cartera (FID_USUARIO, FONDOS, cantidad_movimientos, ACTIVO)
    VALUES (_FID_USUARIO, _FONDOS, _CANT_MOVIMIENTOS, true);
    SET _ID_CARTERA = @@last_insert_id;
END$

CREATE PROCEDURE ACTUALIZAR_CARTERA(
    IN _ID_CARTERA INT,
    IN _FONDOS DECIMAL(10, 2),
    IN _CANT_MOVIMIENTOS INT
)
BEGIN
    UPDATE Cartera
    SET FONDOS = _FONDOS, cantidad_movimientos = _CANT_MOVIMIENTOS
    WHERE ID_CARTERA = _ID_CARTERA;
END$

CREATE PROCEDURE BUSCAR_CARTERA(
    IN _fid_usuario INT
)
BEGIN
    SELECT * FROM Cartera WHERE FID_USUARIO = _fid_usuario;
END$

DELIMITER ;