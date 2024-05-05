DROP PROCEDURE IF EXISTS CREAR_PAIS;
DELIMITER $
CREATE PROCEDURE CREAR_PAIS(
	OUT _ID_PAIS INT,
    IN _NOMBRE VARCHAR(100),
    IN _CODIGO VARCHAR(100),
    IN _FID_MONEDA INT
)
BEGIN
	INSERT INTO Pais(NOMBRE, CODIGO, ACTIVO, FID_MONEDA)
    VALUES (_NOMBRE, _CODIGO, 1, _FID_MONEDA);
    SET _ID_PAIS = @@last_insert_id;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS BUSCAR_PAIS;
DELIMITER $
CREATE PROCEDURE BUSCAR_PAIS(
	IN _ID_PAIS INT
)
BEGIN
	SELECT * FROM Pais WHERE ID_PAIS = _ID_PAIS;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PAISES;
DELIMITER $
CREATE PROCEDURE LISTAR_PAISES()
BEGIN
	SELECT p.id_pais, p.nombre as nombre_pais, p.codigo as codigo_pais, m.id_tipo_moneda, 
    m.nombre as nombre_moneda, m.codigo as codigo_moneda, m.cambio_de_dolares, m.fecha_cambio, m.activo as moneda_activa
    FROM Pais p
    INNER JOIN TipoMoneda m ON m.id_tipo_moneda = p.fid_moneda
    WHERE p.activo = 1;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS ACTUALIZAR_PAIS;
DELIMITER $
CREATE PROCEDURE ACTUALIZAR_PAIS(
	IN _id_pais INT,
    IN _nombre VARCHAR(100),
    IN _codigo VARCHAR(3),
    IN _fid_moneda INT
)
BEGIN
	UPDATE Pais
    SET nombre = _nombre,
		codigo = _codigo,
        fid_moneda = _fid_moneda
    WHERE id_pais = _id_pais;
END $
DELIMITER ;