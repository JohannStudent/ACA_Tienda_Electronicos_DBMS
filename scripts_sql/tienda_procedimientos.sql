-- ============================================================
-- ACA - PROYECTO FINAL: SISTEMA DE GESTIÓN DE BASE DE DATOS 
-- PARA TIENDA DE DISPOSITIVOS ELECTRÓNICOS
-- ------------------------------------------------------------
-- Autor: Johann Casallas Becerra
-- Institución: Corporación Unificada Nacional de Educación Superior (CUN)
-- Asignatura: Gestión de Bases de Datos
-- Motor: MySQL 8.0
-- Fecha: Noviembre 2025
-- Descripción: Procedimientos almacenados para operaciones clave del sistema.
-- ============================================================


-- ============================================================
-- 1. PROCEDIMIENTO: Registrar un nuevo pedido
-- ------------------------------------------------------------
-- Objetivo:
-- Registra un pedido verificando:
--  - Que el cliente no tenga más de 5 pedidos pendientes.
--  - Que haya stock suficiente del producto.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_registrar_pedido(
    IN id_cl INT,
    IN id_prod INT,
    IN cantidad INT,
    IN fecha_ped DATE
)
BEGIN
    DECLARE pedidos_pendientes INT;
    DECLARE stock_actual INT;
    DECLARE nuevo_id_pedido INT;

    SELECT COUNT(*) INTO pedidos_pendientes
    FROM pedidos
    WHERE id_cliente = id_cl AND id_estado = 1;

    IF pedidos_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya tiene 5 pedidos pendientes.';
    ELSE
        SELECT stock INTO stock_actual
        FROM productos
        WHERE id_producto = id_prod;

        IF stock_actual < cantidad THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No hay suficiente stock disponible para este producto.';
        ELSE
            INSERT INTO pedidos (id_cliente, fecha_pedido, id_estado)
            VALUES (id_cl, fecha_ped, 1);

            SELECT id_pedido INTO nuevo_id_pedido
            FROM pedidos
            WHERE id_cliente = id_cl AND fecha_pedido = fecha_ped
            ORDER BY id_pedido DESC
            LIMIT 1;

            INSERT INTO detalles_pedido (cantidad, precio_unitario, id_pedido, id_producto)
            VALUES (
                cantidad,
                (SELECT precio FROM productos WHERE id_producto = id_prod),
                nuevo_id_pedido,
                id_prod
            );

            UPDATE productos
            SET stock = stock - cantidad
            WHERE id_producto = id_prod;
        END IF;
    END IF;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_registrar_pedido(3, 1, 2, '2025-07-30');


-- ============================================================
-- 2. PROCEDIMIENTO: Registrar una reseña
-- ------------------------------------------------------------
-- Objetivo:
-- Inserta una reseña únicamente si el cliente ha comprado el producto.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_registrar_resena(
    IN id_cl INT,
    IN id_ped INT,
    IN id_prod INT,
    IN res_calificacion INT,
    IN res_comentario VARCHAR(100),
    IN res_fecha DATE
)
BEGIN
    IF (
        SELECT COUNT(*) 
        FROM pedidos p
        INNER JOIN detalles_pedido dp ON p.id_pedido = dp.id_pedido
        WHERE p.id_pedido = id_ped
          AND p.id_cliente = id_cl
          AND dp.id_producto = id_prod
    ) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no ha comprado este producto.';
    ELSE
        INSERT INTO resenas 
        VALUES (0, id_cl, id_ped, id_prod, res_calificacion, res_comentario, res_fecha);
    END IF;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_registrar_resena(3, 1, 1, 4, 'Excelente producto', '2025-07-30');


-- ============================================================
-- 3. PROCEDIMIENTO: Actualizar stock después de una venta
-- ------------------------------------------------------------
-- Objetivo:
-- Descuenta del inventario la cantidad vendida.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_actualizar_stock (
    IN id_prod INT,
    IN cantidad_vendida INT
)
BEGIN
    IF (
        SELECT stock FROM productos WHERE id_producto = id_prod
    ) < cantidad_vendida THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para completar la venta.';
    ELSE
        UPDATE productos
        SET stock = stock - cantidad_vendida
        WHERE id_producto = id_prod;
    END IF;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_actualizar_stock(6, 3);


-- ============================================================
-- 4. PROCEDIMIENTO: Cambiar estado de un pedido
-- ------------------------------------------------------------
-- Objetivo:
-- Modifica el estado de un pedido existente, validando su existencia.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_cambiar_estado(
    IN id_ped INT,
    IN id_est INT
)
BEGIN
    IF id_est NOT BETWEEN 1 AND 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado no válido. Los estados válidos son del 1 al 4.';
    ELSEIF NOT EXISTS (
        SELECT 1 FROM pedidos WHERE id_pedido = id_ped
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El pedido especificado no existe.';
    ELSE
        UPDATE pedidos
        SET id_estado = id_est
        WHERE id_pedido = id_ped;
    END IF;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_cambiar_estado(1, 2);


-- ============================================================
-- 5. PROCEDIMIENTO: Eliminar reseñas de un producto específico
-- ------------------------------------------------------------
-- Objetivo:
-- Elimina todas las reseñas asociadas a un producto determinado.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_eliminar_resena(IN id_prod INT)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM resenas WHERE id_producto = id_prod
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No existen reseñas para el producto especificado.';
    ELSE
        DELETE FROM resenas WHERE id_producto = id_prod;
    END IF;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_eliminar_resena(5);


-- ============================================================
-- 6. PROCEDIMIENTO: Agregar un nuevo producto
-- ------------------------------------------------------------
-- Objetivo:
-- Inserta un nuevo producto evitando duplicados por nombre y categoría.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_agregar_producto(
    IN nombre_prod VARCHAR(45),
    IN descripcion_prod VARCHAR(100),
    IN precio_prod DECIMAL(10,2),
    IN stock_prod INT,
    IN id_categoria_prod INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM productos
        WHERE nombre = nombre_prod
          AND id_categoria = id_categoria_prod
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe un producto con ese nombre en la misma categoría.';
    ELSE
        INSERT INTO productos 
        VALUES (0, nombre_prod, descripcion_prod, precio_prod, stock_prod, id_categoria_prod);
    END IF;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_agregar_producto('Nintendo Switch 2', 'Consola mejorada de Nintendo', 13999.00, 10, 5);


-- ============================================================
-- 7. PROCEDIMIENTO: Actualizar teléfono de un cliente
-- ------------------------------------------------------------
-- Objetivo:
-- Modifica el número telefónico de un cliente validando duplicados.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_actualizar_telefono_cliente(
    IN id_cl INT,
    IN telefono_cl VARCHAR(15)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM clientes WHERE id_cliente = id_cl
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se encontró el cliente especificado.';
    ELSEIF EXISTS (
        SELECT 1 FROM clientes
        WHERE telefono = telefono_cl AND id_cliente <> id_cl
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número telefónico ya está registrado por otro cliente.';
    ELSE
        UPDATE clientes
        SET telefono = telefono_cl
        WHERE id_cliente = id_cl;
    END IF;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_actualizar_telefono_cliente(3, '5512345688');


-- ============================================================
-- 8. PROCEDIMIENTO: Generar reporte de productos con bajo stock
-- ------------------------------------------------------------
-- Objetivo:
-- Muestra los productos con 5 o menos unidades disponibles.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_reporte_stock()
BEGIN
    SELECT nombre, stock
    FROM productos
    WHERE stock <= 5
    ORDER BY stock ASC;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- CALL sp_reporte_stock();


-- ============================================================
-- FIN DEL SCRIPT DE PROCEDIMIENTOS ALMACENADOS
-- ============================================================
