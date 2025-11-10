-- ============================================================
-- ACA - PROYECTO FINAL: SISTEMA DE GESTIÓN DE BASE DE DATOS 
-- PARA TIENDA DE DISPOSITIVOS ELECTRÓNICOS
-- ------------------------------------------------------------
-- Autor: Johann Casallas Becerra
-- Institución: Corporación Unificada Nacional de Educación Superior (CUN)
-- Asignatura: Gestión de Bases de Datos
-- Motor: MySQL 8.0
-- Fecha: Noviembre 2025
-- Descripción: Script de inserción de datos iniciales (población de tablas).
-- ============================================================


-- ============================================================
-- 1. Inserciones en tabla: estados
-- Descripción: Define los posibles estados de los pedidos.
-- ============================================================

INSERT INTO estados VALUES (0, 'Pendiente');
INSERT INTO estados VALUES (0, 'Enviado');
INSERT INTO estados VALUES (0, 'Entregado');
INSERT INTO estados VALUES (0, 'Cancelado');


-- ============================================================
-- 2. Inserciones en tabla: categorias
-- Descripción: Clasificación de productos por tipo.
-- ============================================================

INSERT INTO categorias VALUES (0, 'Laptops', 'Computadoras portátiles de diversas marcas y configuraciones.');
INSERT INTO categorias VALUES (0, 'Smartphones', 'Celulares de diferentes marcas y modelos.');
INSERT INTO categorias VALUES (0, 'Pantallas', 'Televisores y monitores para computadoras o consolas.');
INSERT INTO categorias VALUES (0, 'Accesorios', 'Audífonos, bocinas, mouses, teclados y periféricos.');
INSERT INTO categorias VALUES (0, 'Videojuegos', 'Consolas, juegos y accesorios para entretenimiento digital.');


-- ============================================================
-- 3. Inserciones en tabla: clientes
-- Descripción: Registro de clientes de la tienda.
-- ============================================================

INSERT INTO clientes VALUES 
(0, 'Luis Garcia', 'luisg@gmail.com', '5512122101', 'Ajusco #13, Col. Pedregal, CDMX'),
(0, 'Raul Ortiz', 'raul.pollo@gmail.com', '5571718812', 'San Angel #2, Col. Coyoacan, CDMX'),
(0, 'Laura Sanchez', 'laura_san@gmail.com', '5590123542', 'Insurgentes Sur #1234, Col. Insurgentes, CDMX'),
(0, 'Pedro Perez', 'peterperez@outlook.com', '5599123212', 'Calle Santander #45, Col. Nativitas, CDMX'),
(0, 'Leonel Silva', 'leosilva10@gmail.com', '5510101010', 'Golondrinas #11, Col. Obrera, CDMX'),
(0, 'Jaime Nuno', 'jaime.nu88@gmail.com', '5552566671', 'Calle San Pablo #1, Col. Palmas, CDMX'),
(0, 'Ricardo Millos', 'richardmilles@outlook.com', '5512120989', 'Av. Tamaulipas #19, Col. Santa Lucia, CDMX'),
(0, 'Sergio Perez', 'sp11@gmail.com', '5511551107', 'Av. Americana #11, Col. Los Alamos, CDMX'),
(0, 'Carlos Lopez', 'charles.l@gmail.com', '5553441488', 'Calle Monaco #1, Col. Roma, CDMX'),
(0, 'Victoria Corona', 'vicky.cor@gmail.com', '5500236611', 'Calle Modelo #105, Col. Santa Anna, CDMX'),
(0, 'Carlos Sainz', 'carlos.s55@outlook.com', '5510556371', 'Calle Morita #55, Col. Madeira, CDMX'),
(0, 'Aitana Gomez', 'aitana_1212@yahoo.com.mx', '5587054422', 'Av. Corregidora #8, Col. Fundadores, CDMX'),
(0, 'Alma Guerrero', 'soulsoul88@gmail.com', '5591817721', 'Ajusco #188, Col. Pedregal, CDMX'),
(0, 'Maximilano Vazquez', 'maxv33@gmail.com', '5504041134', 'San Cristobal #33, Col. Vallejo, EDOMEX'),
(0, 'Cristian Rojo', 'cris.r7@gmail.com', '5577076677', 'Av. Mohammed Duvan #7, Col. Arabe, CDMX');


-- ============================================================
-- 4. Inserciones en tabla: productos
-- Descripción: Catálogo de productos por categoría.
-- ============================================================

-- Laptops
INSERT INTO productos VALUES 
(0, 'HP Pavilion 15', 'Laptop con Intel i5 y 8GB RAM', 12999.99, 4, 1),
(0, 'Lenovo IdeaPad 3', 'Laptop 15.6 pulgadas, Ryzen 5, SSD 512GB', 11499.00, 8, 1),
(0, 'Asus VivoBook 14', 'Laptop FULLHD, Intel i3, 8GB RAM', 10299.50, 5, 1),
(0, 'Acer Aspire 5', 'Laptop 15”, Ryzen 7, 16GB RAM', 13750.00, 6, 1),
(0, 'MacBook Air M2', 'Laptop Apple con chip M2', 18999.99, 4, 1),
(0, 'Lenovo Legion Slim 5', 'Ryzen 7, SSD 1TB, RTX 4060', 15499.00, 7, 1),
(0, 'MSI Modern 15', 'Intel i5, 8GB RAM', 14200.00, 5, 1);

-- Smartphones
INSERT INTO productos VALUES 
(0, 'iPhone 13', '128GB, cámara dual, iOS 17', 17499.00, 10, 2),
(0, 'Samsung Galaxy A54', '6.4”, AMOLED, 256GB', 8499.50, 5, 2),
(0, 'Xiaomi Redmi Note 13', '5G, cámara 108MP, 8GB RAM', 6599.99, 8, 2),
(0, 'Motorola G84', 'OLED, 128GB, 12GB RAM', 7199.00, 3, 2),
(0, 'Huawei Nova 11', '128GB almacenamiento, Android 13', 7999.00, 6, 2),
(0, 'Honor X8', '8GB RAM, Snapdragon 680', 5999.00, 8, 2),
(0, 'Poco 11T', 'Pantalla HD+, 265GB almacenamiento, 6GB RAM', 4399.99, 11, 2);

-- Pantallas y Monitores
INSERT INTO productos VALUES 
(0, 'Samsung Smart TV 50', 'Televisión 4K UHD con HDR', 8499.00, 4, 3),
(0, 'LG Monitor 27MK400H', 'Full HD 75Hz, 27 pulgadas', 3299.99, 6, 3),
(0, 'BenQ GW2480', 'Monitor 24”, IPS, HDMI', 2999.00, 7, 3),
(0, 'Hisense A6H', 'Smart TV 4K, 60Hz', 8699.00, 3, 3),
(0, 'AOC 24B1XHS', 'Monitor Gamer 24” sin bordes', 2649.00, 5, 3),
(0, 'Xiaomi 24i', 'Monitor 24” IPS, 75Hz', 2899.00, 4, 3),
(0, 'Philips TV', 'TV 32” HD', 2999.00, 2, 3);

-- Accesorios
INSERT INTO productos VALUES 
(0, 'Logitech G435', 'Audífonos gamer inalámbricos', 1499.00, 10, 4),
(0, 'Razer DeathAdder V2', 'Mouse gamer 20000 DPI', 1199.00, 7, 4),
(0, 'Redragon K552', 'Teclado mecánico retroiluminado', 999.00, 5, 4),
(0, 'Sony SRS-XB13', 'Bocina portátil bluetooth', 749.00, 8, 4),
(0, 'Logitech MK270', 'Combo teclado + mouse inalámbrico', 799.00, 9, 4),
(0, 'HP OMEN 600', 'Mouse gamer RGB', 849.00, 6, 4),
(0, 'HyperX Cloud Stinger', 'Audífonos con micrófono', 1149.00, 4, 4);

-- Videojuegos
INSERT INTO productos VALUES 
(0, 'PlayStation 5', 'Consola con lector de discos, 1TB SSD', 13499.00, 3, 5),
(0, 'Xbox Series S', 'Consola digital 512GB SSD', 7499.00, 6, 5),
(0, 'Nintendo Switch OLED', 'Pantalla OLED 7”, 128GB', 8899.00, 5, 5),
(0, 'DualSense Controller', 'Control PS5 color blanco', 1599.00, 10, 5),
(0, 'EA FC25', 'Juego físico para PS5', 1399.00, 7, 5),
(0, 'Elden Ring', 'Juego físico para Xbox Series X', 899.00, 8, 5),
(0, 'Mario Kart 8 Deluxe', 'Juego para Nintendo Switch', 1199.00, 4, 5);


-- ============================================================
-- 5. Inserciones en tabla: pedidos
-- Descripción: Registro de transacciones realizadas por los clientes.
-- ============================================================

INSERT INTO pedidos VALUES
(0, '2025-07-01', 1, 3),
(0, '2025-07-02', 2, 1),
(0, '2025-07-03', 3, 5),
(0, '2025-07-04', 1, 2),
(0, '2025-07-05', 4, 7),
(0, '2025-07-06', 2, 6),
(0, '2025-07-07', 3, 8),
(0, '2025-07-08', 1, 4),
(0, '2025-07-09', 2, 10),
(0, '2025-07-10', 3, 9),
(0, '2025-07-11', 4, 11),
(0, '2025-07-12', 1, 13),
(0, '2025-07-13', 2, 12),
(0, '2025-07-14', 3, 14),
(0, '2025-07-15', 4, 15),
(0, '2025-07-16', 1, 1),
(0, '2025-07-17', 2, 5),
(0, '2025-07-18', 3, 2),
(0, '2025-07-19', 1, 6),
(0, '2025-07-20', 4, 7);


-- ============================================================
-- 6. Inserciones en tabla: detalles_pedido
-- Descripción: Relación entre pedidos y productos adquiridos.
-- ============================================================

INSERT INTO detalles_pedido VALUES
(0, 1, 12999.99, 1, 1),
(0, 2, 8499.50, 1, 9),
(0, 1, 11499.00, 2, 2),
(0, 3, 999.00, 3, 25),
(0, 2, 7499.00, 4, 28),
(0, 1, 1599.00, 4, 29),
(0, 1, 17499.00, 5, 8),
(0, 1, 2999.00, 6, 14),
(0, 2, 8499.00, 6, 16),
(0, 1, 13499.00, 7, 26),
(0, 1, 13750.00, 8, 4),
(0, 1, 7999.00, 9, 12),
(0, 2, 2899.00, 9, 17),
(0, 1, 8899.00, 10, 30),
(0, 2, 1199.00, 10, 27),
(0, 1, 8699.00, 11, 16),
(0, 3, 849.00, 12, 24),
(0, 1, 10299.50, 13, 3),
(0, 1, 2649.00, 14, 18),
(0, 2, 4499.99, 15, 13),
(0, 1, 15499.00, 16, 6),
(0, 1, 599.00, 17, 23),
(0, 2, 8499.00, 18, 16),
(0, 1, 1399.00, 19, 28),
(0, 2, 18999.99, 20, 5);


-- ============================================================
-- 7. Inserciones en tabla: resenas
-- Descripción: Calificaciones y comentarios de los clientes.
-- ============================================================

INSERT INTO resenas VALUES
(0, 5, 3, 25, 4, 'Buen teclado aunque lo siento algo ruidoso', '2025-07-06'),
(0, 8, 7, 26, 5, 'Me gustó, buena duración de batería', '2025-07-10'),
(0, 9, 10, 30, 5, 'Excelente, el Zelda se ve muy bien', '2025-07-14'),
(0, 9, 10, 27, 4, 'Buen control, aunque un poco caro', '20
