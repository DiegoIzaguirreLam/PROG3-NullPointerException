
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Sol', 'PEN', 'S/.', 3.73);
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Euro', 'EUR', '€', 0.91);
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda, 'Dólar', 'USD', '$', 1);

CALL CREAR_PAIS(@id_pais, 'Peru', 'PER', 1);
CALL CREAR_PAIS(@id_pais, 'Francia', 'FR', 2);
CALL CREAR_PAIS(@id_pais, 'Estados Unidos', 'US', 3);
CALL CREAR_PAIS(@id_pais, 'España', 'ES', 2);

CALL INSERTAR_PROVEEDOR(@id_proveedor, 'RoboTopo Games');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Team Blueberry');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Kristjan Skutta');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'MMOs para todos');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Beths Game Studios');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'THS');
CALL INSERTAR_PROVEEDOR(@id_proveedor, 'Igora Studios');
CALL INSERTAR_PROVEEDOR(@id_proveedor, '2D Guy');

CALL INSERTAR_JUEGO(@id_juego, 1, 'Geometry Dash', '2013-08-13', 5, 'Juego de ritmo y figuras', 10.00, 'https://1000logos.net/wp-content/uploads/2022/05/Logo-Geometry-Dash.png', 'https://resources.crowdcontrol.live/images/GeometryDash/banner.jpg', 1, 'Core i5 10th Generation', 'Core i7 12th Generation', 1);
CALL INSERTAR_BANDASONORA(@id_banda_sonora, 2, 'Hollow Knight - Official Soundtrack', '2024-04-20', 0.00, 'Soundtrack Oficial del juego Hollow Knight, captura una vasta parte del mundo subterráneo del juego', 15.00, 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/d0/02/e3/d002e325-299d-f87f-a737-7d7ad3c628ae/840095520225.jpg/1200x1200bf-60.jpg', 'https://cdn.cloudflare.steamstatic.com/steam/apps/598190/header.jpg?t=1581550241', 1, 'Christopher Larkin', 'Christopher Larkin', '01:04:20');
CALL INSERTAR_SOFTWARE(@id_software, 3, 'Wallpaper Engine', '2016-10-10', 4, 'Aplicacion para fondos de pantalla en alta calidad y animados', 20.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShoRHLNX2m9GQ-ziMfqlaSkfZH8m5YnhovOAWASmw8Dg&s', 'https://cdn.akamai.steamstatic.com/steam/apps/431960/header.jpg?t=1665921297', 1, 'Core i5 7th Generation', 'GPL');
CALL INSERTAR_JUEGO(@id_juego, 4, 'Maplestory', '2012-08-09', 0, 'Únete a la aventura del MMORPG en 2D más grande del mundo.', 1536, 'https://cdn2.steamgriddb.com/grid/5ca15b56b207cea5903395718b794fec.png', 'https://mmos.com/wp-content/uploads/2015/10/pocket-maplestory-banner.jpg', 1, 'Intel Core 2 Duo de 3,0 GHz', 'Intel Core i3 de 4,0 GHz', 1);
CALL INSERTAR_JUEGO(@id_juego, 4, 'Guild Wars 2', '2022-08-23', 0, 'Juego de rol online con combates de acción trepidante y con una profunda personalización de personajes', 7168, 'https://www.pngitem.com/pimgs/m/195-1956338_guild-wars-2-logo-png-transparent-png.png', 'https://i.imgur.com/BFkJ9BI.jpeg', 1, 'Intel Core i3 3.4 GHz', 'Intel Core i5', 1);
CALL INSERTAR_JUEGO(@id_juego, 5, 'Fallout 4', '2015-11-10', 5, 'Juego de rol de acción ambientado en un mundo post-apocalíptico', 8.00, 'https://i.imgur.com/Wlj77jZ.png', 'https://cdn.cloudflare.steamstatic.com/steam/apps/377160/header.jpg?t=1629138088', 1, 'Intel Core i5-2300 2.8 GHz', 'Intel Core i7-4790 3.6 GHz', 1);
CALL INSERTAR_SOFTWARE(@id_software, 6, 'Lossless Scaling', '2018-12-28', 7, 'La utilidad de juegos todo en uno para escalado y generación de frames', 150.00, 'https://styles.redditmedia.com/t5_aonbpu/styles/communityIcon_h19ct7wozz4d1.png', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/993090/header.jpg', 1, 'Intel HD Graphics', 'LS1');
CALL INSERTAR_BANDASONORA(@id_banda_sonora, 2, 'Nine Sols Soundtrack', '2024-05-29', 6, 'Contenido adicional para los niveles más profundos del videojuego Nine Sols', 600, 'https://i.imgur.com/GW9uk9K.png', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1913930/header.jpg?t=1717416666', 1, 'Hunter Wang', 'Hsiaotzu Lee', '03:15:10');
CALL INSERTAR_SOFTWARE(@id_software, 7, 'Aseprite', '2016-02-22', 20, 'Herramienta de arte pixelado para crear animaciones 2D, sprites y cualquier tipo de gráficos para juegos', 80, 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Logo_Aseprite.svg/1200px-Logo_Aseprite.svg.png', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/431730/header.jpg?t=1712679350', 1, 'Windows 8, 10, 11', 'MIT');
CALL INSERTAR_JUEGO(@id_juego, 5, 'DOOM', '2016-05-12', 20, 'Shooter en primera persona renovado de su versión lanzada el 10 de diciembre de 1993', 5500, 'https://mir-s3-cdn-cf.behance.net/project_modules/1400_opt_1/36116d43018691.57e09e24e07ca.jpg', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/379720/header.jpg?t=1692892793', 1, 'Intel Core i5-2400/AMD FX-8320 o superior', 'Intel Core i7-3770/AMD FX-8350 o superior', 1);
CALL INSERTAR_JUEGO(@id_juego, 8, 'World Of Goo', '2008-10-13', 10, 'Juego de puzzles/construcción basados en la física creado íntegramente por sólo dos tipos', 100, 'https://assets1.ignimgs.com/2017/02/15/world-of-goo---button-1487120649951.jpg', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/22000/header.jpg?t=1587578439', 1, 'Windows XP or Vista', 'NVIDIA GeForce 6100', 0);


CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 1", "Lograste pasar el nivel 1", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 2", "Lograste pasar el nivel 2", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Pasar nivel 3", "Lograste pasar el nivel 3", 1, 1);
CALL INSERTAR_LOGRO(@id_logro, "Nivel 50", "Llegaste al nivel 50", 1, 4);
CALL INSERTAR_LOGRO(@id_logro, "Amigos", "Hiciste tu primer amigo", 1, 4);
CALL INSERTAR_LOGRO(@id_logro, "Mist", "Conociste a Mist", 1, 4);
CALL INSERTAR_LOGRO(@id_logro, "Nivel 50 Mago", "Llegaste a nivel 50 con la clase Mago", 1, 5);
CALL INSERTAR_LOGRO(@id_logro, "Nivel 50 Guerrero", "Llegaste a nivel 50 con la clase Guerrero", 1, 5);
CALL INSERTAR_LOGRO(@id_logro, "Superviviente Nato", "Llegaste al nivel 5", 1, 6);
CALL INSERTAR_LOGRO(@id_logro, "Trotamundos imparable", "Llegaste al nivel 25", 1, 6);
CALL INSERTAR_LOGRO(@id_logro, "Parca", "Lograste ser la parca por 5 minutos", 1, 10);
CALL INSERTAR_LOGRO(@id_logro, "Double Kill", "Venciste a dos jugadores por tu cuenta", 1, 10);
call INSERTAR_ETIQUETA(@id_etiqueta,'Terror');
call INSERTAR_ETIQUETA(@id_etiqueta,'Puzzle');
call INSERTAR_ETIQUETA(@id_etiqueta,'RPG');
call INSERTAR_ETIQUETA(@id_etiqueta,'Casual');
call INSERTAR_ETIQUETA(@id_etiqueta,'Accion');
call INSERTAR_ETIQUETA(@id_etiqueta,'Utilidad');
call INSERTAR_PRODUCTOETIQUETA(1, 2);
call INSERTAR_PRODUCTOETIQUETA(1, 5);
call INSERTAR_PRODUCTOETIQUETA(3, 2);
call INSERTAR_PRODUCTOETIQUETA(3, 5);
call INSERTAR_PRODUCTOETIQUETA(4, 3);
call INSERTAR_PRODUCTOETIQUETA(4, 4);
call INSERTAR_PRODUCTOETIQUETA(5, 2);
call INSERTAR_PRODUCTOETIQUETA(5, 5);
call INSERTAR_PRODUCTOETIQUETA(6, 5);
call INSERTAR_PRODUCTOETIQUETA(6, 2);
call INSERTAR_PRODUCTOETIQUETA(7, 6);
call INSERTAR_PRODUCTOETIQUETA(8, 6);
call INSERTAR_PRODUCTOETIQUETA(10, 5);
call INSERTAR_PRODUCTOETIQUETA(11, 2);
call INSERTAR_PRODUCTOETIQUETA(11, 4);

CALL CREAR_USUARIO(@id_usuario, 'cuenta_sofia', 'Sofia', 'a20210750@pucp.edu.pe', '123456789', 'password_sofia', 19, '2004-07-01', 1, 4, 2, 5, 1);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca, @id_usuario);
call INSERTAR_CARTERA(@id_cartera, @id_usuario, 0, 0);
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
CALL INSERTAR_GESTOR(@id_gestor, @id_usuario, 0, 0, 0, 3, 3, 0, 0);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,1);
call INSERTAR_PRODUCTOADQUIRIDO(@id_producto_adquirido,@id_biblioteca,2);

UPDATE ProductoAdquirido SET fecha_ejecucion='2024-05-29', tiempo_uso='01:20:23' where id_producto_adquirido=1;
UPDATE ProductoAdquirido SET fecha_ejecucion='2024-05-29', tiempo_uso='00:18:38' where id_producto_adquirido=3;
