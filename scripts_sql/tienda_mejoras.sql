-- ============================================================
-- ACA - PROYECTO FINAL: SISTEMA DE GESTIÓN DE BASE DE DATOS 
-- PARA TIENDA DE DISPOSITIVOS ELECTRÓNICOS
-- ------------------------------------------------------------
-- Autor: Johann Casallas Becerra
-- Institución: Corporación Unificada Nacional de Educación Superior (CUN)
-- Asignatura: Gestión de Bases de Datos
-- Motor: MySQL 8.0
-- Fecha: Noviembre 2025
-- Descripción: Propuestas de mejora, triggers y optimizaciones adicionales.
-- ============================================================


-- ============================================================
-- 1. TRIGGER: Restricción de máximo 5 pedidos pendientes por cliente
-- ------------------------------------------------------------
-- Objetivo:
-- Evitar la sobrecarga de pedidos en proceso por cliente, limitando
-- a un máximo de cinco (5) pedidos con estado "pendiente" (id_estado = 1).
-- ============================================================

DELIMITER $$

CREATE TRIGGER limitar_pedidos_pendientes
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    DECLARE pedidos_pendientes INT;

    SELECT COUNT(*) INTO pedidos_pendientes
    FROM pedidos
    WHERE id_cliente = NEW.id_cliente 
      AND id_estado = 1;

    IF NEW.id_estado = 1 AND pedidos_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya tiene 5 pedidos pendientes. No se puede registrar un nuevo pedido.';
    END IF;
END$$

DELIMITER ;


-- ============================================================
-- 2. TRIGGER: Validación de reseñas solo para clientes que compraron el producto
-- ------------------------------------------------------------
-- Objetivo:
-- Garantizar la integridad de las reseñas, permitiendo solo aquellas
-- realizadas por clientes que efectivamente compraron el producto.
-- ============================================================

DELIMITER $$

CREATE TRIGGER validar_resena
BEFORE INSERT ON resenas
FOR EACH ROW
BEGIN
    DECLARE conteo INT;

    SELECT COUNT(*) INTO conteo
    FROM pedidos
    INNER JOIN detalles_pedido ON pedidos.id_pedido = detalles_pedido.id_pedido
    WHERE pedidos.id_pedido = NEW.id_pedido
      AND pedidos.id_cliente = NEW.id_cliente
      AND detalles_pedido.id_producto = NEW.id_producto;

    IF conteo = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no puede registrar una reseña de un producto que no ha comprado.';
    END IF;
END$$

DELIMITER ;


-- ============================================================
-- 3. ÍNDICES ADICIONALES PARA OPTIMIZACIÓN DE CONSULTAS
-- ------------------------------------------------------------
-- Objetivo:
-- Mejorar la velocidad de búsqueda y ejecución en operaciones frecuentes
-- dentro de las tablas “pedidos”, “detalles_pedido” y “clientes”.
-- ============================================================

-- Búsqueda de pedidos por fecha
CREATE INDEX idx_pedido_fecha 
ON pedidos(fecha_pedido);

-- Búsqueda de pedidos por estado
CREATE INDEX idx_pedido_estado 
ON pedidos(id_estado);

-- Relación de detalles por ID de pedido
CREATE INDEX idx_detalle_pedido_id 
ON detalles_pedido(id_pedido);

-- Búsqueda de clientes por correo electrónico
CREATE INDEX idx_cliente_correo 
ON clientes(correo);


-- ============================================================
-- 4. VISTA: Productos con precio menor a $5.000
-- ------------------------------------------------------------
-- Objetivo:
-- Facilitar la visualización de los productos de bajo costo disponibles.
-- Esta vista puede ser utilizada para reportes o promociones.
-- ============================================================

CREATE OR REPLACE VIEW vista_productos_bajo_precio AS
SELECT 
    id_producto, 
    nombre, 
    precio
FROM productos
WHERE precio < 5000.00;

-- Consulta de validación
SELECT * FROM vista_productos_bajo_precio;


-- ============================================================
-- FIN DEL SCRIPT DE PROPUESTAS DE MEJORA Y OPTIMIZACIÓN
-- ============================================================
