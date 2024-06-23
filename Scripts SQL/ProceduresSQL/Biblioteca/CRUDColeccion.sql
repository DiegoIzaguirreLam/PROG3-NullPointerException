DROP PROCEDURE IF EXISTS INSERTAR_COLECCION;
DROP PROCEDURE IF EXISTS ACTUALIZAR_COLECCION;
DROP PROCEDURE IF EXISTS ELIMINAR_COLECCION;
DROP PROCEDURE IF EXISTS LISTAR_COLECCIONES;

DELIMITER $

CREATE PROCEDURE INSERTAR_COLECCION(
    OUT _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
    INSERT INTO Coleccion(nombre, fid_biblioteca, activo)
    VALUES (_nombre, _fid_biblioteca, 1);
    SET _id_coleccion = LAST_INSERT_ID();
END$

CREATE PROCEDURE ACTUALIZAR_COLECCION(
    IN _id_coleccion INT,
    IN _nombre VARCHAR(100),
    IN _fid_biblioteca INT
)
BEGIN
    UPDATE Coleccion
    SET nombre = _nombre,
        fid_biblioteca = _fid_biblioteca
    WHERE id_coleccion = _id_coleccion;
END$

CREATE PROCEDURE ELIMINAR_COLECCION(
    IN _id_coleccion INT
)
BEGIN
    UPDATE Coleccion
    SET activo = false 
    WHERE id_coleccion = _id_coleccion;
END$

CREATE PROCEDURE LISTAR_COLECCIONES(
    IN _fid_biblioteca INT
)
BEGIN
    SELECT * FROM Coleccion 
    WHERE fid_biblioteca = _fid_biblioteca AND activo = 1;
END$

DELIMITER ;
