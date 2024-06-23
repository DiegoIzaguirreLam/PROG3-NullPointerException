DROP PROCEDURE IF EXISTS INSERTAR_PROVEEDOR;
DROP PROCEDURE IF EXISTS LISTAR_PROVEEDORES;
DROP PROCEDURE IF EXISTS ACTUALIZAR_PROVEEDOR;
DROP PROCEDURE IF EXISTS ELIMINAR_PROVEEDOR;

DELIMITER $

CREATE PROCEDURE INSERTAR_PROVEEDOR(
    OUT _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
    INSERT INTO Proveedor(razon_social, activo)
    VALUES (_razon_social, 1);
    SET _id_proveedor = LAST_INSERT_ID();
END$

CREATE PROCEDURE LISTAR_PROVEEDORES()
BEGIN
    SELECT * FROM Proveedor WHERE activo = 1;
END$

CREATE PROCEDURE ACTUALIZAR_PROVEEDOR(
    IN _id_proveedor INT,
    IN _razon_social VARCHAR(100)
)
BEGIN
    UPDATE Proveedor
    SET razon_social = _razon_social
    WHERE id_proveedor = _id_proveedor;
END$

CREATE PROCEDURE ELIMINAR_PROVEEDOR(
    IN _id_proveedor INT
)
BEGIN
    UPDATE Proveedor
    SET activo = 0
    WHERE id_proveedor = _id_proveedor;
    
    UPDATE Producto
    SET oculto = true
    WHERE fid_proveedor = _id_proveedor;
END$

DELIMITER ;