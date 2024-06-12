
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Sol', 'PEN', 'S/.', 3.73);
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Euro', 'EUR', '€', 0.91);
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Dólar', 'USD', '$', 1);

CALL CREAR_PAIS(@id_pais, 'Peru', 'PER', 1);
CALL CREAR_PAIS(@id_pais, 'Francia', 'FR', 2);
CALL CREAR_PAIS(@id_pais, 'Estados Unidos', 'US', 3);
CALL CREAR_PAIS(@id_pais, 'España', 'ES', 2);

CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Razon Social 1');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Razon Social 2');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Razon Social 3');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'MMOs para todos');
CALL INSERTAR_JUEGO(@id_juego, 1, 'Geometry Dash', '2013-08-13', 20.00, 'Juego de ritmo y figuras', 10.00, 'https://1000logos.net/wp-content/uploads/2022/05/Logo-Geometry-Dash.png', 'https://resources.crowdcontrol.live/images/GeometryDash/banner.jpg', 1, 'Core i5 10th Generation', 'Core i7 12th Generation', 1);
CALL INSERTAR_BANDASONORA(@id_banda_sonora, 1, 'Hollow Knight - Official Soundtrack', '2024-04-20', 0.00, 'Soundtrack Oficial del juego Hollow Knight, captura una vasta parte del mundo subterráneo del juego', 15.00, 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/d0/02/e3/d002e325-299d-f87f-a737-7d7ad3c628ae/840095520225.jpg/1200x1200bf-60.jpg', 'https://cdn.cloudflare.steamstatic.com/steam/apps/598190/header.jpg?t=1581550241', 1, 'Christopher Larkin', 'Christopher Larkin', '01:04:20');
CALL INSERTAR_SOFTWARE(@id_software, 2, 'Wallpaper Engine', '2016-10-10', 20.00, 'Aplicacion para fondos de pantalla en alta calidad y animados', 20.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShoRHLNX2m9GQ-ziMfqlaSkfZH8m5YnhovOAWASmw8Dg&s', 'https://cdn.akamai.steamstatic.com/steam/apps/431960/header.jpg?t=1665921297', 1, 'Core i5 7th Generation', 'GPL');
CALL INSERTAR_JUEGO(@id_juego, @id_proveedor, 'Maplestory', '2012-08-09', 0, 'Únete a la aventura del MMORPG en 2D más grande del mundo.', 1536, 'https://cdn2.steamgriddb.com/grid/5ca15b56b207cea5903395718b794fec.png', 'https://mmos.com/wp-content/uploads/2015/10/pocket-maplestory-banner.jpg', 1, 'Intel Core 2 Duo de 3,0 GHz', 'Intel Core i3 de 4,0 GHz', 1);
CALL INSERTAR_JUEGO(@id_juego, @id_proveedor, 'Guild Wars 2', '2022-08-23', 0, 'Juego de rol online con combates de acción trepidante y con una profunda personalización de personajes', 7168, 'https://www.pngitem.com/pimgs/m/195-1956338_guild-wars-2-logo-png-transparent-png.png', 'https://i.imgur.com/BFkJ9BI.jpeg', 1, 'Intel Core i3 3.4 GHz', 'Intel Core i5', 1);
CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 1", "Lograste pasar el nivel 1", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 2", "Lograste pasar el nivel 2", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 3", "Lograste pasar el nivel 3", 1, 1);
call INSERTAR_ETIQUETA(@id_etiqueta,'Terror');
call INSERTAR_ETIQUETA(@id_etiqueta,'Puzzle');
call INSERTAR_ETIQUETA(@id_etiqueta,'RPG');
call INSERTAR_ETIQUETA(@id_etiqueta,'Casual');
call INSERTAR_ETIQUETA(@id_etiqueta,'Accion');
call INSERTAR_PRODUCTOETIQUETA(1, 2);
call INSERTAR_PRODUCTOETIQUETA(1, 5);
call INSERTAR_PRODUCTOETIQUETA(3, 2);
call INSERTAR_PRODUCTOETIQUETA(3, 5);
call INSERTAR_PRODUCTOETIQUETA(4, 3);
call INSERTAR_PRODUCTOETIQUETA(4, 4);
call INSERTAR_PRODUCTOETIQUETA(5, 3);
call INSERTAR_PRODUCTOETIQUETA(5, 5);

CALL CREAR_USUARIO(@id_usuario, 'cuenta_sofia', 'Sofia', 'a20210750@pucp.edu.pe', '123456789', 'password_sofia', 19, '2004-07-01', 1, 4, 2, 5, 1);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca, @id_usuario);
call INSERTAR_CARTERA(@id_cartera, @id_usuario, 0, 0);
call INSERTAR_PERFIL(@id_perfil, @id_usuario, "Images/foto_perfil.png");
CALL INSERTAR_GESTOR(@id_gestor, @id_usuario, 0, 0, 0, 3, 3, 0, 0);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,1);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,2);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,3);
call INSERTAR_COLECCION(@_id_coleccion, 'Favoritos', @id_biblioteca);
call INSERTAR_COLECCION(@_id_coleccion, 'Frecuentes', @id_biblioteca);
CALL CREAR_NOTIFICACION(@id_notificacion, "BIBLIOTECA", "Se ha agregado un nuevo producto: Hollow Knight a tu Biblioteca", @id_usuario);
CALL CREAR_NOTIFICACION(@id_notificacion, "AMIGOS", "Ahora eres amigo de Juan", @id_usuario);
CALL CREAR_NOTIFICACION(@id_notificacion, "FOROS", "Hay un nuevo mensaje en el foro A", @id_usuario);
CALL CREAR_NOTIFICACION(@id_notificacion, "JUEGOS", "Has conseguido un nuevo logro en Geometry Dash", @id_usuario);


CALL CREAR_USUARIO(@id_usuario, 'cuenta_fabricio', 'Fabricio', 'a20214115@pucp.edu.pe', '987654321', 'password_fabricio', 20, '2003-12-06', 1, 1, 3, 4, 2);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca, @id_usuario);
call INSERTAR_CARTERA(@id_cartera, @id_usuario, 0, 0);
call INSERTAR_PERFIL(@id_perfil, @id_usuario, "Images/foto_perfil.png");
CALL INSERTAR_GESTOR(@id_gestor, @id_usuario, 0, 0, 0, 3, 3, 0, 0);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,1);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,2);

UPDATE ProductoAdquirido SET fecha_ejecucion='2024-05-29', tiempo_uso='01:20:23' where id_producto_adquirido=1;
UPDATE ProductoAdquirido SET fecha_ejecucion='2024-05-29', tiempo_uso='00:18:38' where id_producto_adquirido=3;
