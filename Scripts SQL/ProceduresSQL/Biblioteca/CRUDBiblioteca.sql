DROP PROCEDURE IF EXISTS INSERTAR_BIBLIOTECA;
DROP PROCEDURE IF EXISTS BUSCAR_BIBLIOTECA;

DELIMITER $

CREATE PROCEDURE INSERTAR_BIBLIOTECA(
    OUT _id_biblioteca INT,
    IN _fid_usuario INT
)
BEGIN
    -- Insertar nueva biblioteca para el usuario
    INSERT INTO Biblioteca(fid_usuario)
    VALUES (_fid_usuario);
    
    -- Obtener el último ID insertado
    SET _id_biblioteca = @@last_insert_id;
END$

CREATE PROCEDURE BUSCAR_BIBLIOTECA(
    IN _fid_usuario INT
)
BEGIN
    -- Buscar biblioteca por ID de usuario
    SELECT * FROM Biblioteca WHERE fid_usuario = _fid_usuario;
END$

DELIMITER ;
