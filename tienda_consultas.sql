-- ============================================================
-- SISTEMA DE GESTIÓN DE BASE DE DATOS - TIENDA DE ELECTRÓNICOS
-- CONSULTAS SQL DE VALIDACIÓN Y ANÁLISIS
-- Autor: Johann Casallas Becerra
-- Institución: Corporación Unificada Nacional de Educación Superior (CUN)
-- Asignatura: Gestión de Bases de Datos
-- ============================================================


-- ============================================================
-- 1. Listar productos disponibles por categoría, ordenados por precio
-- ============================================================

SELECT 
    c.nombre AS categoria,
    p.nombre AS producto,
    p.precio,
    p.stock
FROM productos p
INNER JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE p.stock > 0
ORDER BY c.nombre ASC, p.precio ASC;

-- Descripción:
-- Esta consulta lista los productos actualmente disponibles (con stock mayor a cero),
-- mostrando la categoría a la que pertenecen, su nombre, precio y cantidad disponible.
-- El INNER JOIN vincula las tablas “productos” y “categorias” para obtener el nombre
-- de la categoría correspondiente. Los resultados se ordenan primero por categoría
-- y luego por precio de menor a mayor, facilitando el análisis de inventario.


-- ============================================================
-- 2. Mostrar clientes con pedidos pendientes y total de compras realizadas
-- ============================================================

SELECT
    c.id_cliente,
    c.nombre AS cliente,
    COUNT(p.id_pedido) AS pedidos_pendientes,
    SUM(dp.cantidad * dp.precio_unitario) AS total_compras
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
INNER JOIN detalles_pedido dp ON p.id_pedido = dp.id_pedido
WHERE p.id_estado = 1
GROUP BY c.id_cliente, c.nombre;

-- Descripción:
-- Esta consulta muestra los clientes con pedidos pendientes (estado = 1).
-- Se utiliza COUNT() para calcular la cantidad de pedidos pendientes y SUM()
-- para obtener el valor total de las compras registradas.
-- Se realiza un INNER JOIN entre “clientes”, “pedidos” y “detalles_pedido”
-- a fin de relacionar la información de las órdenes con los datos del cliente.
-- El agrupamiento (GROUP BY) se hace por id_cliente y nombre para consolidar los resultados.


-- ============================================================
-- 3. Reporte de los 5 productos con mejor calificación promedio en reseñas
-- ============================================================

SELECT 
    p.nombre AS producto,
    ROUND(AVG(r.calificacion), 2) AS calificacion_promedio
FROM resenas r
INNER JOIN productos p ON r.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY calificacion_promedio DESC
LIMIT 5;

-- Descripción:
-- Esta consulta genera un ranking de los 5 productos mejor valorados por los clientes.
-- Se emplea la función AVG() para calcular la calificación promedio en la tabla “resenas”.
-- El INNER JOIN con la tabla “productos” permite mostrar el nombre asociado al id_producto.
-- Los resultados se agrupan por producto y se ordenan de forma descendente
-- para priorizar los productos con mejor valoración promedio.
-- La cláusula LIMIT 5 restringe el resultado a los cinco productos con mayor puntuación.

-- ============================================================
-- Fin del archivo de consultas SQL
-- ============================================================
