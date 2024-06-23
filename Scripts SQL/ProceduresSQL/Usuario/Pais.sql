DROP PROCEDURE IF EXISTS CREAR_PAIS;
DROP PROCEDURE IF EXISTS BUSCAR_PAIS;
DROP PROCEDURE IF EXISTS LISTAR_PAISES;
DROP PROCEDURE IF EXISTS ACTUALIZAR_PAIS;

DELIMITER $

CREATE PROCEDURE CREAR_PAIS(
    OUT _ID_PAIS INT,
    IN _NOMBRE VARCHAR(100),
    IN _CODIGO CHAR(3),
    IN _FID_MONEDA INT
)
BEGIN
    INSERT INTO Pais (NOMBRE, CODIGO, ACTIVO, FID_MONEDA)
    VALUES (_NOMBRE, _CODIGO, 1, _FID_MONEDA);
    SET _ID_PAIS = @@last_insert_id;
END$

CREATE PROCEDURE BUSCAR_PAIS(
    IN _ID_PAIS INT
)
BEGIN
    SELECT p.id_pais, p.nombre AS nombre_pais, p.codigo AS codigo_pais,
           m.id_tipo_moneda, m.nombre AS nombre_moneda, m.codigo AS codigo_moneda,
           m.simbolo, m.cambio_de_dolares, m.fecha_cambio, m.activo AS moneda_activa
    FROM Pais p
    INNER JOIN TipoMoneda m ON m.id_tipo_moneda = p.fid_moneda
    WHERE p.activo = 1 AND p.id_pais = _ID_PAIS;
END$

CREATE PROCEDURE LISTAR_PAISES()
BEGIN
    SELECT p.id_pais, p.nombre AS nombre_pais, p.codigo AS codigo_pais,
           m.id_tipo_moneda, m.nombre AS nombre_moneda, m.codigo AS codigo_moneda,
           m.simbolo, m.cambio_de_dolares, m.fecha_cambio, m.activo AS moneda_activa
    FROM Pais p
    INNER JOIN TipoMoneda m ON m.id_tipo_moneda = p.fid_moneda
    WHERE p.activo = 1;
END$

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
END$

DELIMITER ;