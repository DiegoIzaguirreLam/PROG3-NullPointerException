
DROP PROCEDURE IF EXISTS INSERTAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE INSERTAR_PROVEEDOR(
	OUT _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
	INSERT INTO Proveedor(razon_social)
    VALUES (_razon_social);
    SET _id_proveedor = @@last_insert_id;
END;

DROP PROCEDURE IF EXISTS LISTAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE LISTAR_PROVEEDOR()
BEGIN
	SELECT * FROM Proveedor;
END;

DROP PROCEDURE IF EXISTS ACTUALIZAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PROVEEDOR(
	IN _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
	UPDATE Proveedor
    SET razon_social = _razon_social
    WHERE id_proveedor = _id_proveedor;
END;

DROP PROCEDURE IF EXISTS ELIMINAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE ELIMINAR_PROVEEDOR(
	IN _id_proveedor INT
)
BEGIN
	#DELETE FROM Proveedor WHERE id_proveedor = _id_proveedor;
    UPDATE Producto
    SET oculto = true
    WHERE fid_proveedor = _id_proveedor;
END;
