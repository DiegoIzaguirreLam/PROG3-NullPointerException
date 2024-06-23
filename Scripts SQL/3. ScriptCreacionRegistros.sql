-- -------------------------------------------------------------------------------------------
--												MONEDAS
-- -------------------------------------------------------------------------------------------
-- Insertamos Nuevo Sol Peruano y almacenamos su ID
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda_pen, 'Nuevo Sol Peruano', 'PEN', 'S/', 3.73);

-- Insertamos Dólar Estadounidense y almacenamos su ID
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda_usd, 'Dólar Estadounidense', 'USD', '$', 1);

-- Insertamos Euro y almacenamos su ID
CALL INSERTAR_TIPOMONEDA(@id_tipo_moneda_eur, 'Euro', 'EUR', '€', 0.93);



-- ---------------------------------------------------------------------------------------------
--												PAISES
-- ---------------------------------------------------------------------------------------------
-- Insertamos Perú con la moneda Nuevo Sol Peruano
CALL CREAR_PAIS(@id_pais_per, 'Perú', 'PER', @id_tipo_moneda_pen);

-- Insertamos Estados Unidos con la moneda Dólar Estadounidense
CALL CREAR_PAIS(@id_pais_usa, 'Estados Unidos', 'USA', @id_tipo_moneda_usd);

-- Insertamos España con la moneda Euro
CALL CREAR_PAIS(@id_pais_esp, 'España', 'ESP', @id_tipo_moneda_eur);

-- Insertamos Alemania con la moneda Euro
CALL CREAR_PAIS(@id_pais_deu, 'Alemania', 'DEU', @id_tipo_moneda_eur);

-- Insertamos Francia con la moneda Euro
CALL CREAR_PAIS(@id_pais_fra, 'Francia', 'FRA', @id_tipo_moneda_eur);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												USUARIOS
-- ---------------------------------------------------------------------------------------------
-- Usuarios en Perú
CALL CREAR_USUARIO(@id_usuario_fabricio, 'cuenta_fabricio', 'Fabricio', 
				   'fabricio@gmail.com', '937462819', 'fabricio', 
				   TIMESTAMPDIFF(YEAR, '1995-12-09', CURDATE()),
				   '1995-12-09', 1, @id_pais_per);

CALL CREAR_USUARIO(@id_usuario_ana, 'cuenta_ana', 'Ana', 
				   'ana@gmail.com', '987654321', 'ana', 
				   TIMESTAMPDIFF(YEAR, '1988-04-23', CURDATE()),
				   '1988-04-23', 1, @id_pais_per);

CALL CREAR_USUARIO(@id_usuario_julio, 'cuenta_julio', 'Julio', 
				   'julio@yahoo.com', '923456789', 'julio', 
				   TIMESTAMPDIFF(YEAR, '1990-07-15', CURDATE()),
				   '1990-07-15', 0, @id_pais_per);

-- Usuarios en Estados Unidos
CALL CREAR_USUARIO(@id_usuario_sofia, 'cuenta_sofia', 'Sofia', 
				   'sofia@hotmail.com', '982746573', 'sofia', 
				   TIMESTAMPDIFF(YEAR, '2000-05-11', CURDATE()),
				   '2000-05-11', 0, @id_pais_usa);

CALL CREAR_USUARIO(@id_usuario_john, 'cuenta_john', 'John', 
				   'john@gmail.com', '932457689', 'john', 
				   TIMESTAMPDIFF(YEAR, '1985-03-03', CURDATE()),
				   '1985-03-03', 1, @id_pais_usa);

CALL CREAR_USUARIO(@id_usuario_emily, 'cuenta_emily', 'Emily', 
				   'emily@yahoo.com', '945678234', 'emily', 
				   TIMESTAMPDIFF(YEAR, '1992-11-25', CURDATE()),
				   '1992-11-25', 1, @id_pais_usa);

-- Usuarios en España
CALL CREAR_USUARIO(@id_usuario_pablo, 'cuenta_pablo', 'Pablo', 
				   'pablo@gmail.com', '912345678', 'pablo', 
				   TIMESTAMPDIFF(YEAR, '1993-06-14', CURDATE()),
				   '1993-06-14', 0, @id_pais_esp);

CALL CREAR_USUARIO(@id_usuario_maria, 'cuenta_maria', 'Maria', 
				   'maria@yahoo.com', '923456789', 'maria', 
				   TIMESTAMPDIFF(YEAR, '1987-09-10', CURDATE()),
				   '1987-09-10', 1, @id_pais_esp);

CALL CREAR_USUARIO(@id_usuario_luis, 'cuenta_luis', 'Luis', 
				   'luis@hotmail.com', '932156789', 'luis', 
				   TIMESTAMPDIFF(YEAR, '1999-01-20', CURDATE()),
				   '1999-01-20', 0, @id_pais_esp);

-- Usuarios en Alemania
CALL CREAR_USUARIO(@id_usuario_hans, 'cuenta_hans', 'Hans', 
				   'hans@gmail.com', '914567890', 'hans', 
				   TIMESTAMPDIFF(YEAR, '1984-12-30', CURDATE()),
				   '1984-12-30', 1, @id_pais_deu);

CALL CREAR_USUARIO(@id_usuario_anna, 'cuenta_anna', 'Anna', 
				   'anna@hotmail.com', '923456123', 'anna', 
				   TIMESTAMPDIFF(YEAR, '1996-07-19', CURDATE()),
				   '1996-07-19', 0, @id_pais_deu);

CALL CREAR_USUARIO(@id_usuario_fritz, 'cuenta_fritz', 'Fritz', 
				   'fritz@yahoo.com', '937654321', 'fritz', 
				   TIMESTAMPDIFF(YEAR, '1995-10-05', CURDATE()),
				   '1995-10-05', 1, @id_pais_deu);

-- Usuarios en Francia
CALL CREAR_USUARIO(@id_usuario_pierre, 'cuenta_pierre', 'Pierre', 
				   'pierre@gmail.com', '915678234', 'pierre', 
				   TIMESTAMPDIFF(YEAR, '1982-11-02', CURDATE()),
				   '1982-11-02', 1, @id_pais_fra);

CALL CREAR_USUARIO(@id_usuario_claire, 'cuenta_claire', 'Claire', 
				   'claire@yahoo.com', '923456789', 'claire', 
				   TIMESTAMPDIFF(YEAR, '1997-04-12', CURDATE()),
				   '1997-04-12', 0, @id_pais_fra);

CALL CREAR_USUARIO(@id_usuario_jean, 'cuenta_jean', 'Jean', 
				   'jean@hotmail.com', '937654987', 'jean', 
				   TIMESTAMPDIFF(YEAR, '1989-08-22', CURDATE()),
				   '1989-08-22', 1, @id_pais_fra);
---------------------------------------------------------------------------------------------



-- -------------------------------------------------------------------------------------------
--											ASIGNACIÓN DE foto_url A USUARIOS
-- -------------------------------------------------------------------------------------------
-- Usuarios en Perú
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_fabricioFoto.png' WHERE UID = @id_usuario_fabricio;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_anaFoto.png' WHERE UID = @id_usuario_ana;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_julioFoto.jpeg' WHERE UID = @id_usuario_julio;

-- Usuarios en Estados Unidos
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_sofiaFoto.jpg' WHERE UID = @id_usuario_sofia;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_johnFoto.jpg' WHERE UID = @id_usuario_john;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_emilyFoto.png' WHERE UID = @id_usuario_emily;

-- Usuarios en España
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_pabloFoto.jpg' WHERE UID = @id_usuario_pablo;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_mariaFoto.png' WHERE UID = @id_usuario_maria;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_luisFoto.jpg' WHERE UID = @id_usuario_luis;

-- Usuarios en Alemania
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_hansFoto.png' WHERE UID = @id_usuario_hans;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_annaFoto.jpg' WHERE UID = @id_usuario_anna;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_fritzFoto.png' WHERE UID = @id_usuario_fritz;

-- Usuarios en Francia
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_pierreFoto.png' WHERE UID = @id_usuario_pierre;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_claireFoto.jpg' WHERE UID = @id_usuario_claire;
UPDATE Usuario SET foto_url = 'Uploads/Perfiles/cuenta_jeanFoto.jpg' WHERE UID = @id_usuario_jean;
---------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------
--												CARTERA
-- ---------------------------------------------------------------------------------------------
-- Cartera para Usuarios en Perú
CALL INSERTAR_CARTERA(@id_cartera_fabricio, @id_usuario_fabricio, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_ana, @id_usuario_ana, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_julio, @id_usuario_julio, 0, 0);

-- Cartera para Usuarios en Estados Unidos
CALL INSERTAR_CARTERA(@id_cartera_sofia, @id_usuario_sofia, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_john, @id_usuario_john, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_emily, @id_usuario_emily, 0, 0);

-- Cartera para Usuarios en España
CALL INSERTAR_CARTERA(@id_cartera_pablo, @id_usuario_pablo, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_maria, @id_usuario_maria, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_luis, @id_usuario_luis, 0, 0);

-- Cartera para Usuarios en Alemania
CALL INSERTAR_CARTERA(@id_cartera_hans, @id_usuario_hans, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_anna, @id_usuario_anna, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_fritz, @id_usuario_fritz, 0, 0);

-- Cartera para Usuarios en Francia
CALL INSERTAR_CARTERA(@id_cartera_pierre, @id_usuario_pierre, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_claire, @id_usuario_claire, 0, 0);
CALL INSERTAR_CARTERA(@id_cartera_jean, @id_usuario_jean, 0, 0);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												BIBLIOTECA
-- ---------------------------------------------------------------------------------------------
-- Biblioteca para Usuarios en Perú
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_fabricio, @id_usuario_fabricio);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_ana, @id_usuario_ana);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_julio, @id_usuario_julio);

-- Biblioteca para Usuarios en Estados Unidos
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_sofia, @id_usuario_sofia);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_john, @id_usuario_john);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_emily, @id_usuario_emily);

-- Biblioteca para Usuarios en España
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_pablo, @id_usuario_pablo);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_maria, @id_usuario_maria);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_luis, @id_usuario_luis);

-- Biblioteca para Usuarios en Alemania
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_hans, @id_usuario_hans);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_anna, @id_usuario_anna);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_fritz, @id_usuario_fritz);

-- Biblioteca para Usuarios en Francia
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_pierre, @id_usuario_pierre);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_claire, @id_usuario_claire);
CALL INSERTAR_BIBLIOTECA(@id_biblioteca_jean, @id_usuario_jean);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												PROVEEDOR
-- ---------------------------------------------------------------------------------------------
-- Proveedor para Juegos
CALL INSERTAR_PROVEEDOR(@id_proveedor_assassins_creed, 'Ubisoft');
CALL INSERTAR_PROVEEDOR(@id_proveedor_resident_evil, 'Capcom');
CALL INSERTAR_PROVEEDOR(@id_proveedor_geometry_dash, 'RobTop Games');
CALL INSERTAR_PROVEEDOR(@id_proveedor_maplestory, 'Nexon');
CALL INSERTAR_PROVEEDOR(@id_proveedor_guild_wars_2, 'ArenaNet');
CALL INSERTAR_PROVEEDOR(@id_proveedor_fallout_4, 'Bethesda Softworks');
CALL INSERTAR_PROVEEDOR(@id_proveedor_doom, 'Bethesda Softworks');
CALL INSERTAR_PROVEEDOR(@id_proveedor_world_of_goo, '2D Boy');

-- Proveedor para Software
CALL INSERTAR_PROVEEDOR(@id_proveedor_wallpaper_engine, 'Wallpaper Engine');
CALL INSERTAR_PROVEEDOR(@id_proveedor_lossless_scaling, 'Lossless Scaling');
CALL INSERTAR_PROVEEDOR(@id_proveedor_aseprite, 'Aseprite');

-- Proveedor para Bandas Sonoras
CALL INSERTAR_PROVEEDOR(@id_proveedor_hollow_knight_soundtrack, 'Team Cherry');
CALL INSERTAR_PROVEEDOR(@id_proveedor_nine_sols_soundtrack, 'Nine Sols');




-- ---------------------------------------------------------------------------------------------
--												ETIQUETAS
-- ---------------------------------------------------------------------------------------------
-- Etiqueta Terror
CALL INSERTAR_ETIQUETA(@id_etiqueta_terror, 'Terror');

-- Etiqueta Puzzle
CALL INSERTAR_ETIQUETA(@id_etiqueta_puzzle, 'Puzzle');

-- Etiqueta RPG
CALL INSERTAR_ETIQUETA(@id_etiqueta_rpg, 'RPG');

-- Etiqueta Casual
CALL INSERTAR_ETIQUETA(@id_etiqueta_casual, 'Casual');

-- Etiqueta Accion
CALL INSERTAR_ETIQUETA(@id_etiqueta_accion, 'Accion');

-- Etiqueta Utilidad
CALL INSERTAR_ETIQUETA(@id_etiqueta_utilidad, 'Utilidad');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												JUEGO
-- ---------------------------------------------------------------------------------------------
-- Juego: Assassin's Creed Odyssey
CALL INSERTAR_JUEGO(@id_juego_assassins_creed, @id_proveedor_assassins_creed, 
					'Assassin''s Creed Odyssey', '2018-10-05', 59.99, 
					'Viaja a la Antigua Grecia y vive épicas aventuras como un espartano.', 
					50.0, 'Uploads/Productos/Logo-AssassinsCreedOdyssey.png',
					'Uploads/Productos/Header-AssassinsCreedOdyssey.jpg', 
					1, 'Intel Core i5, 8 GB RAM, GTX 970',
					'Intel Core i7, 16 GB RAM, GTX 1080 Ti', 1);
				
-- Juego: Resident Evil 5: Gold Edition
CALL INSERTAR_JUEGO(@id_juego_resident_evil, @id_proveedor_resident_evil, 
					'Resident Evil 5: Gold Edition', '2015-03-27', 29.99, 
					'Revive la acción y el terror con Chris Redfield y Sheva Alomar en África.', 
					25.0, 'Uploads/Productos/Logo-ResidentEvil5.png',
					'Uploads/Productos/Header-ResidentEvil5.jpg', 
					1, 'Intel Core i3, 4 GB RAM, GTX 560',
					'Intel Core i5, 8 GB RAM, GTX 760', 1);
				
-- Juego: Geometry Dash
CALL INSERTAR_JUEGO(@id_juego_geometry_dash, @id_proveedor_geometry_dash, 
					'Geometry Dash', '2013-08-13', 3.99, 
					'Supera obstáculos geométricos en este juego de plataformas rítmico.', 
					1.0, 'Uploads/Productos/Logo-GeometryDash.png',
					'Uploads/Productos/Header-GeometryDash.jpg', 
					1, 'Procesador de 2.0 GHz, 1 GB RAM, Gráficos integrados',
					'Procesador de 2.4 GHz, 2 GB RAM, Gráficos dedicados', 0);

-- Juego: Maplestory
CALL INSERTAR_JUEGO(@id_juego_maplestory, @id_proveedor_maplestory, 
					'Maplestory', '2003-04-29', 1.0, 
					'Adéntrate en el mundo colorido y fantástico de Maplestory.', 
					2.0, 'Uploads/Productos/Logo-Maplestory.png',
					'Uploads/Productos/Header-Maplestory.jpg', 
					1, 'Pentium 3 a 800 MHz, 256 MB RAM, Gráficos 3D',
					'Pentium 4 a 1.5 GHz, 512 MB RAM, Gráficos acelerados', 1);

-- Juego: Guild Wars 2
CALL INSERTAR_JUEGO(@id_juego_guild_wars_2, @id_proveedor_guild_wars_2, 
					'Guild Wars 2', '2012-08-28', 29.99, 
					'Explora Tyria y lucha en un mundo en constante cambio.', 
					50.0, 'Uploads/Productos/Logo-GuildWars2.png',
					'Uploads/Productos/Header-GuildWars2.jpeg', 
					1, 'Intel Core 2 Duo, 2 GB RAM, GeForce 7800',
					'Intel Core i5, 4 GB RAM, GeForce GTX 560', 1);

-- Juego: Fallout 4
CALL INSERTAR_JUEGO(@id_juego_fallout_4, @id_proveedor_fallout_4, 
					'Fallout 4', '2015-11-10', 39.99, 
					'Explora un mundo post-apocalíptico lleno de peligros y posibilidades.', 
					30.0, 'Uploads/Productos/Logo-Fallout4.png',
					'Uploads/Productos/Header-Fallout4.jpg', 
					1, 'Intel Core i5, 8 GB RAM, GTX 780',
					'Intel Core i7, 8 GB RAM, GTX 1080', 0);
				
-- Juego: DOOM
CALL INSERTAR_JUEGO(@id_juego_doom, @id_proveedor_doom, 
					'DOOM', '2016-05-13', 19.99, 
					'Elimina demonios en Marte con un arsenal de armas increíbles.', 
					25.0, 'Uploads/Productos/Logo-DOOM.png', 'Uploads/Productos/Header-DOOM.jpg', 
					1, 'Intel Core i5, 8 GB RAM, GTX 670',
					'Intel Core i7, 16 GB RAM, GTX 970', 1);
				
-- Juego: World Of Goo
CALL INSERTAR_JUEGO(@id_juego_world_of_goo, @id_proveedor_world_of_goo, 
					'World Of Goo', '2008-10-13', 9.99, 
					'Construye estructuras con criaturas adhesivas en este juego de puzzles.', 
					0.5, 'Uploads/Productos/Logo-WorldOfGoo.jpg',
					'Uploads/Productos/Header-WorldOfGoo.jpg', 
					1, 'Procesador de 1.0 GHz, 512 MB RAM, Gráficos integrados',
					'Procesador de 1.5 GHz, 1 GB RAM, Gráficos dedicados', 0);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												BANDAS SONORAS
-- ---------------------------------------------------------------------------------------------
-- Banda Sonora: Hollow Knight - Official Soundtrack
CALL INSERTAR_BANDASONORA(@id_banda_sonora_hollow_knight,
						  @id_proveedor_hollow_knight_soundtrack,
						  'Hollow Knight - Official Soundtrack', '2017-02-10', 9.99,
						  'Banda sonora oficial del aclamado juego de acción y aventura Hollow Knight.', 
						  0.5, 'Uploads/Productos/Logo-HollowKnightSoundtrack.png',
						  'Uploads/Productos/Header-HollowKnightSoundtrack.jpg', 
						  1, 'Christopher Larkin', 'Christopher Larkin', '01:42:16');

-- Banda Sonora: Nine Sols Soundtrack
CALL INSERTAR_BANDASONORA(@id_banda_sonora_nine_sols, @id_proveedor_nine_sols_soundtrack,
						  'Nine Sols Soundtrack', '2022-04-15', 14.99,
						  'Banda sonora del juego indie Nine Sols, mezclando elementos electrónicos y atmosféricos.', 
						  0.8, 'Uploads/Productos/Logo-NineSolsSoundtrack.png',
						  'Uploads/Productos/Header-NineSolsSoundtrack.jpg', 
						  1, 'Samuel Laflamme', 'Samuel Laflamme', '01:18:45');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												SOFTWARE
-- ---------------------------------------------------------------------------------------------
-- Software: Wallpaper Engine
CALL INSERTAR_SOFTWARE(@id_software_wallpaper_engine, @id_proveedor_wallpaper_engine,
					   'Wallpaper Engine', '2016-10-16', 3.99,
					   'Permite usar vídeos y aplicaciones interactivas como fondos de pantalla.', 
					   0.1, 'Uploads/Productos/Logo-WallpaperEngine.png',
					   'Uploads/Productos/Header-WallpaperEngine.jpg', 
					   1, 'Windows 7 (64-bit), 1 GB RAM, DirectX 11', 'Freeware');

-- Software: Lossless Scaling
CALL INSERTAR_SOFTWARE(@id_software_lossless_scaling, @id_proveedor_lossless_scaling,
					   'Lossless Scaling', '2018-05-29', 9.99,
					   'Herramienta para escalar imágenes y gráficos sin pérdida de calidad.', 
					   0.2, 'Uploads/Productos/Logo-LosslessScaling.png',
					   'Uploads/Productos/Header-LosslessScaling.jpg', 
					   1, 'Windows 10 (64-bit), 2 GB RAM, DirectX 12', 'Propietaria');

-- Software: Aseprite
CALL INSERTAR_SOFTWARE(@id_software_aseprite, @id_proveedor_aseprite,
					   'Aseprite', '2016-02-22', 19.99,
					   'Editor de gráficos y animaciones para crear sprites y pixel art.', 
					   0.3, 'Uploads/Productos/Logo-Aseprite.png',
					   'Uploads/Productos/Header-Aseprite.jpg', 
					   1, 'Windows 8 (64-bit), 4 GB RAM, OpenGL 3.3', 'Open Source');
---------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------
--											PRODUCTO - ETIQUETA
-- ---------------------------------------------------------------------------------------------
-- Juegos y sus etiquetas
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_assassins_creed, 5); -- Accion
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_assassins_creed, 3); -- RPG

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_resident_evil, 1); -- Terror
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_resident_evil, 5); -- Accion

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_geometry_dash, 4); -- Casual
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_geometry_dash, 6); -- Utilidad

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_maplestory, 3); -- RPG
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_maplestory, 4); -- Casual

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_guild_wars_2, 3); -- RPG
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_guild_wars_2, 5); -- Accion

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_fallout_4, 5); -- Accion
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_fallout_4, 3); -- RPG

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_doom, 5); -- Accion
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_doom, 1); -- Terror

CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_world_of_goo, 4); -- Casual
CALL INSERTAR_PRODUCTOETIQUETA(@id_juego_world_of_goo, 6); -- Utilidad

-- Bandas Sonoras y sus etiquetas
CALL INSERTAR_PRODUCTOETIQUETA(@id_banda_sonora_hollow_knight, 2); -- Puzzle

CALL INSERTAR_PRODUCTOETIQUETA(@id_banda_sonora_nine_sols, 1); -- Terror

-- Software y sus etiquetas
CALL INSERTAR_PRODUCTOETIQUETA(@id_software_wallpaper_engine, 6); -- Utilidad

CALL INSERTAR_PRODUCTOETIQUETA(@id_software_lossless_scaling, 6); -- Utilidad

CALL INSERTAR_PRODUCTOETIQUETA(@id_software_aseprite, 6); -- Utilidad
CALL INSERTAR_PRODUCTOETIQUETA(@id_software_aseprite, 2); -- Puzzle
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												LOGROS
-- ---------------------------------------------------------------------------------------------
-- Logros del juego Assassin's Creed Odyssey
CALL INSERTAR_LOGRO(@id_logro_ac_odyssey_1,
					'Héroe de Esparta', 'Completa la historia principal del juego.',
					1, @id_juego_assassins_creed);

CALL INSERTAR_LOGRO(@id_logro_ac_odyssey_2,
					'Maestro del Olimpo', 'Alcanza el nivel máximo de experiencia.',
					1, @id_juego_assassins_creed);

CALL INSERTAR_LOGRO(@id_logro_ac_odyssey_3,
					'Conquistador', 'Completa todas las conquistas del juego.',
					1, @id_juego_assassins_creed);

-- Logros del juego Resident Evil 5: Gold Edition
CALL INSERTAR_LOGRO(@id_logro_resident_evil_5_1, 'Superviviente',
					'Sobrevive a todas las oleadas de enemigos en el modo Mercenarios.',
					1, @id_juego_resident_evil);

CALL INSERTAR_LOGRO(@id_logro_resident_evil_5_2, 'Explorador',
					'Descubre todos los secretos ocultos en las zonas de juego.',
					1, @id_juego_resident_evil);

-- Logros del juego Geometry Dash
CALL INSERTAR_LOGRO(@id_logro_geometry_dash_1, 'Ritmo Perfecto',
					'Completa cualquier nivel sin perder ritmo ni cometer errores.',
					1, @id_juego_geometry_dash);

-- Logros del juego Maplestory
CALL INSERTAR_LOGRO(@id_logro_maplestory_1, 'Explorador del Mundo',
					'Explora todas las regiones disponibles del juego.',
					1, @id_juego_maplestory);

-- Logros del juego Guild Wars 2
CALL INSERTAR_LOGRO(@id_logro_guild_wars_2_1, 'Leyenda Viviente',
					'Alcanza el rango de leyenda en el modo JcJ.',
					1, @id_juego_guild_wars_2);

CALL INSERTAR_LOGRO(@id_logro_guild_wars_2_2, 'Rey de la Colina',
					'Domina todas las fortalezas y torres en el mundo del juego.',
					1, @id_juego_guild_wars_2);

-- Logros del juego Fallout 4
CALL INSERTAR_LOGRO(@id_logro_fallout_4_1, 'Libertador',
					'Libera a todas las facciones principales del yugo de la opresión.',
					1, @id_juego_fallout_4);

-- Logros del juego DOOM
CALL INSERTAR_LOGRO(@id_logro_doom_1, 'Destructor de Demonios',
					'Aniquila a todos los jefes demoníacos en el Infierno.',
					1, @id_juego_doom);

CALL INSERTAR_LOGRO(@id_logro_doom_2, 'Inmortal',
					'Completa el juego en el nivel de dificultad más alto sin morir.',
					1, @id_juego_doom);

-- Logros del juego World of Goo
CALL INSERTAR_LOGRO(@id_logro_world_of_goo_1, 'Arquitecto Estelar',
					'Construye la torre más alta con Goo Balls en el Mundo Goo.',
					1, @id_juego_world_of_goo);

CALL INSERTAR_LOGRO(@id_logro_world_of_goo_2, 'Ingeniero de Puentes',
					'Construye puentes que soporten el peso de todos los Goo Balls.',
					1, @id_juego_world_of_goo);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												FOROS
-- ---------------------------------------------------------------------------------------------
-- Foro de Assassin's Creed Odyssey
CALL CREAR_FORO(@id_foro_ac_odyssey,
				'Odyssey Fans',
				'Foro para discutir todo sobre Assassin''s Creed Odyssey.',
				'Fabricio');

-- Foro de Resident Evil 5: Gold Edition
CALL CREAR_FORO(@id_foro_resident_evil_5,
				'RE5 Gold Community',
				'Comunidad para fanáticos de Resident Evil 5: Gold Edition.',
				'Ana');

-- Foro de Geometry Dash
CALL CREAR_FORO(@id_foro_geometry_dash,
				'Dashers Community',
				'Comunidad de jugadores de Geometry Dash para compartir niveles y consejos.',
				'Julio');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												SUBFOROS
-- ---------------------------------------------------------------------------------------------
-- Subforos de Assassin's Creed Odyssey
CALL CREAR_SUBFORO(@id_subforo_ac_odyssey_1,
				   @id_foro_ac_odyssey,
				   'Guías y Consejos');

CALL CREAR_SUBFORO(@id_subforo_ac_odyssey_2,
				   @id_foro_ac_odyssey,
				   'Discusión General');

CALL CREAR_SUBFORO(@id_subforo_ac_odyssey_3,
				   @id_foro_ac_odyssey,
				   'Problemas Técnicos');

-- Subforos de Resident Evil 5: Gold Edition
CALL CREAR_SUBFORO(@id_subforo_resident_evil_5_1,
				   @id_foro_resident_evil_5,
				   'Estrategias y Trucos');

CALL CREAR_SUBFORO(@id_subforo_resident_evil_5_2,
				   @id_foro_resident_evil_5,
				   'Modo Mercenarios');

CALL CREAR_SUBFORO(@id_subforo_resident_evil_5_3,
				   @id_foro_resident_evil_5,
				   'Soporte Técnico');

-- Subforos de Geometry Dash
CALL CREAR_SUBFORO(@id_subforo_geometry_dash_1,
				   @id_foro_geometry_dash,
				   'Creación de Niveles');

CALL CREAR_SUBFORO(@id_subforo_geometry_dash_2,
				   @id_foro_geometry_dash,
				   'Desafíos y Competencias');

CALL CREAR_SUBFORO(@id_subforo_geometry_dash_3,
				   @id_foro_geometry_dash,
				   'Ayuda y Consejos');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												HILOS
-- ---------------------------------------------------------------------------------------------
-- Hilos en los subforos de Assassin's Creed Odyssey
CALL CREAR_HILO(@id_hilo_ac_odyssey_1, @id_subforo_ac_odyssey_1,
				@id_usuario_fabricio, 0, CURDATE(), CURDATE(),
				'Uploads/AssassinsCreedHilo1.jpg');

CALL CREAR_HILO(@id_hilo_ac_odyssey_2, @id_subforo_ac_odyssey_2,
				@id_usuario_ana, 1, CURDATE(), CURDATE(),
				'Uploads/AssassinsCreedHilo2.jpg');

CALL CREAR_HILO(@id_hilo_ac_odyssey_3, @id_subforo_ac_odyssey_3,
				@id_usuario_julio, 0, CURDATE(), CURDATE(),
				'Uploads/AssassinsCreedHilo3.jpg');

-- Hilos en los subforos de Resident Evil 5: Gold Edition
CALL CREAR_HILO(@id_hilo_resident_evil_5_1, @id_subforo_resident_evil_5_1,
				@id_usuario_sofia, 1, CURDATE(), CURDATE(),
				'Uploads/ResidentEvilHilo1.jpg');

CALL CREAR_HILO(@id_hilo_resident_evil_5_2, @id_subforo_resident_evil_5_2,
				@id_usuario_john, 0, CURDATE(), CURDATE(),
				'Uploads/ResidentEvilHilo2.jpg');

CALL CREAR_HILO(@id_hilo_resident_evil_5_3, @id_subforo_resident_evil_5_3,
				@id_usuario_emily, 0, CURDATE(), CURDATE(),
				'Uploads/ResidentEvilHilo3.jpg');

-- Hilos en los subforos de Geometry Dash
CALL CREAR_HILO(@id_hilo_geometry_dash_1, @id_subforo_geometry_dash_1,
				@id_usuario_pablo, 0, CURDATE(), CURDATE(),
				'Uploads/GeometryDashHilo1.jpg');

CALL CREAR_HILO(@id_hilo_geometry_dash_2, @id_subforo_geometry_dash_2,
				@id_usuario_maria, 1, CURDATE(), CURDATE(),
				'Uploads/GeometryDashHilo2.jpg');

CALL CREAR_HILO(@id_hilo_geometry_dash_3, @id_subforo_geometry_dash_3,
				@id_usuario_luis, 0, CURDATE(), CURDATE(),
				'Uploads/GeometryDashHilo3.jpg');
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--												MENSAJES
-- ---------------------------------------------------------------------------------------------
-- Mensajes en los hilos del subforo de Assassin's Creed Odyssey
CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_1_1,
				   'Aquí tienes una guía completa para completar las misiones principales.',
				   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
				   @id_hilo_ac_odyssey_1, @id_usuario_fabricio);

CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_1_2,
    			   'Gracias por la guía, me ha sido muy útil.',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
				   @id_hilo_ac_odyssey_1, @id_usuario_ana);

CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_2_1,
    			   '¿Alguien más ha tenido problemas con el rendimiento del juego?',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_ac_odyssey_2, @id_usuario_julio);

CALL CREAR_MENSAJE(@id_mensaje_ac_odyssey_3_1,
    			   'Estoy experimentando errores gráficos extraños. ¿Alguna solución?',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_ac_odyssey_3, @id_usuario_ana);

-- Mensajes en los hilos del subforo de Resident Evil 5: Gold Edition
CALL CREAR_MENSAJE(@id_mensaje_resident_evil_5_1_1,
    			   'Aquí está mi estrategia para vencer a Wesker en el modo mercenarios.',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_resident_evil_5_1, @id_usuario_sofia);

CALL CREAR_MENSAJE(@id_mensaje_resident_evil_5_2_1,
    			   '¿Cuál es tu mejor tiempo en el modo mercenarios?',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_resident_evil_5_2, @id_usuario_john);

CALL CREAR_MENSAJE(@id_mensaje_resident_evil_5_3_1,
    			   'Mi juego se congela después de la cinemática. ¿Alguna solución?',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_resident_evil_5_3, @id_usuario_emily);

-- Mensajes en los hilos del subforo de Geometry Dash
CALL CREAR_MENSAJE(@id_mensaje_geometry_dash_1_1,
    			   'Aquí comparto mi nuevo nivel creado. ¡Espero que les guste!',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_geometry_dash_1, @id_usuario_pablo);

CALL CREAR_MENSAJE(@id_mensaje_geometry_dash_2_1,
    			   '¿Alguien quiere participar en un desafío de niveles difíciles?',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_geometry_dash_2, @id_usuario_maria);

CALL CREAR_MENSAJE(@id_mensaje_geometry_dash_3_1,
    			   'Necesito ayuda para pasar el nivel "Deadlocked". ¿Algún consejo?',
    			   CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    			   @id_hilo_geometry_dash_3, @id_usuario_luis);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--										  GESTOR DE SANCIONES
-- ---------------------------------------------------------------------------------------------
-- Gestores de Sanciones para los usuarios de Perú
CALL INSERTAR_GESTOR(@id_gestor_fabricio, @id_usuario_fabricio, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_ana, @id_usuario_ana, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_julio, @id_usuario_julio, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de Estados Unidos
CALL INSERTAR_GESTOR(@id_gestor_sofia, @id_usuario_sofia, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_john, @id_usuario_john, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_emily, @id_usuario_emily, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de España
CALL INSERTAR_GESTOR(@id_gestor_pablo, @id_usuario_pablo, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_maria, @id_usuario_maria, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_luis, @id_usuario_luis, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de Alemania
CALL INSERTAR_GESTOR(@id_gestor_hans, @id_usuario_hans, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_anna, @id_usuario_anna, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_fritz, @id_usuario_fritz, 0, 0, 0, 3, 3, 0, 0);

-- Gestores de Sanciones para los usuarios de Francia
CALL INSERTAR_GESTOR(@id_gestor_pierre, @id_usuario_pierre, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_claire, @id_usuario_claire, 0, 0, 0, 3, 3, 0, 0);
CALL INSERTAR_GESTOR(@id_gestor_jean, @id_usuario_jean, 0, 0, 0, 3, 3, 0, 0);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--											FORO - USUARIO
-- ---------------------------------------------------------------------------------------------
-- Creadores de los foros

-- Creador del foro de Assassin's Creed Odyssey
CALL CREAR_RELACION_FORO(@id_foro_ac_odyssey, @id_usuario_fabricio);

-- Creador del foro de Resident Evil 5: Gold Edition
CALL CREAR_RELACION_FORO(@id_foro_resident_evil_5, @id_usuario_ana);

-- Creador del foro de Geometry Dash
CALL CREAR_RELACION_FORO(@id_foro_geometry_dash, @id_usuario_julio);
---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--											PALABRAS PROHIBIDAS
-- ---------------------------------------------------------------------------------------------
-- Inserción de palabras prohibidas en el sistema

INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('maldición'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('grosería'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('insulto'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('despectivo'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('ofensa'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('vulgaridad'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('blasfemia'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('denigrante'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('difamación'));
INSERT INTO PalabrasProhibidas (palabra) VALUES (md5('obscenidad'));
-- -------------------------------------------------------------------------------------------