
DROP PROCEDURE IF EXISTS INSERTAR_PROVEEDOR;
DELIMITER $
CREATE PROCEDURE INSERTAR_PROVEEDOR(
	IN _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
	INSERT INTO Proveedor(id_proveedor, razon_social)
    VALUES (_id_proveedor, _razon_social);
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
	IN _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
	#DELETE FROM Proveedor WHERE id_proveedor = _id_proveedor;
    UPDATE Producto
    SET oculto = true
    WHERE fid_proveedor = _id_proveedor;
END;
