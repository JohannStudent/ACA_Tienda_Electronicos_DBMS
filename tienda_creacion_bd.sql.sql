-- ============================================================
-- ACA - PROYECTO FINAL: SISTEMA DE GESTIÓN DE BASE DE DATOS 
-- PARA TIENDA DE DISPOSITIVOS ELECTRÓNICOS
-- ------------------------------------------------------------
-- Autor: Johann Casallas Becerra
-- Institución: Corporación Unificada Nacional de Educación Superior (CUN)
-- Asignatura: Gestión de Bases de Datos
-- Motor: MySQL 8.0
-- Fecha: Noviembre 2025
-- Descripción: Script de creación de la base de datos, tablas y relaciones.
-- ============================================================

-- ============================================================
-- 1. Creación de la base de datos y selección del esquema
-- ============================================================

CREATE DATABASE IF NOT EXISTS tienda_electronicos;
USE tienda_electronicos;

-- ============================================================
-- 2. Tabla: estados
-- Descripción: Define los diferentes estados que pueden tener los pedidos.
-- ============================================================

CREATE TABLE estados (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

-- ============================================================
-- 3. Tabla: clientes
-- Descripción: Registra los datos de los clientes de la tienda.
-- ============================================================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    correo VARCHAR(80) UNIQUE NOT NULL,
    telefono VARCHAR(15) UNIQUE,
    direccion VARCHAR(100)
);

-- ============================================================
-- 4. Tabla: pedidos
-- Descripción: Almacena la información de los pedidos realizados por los clientes.
-- ============================================================

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    id_estado INT NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ============================================================
-- 5. Tabla: categorias
-- Descripción: Agrupa los productos según su tipo o familia.
-- ============================================================

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150)
);

-- ============================================================
-- 6. Tabla: productos
-- Descripción: Contiene los datos de los productos ofrecidos por la tienda.
-- ============================================================

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- ============================================================
-- 7. Tabla: detalles_pedido
-- Descripción: Almacena el detalle de cada producto incluido en los pedidos.
-- ============================================================

CREATE TABLE detalles_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- 8. Tabla: resenas
-- Descripción: Registra las reseñas y calificaciones de los clientes sobre los productos.
-- ============================================================

CREATE TABLE resenas (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    comentario VARCHAR(200),
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- FIN DEL SCRIPT DE CREACIÓN DE LA BASE DE DATOS
-- ============================================================
