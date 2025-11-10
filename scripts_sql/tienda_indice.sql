-- ============================================================
-- ACA - PROYECTO FINAL: SISTEMA DE GESTIÓN DE BASE DE DATOS 
-- PARA TIENDA DE DISPOSITIVOS ELECTRÓNICOS
-- ------------------------------------------------------------
-- Autor: Johann Casallas Becerra
-- Institución: Corporación Unificada Nacional de Educación Superior (CUN)
-- Asignatura: Gestión de Bases de Datos
-- Motor: MySQL 8.0
-- Fecha: Noviembre 2025
-- Descripción: Script de creación de índices para optimización de consultas.
-- ============================================================


-- ============================================================
-- 1. Índice para búsqueda de productos por nombre
-- ------------------------------------------------------------
-- Justificación:
-- Este índice mejora el rendimiento de las consultas que utilizan
-- cláusulas WHERE o LIKE sobre el campo “nombre” de la tabla “productos”.
-- Permite una búsqueda más rápida al filtrar productos por nombre.
-- ============================================================

CREATE INDEX idx_producto_nombre 
ON productos(nombre);


-- ============================================================
-- 2. Índice para obtención de productos por categoría
-- ------------------------------------------------------------
-- Justificación:
-- Este índice optimiza las consultas que relacionan productos y categorías
-- mediante la columna “id_categoria”, facilitando el uso de INNER JOIN
-- y las consultas filtradas por categoría específica.
-- ============================================================

CREATE INDEX idx_producto_categoria 
ON productos(id_categoria);


-- ============================================================
-- 3. Índice para obtención de pedidos por cliente
-- ------------------------------------------------------------
-- Justificación:
-- Este índice acelera las consultas que filtran o agrupan pedidos
-- en función del cliente asociado (“id_cliente”).
-- Es útil para reportes de compras, historial de pedidos o análisis de clientes.
-- ============================================================

CREATE INDEX idx_pedido_cliente 
ON pedidos(id_cliente);


-- ============================================================
-- FIN DEL SCRIPT DE CREACIÓN DE ÍNDICES
-- ============================================================
