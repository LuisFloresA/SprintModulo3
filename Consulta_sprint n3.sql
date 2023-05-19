-- Creación base de datos tienda telovendo para sprint n3.

CREATE DATABASE TLOVENDO_SPRINT3;
use TLOVENDO_SPRINT3;

-- Creación de un usuario con todos los privilegios.

CREATE USER 'TLOVENDO_SPRINT3'@'localhost' IDENTIFIED BY '1234a';
GRANT ALL PRIVILEGES ON * . * TO 'TLOVENDO_SPRINT3'@'localhost';
FLUSH PRIVILEGES;

-- Creación de tablas de información relacional de la tienda TLOVENDO_SPRINT3


-- En esta seccion se crea la tabla categoria con sus respectivo pk y atributos
CREATE TABLE `categoria` (
  `id_categoria` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre_categoria` varchar(40) NOT NULL
);

-- En esta seccion se crea la tabla categoria con sus respectivo pk y atributos, ademas se asocia una FK haciendo referencia a la pk de la tabla categoria
CREATE TABLE `proveedor` (
  `id_proveedor` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_categoria` int(8) NOT NULL,
  `nombre_represent` varchar(40) NOT NULL,
  `nombre_corp` varchar(40) NOT NULL,
  `correo` varchar(40) NOT NULL,
  FOREIGN KEY (`id_categoria`) REFERENCES `categoria`(`id_categoria`)
);

-- Creacion de una tabla de telefono de contacto ya que se especifica que al menos 2 numeros de teléfonos debe contar el proveedor
CREATE TABLE `telefonoContacto` (
  `id_telefono` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_proveedor` int(8) NOT NULL,
  `nombre_recibe` varchar(40) NOT NULL,
  `telefono` varchar(12) NOT NULL,
  FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor`(`id_proveedor`)
);

-- Tabla producto que contiene un atributo "Stock Global", el cual consiste en la suma (teórica) provista por todos los proveedores relacionados con el producto
CREATE TABLE `producto` (
  `id_producto` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_categoria` int(8) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `color` varchar(12) NOT NULL,
  `precio` int(10) NOT NULL,
  `stockGlobal` int(3) NOT NULL,
  FOREIGN KEY (`id_categoria`) REFERENCES `categoria`(`id_categoria`)
);

-- Tabla cliente que contiene información básica de este
CREATE TABLE `cliente` (
  `id_cliente` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `direccion` varchar(40) NOT NULL
);

-- Tabla que se produce del rompimiento entre el proveedor y el producto, en este caso se contiene un atributo llamado "stockProveedor" el cual consiste en cuanto stock del producto provee dicho proveedor (recordar que el StockGlobal es el aporte de todos los proveedores a este producto)
CREATE TABLE `rompeProvProduct` (
  `id_rompePP` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_proveedor` int(8) NOT NULL,
  `id_producto` int(8) NOT NULL,
  `stockProveedor` int(3) NOT NULL,
  FOREIGN KEY (`id_producto`) REFERENCES `producto`(`id_producto`),
  FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor`(`id_proveedor`)
);

-- Tabla resultante de la asociación de clientes y productos, en ella se puede observar el atributo "unidadesVendidas", el cual consiste en cuantas unidades son "adquiridas" por el cliente de dicho producto para que, de esta forma, se pueda obtener el producto mas solicitado o mas "popular"
CREATE TABLE `rompeClientProduct` (
  `id_rompeCP` int(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_producto` int(8) NOT NULL,
  `id_cliente` int(8) NOT NULL,
  `unidadesVendidas` int(8) NOT NULL,
  FOREIGN KEY (`id_producto`) REFERENCES `producto`(`id_producto`),
  FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id_cliente`)
);

-- Carga de registros a cada tabla

INSERT INTO categoria (nombre_categoria) VALUES
('notebook'),
('impresoras'),
('televisores'),
('celulares');

INSERT INTO proveedor (id_categoria, nombre_represent, nombre_corp, correo) VALUES
(1, 'Juan Mella', 'dell', 'juan.mella@dell.com'),
(1, 'Francisca Campusano', 'microTIC', 'francisca.campusano@microtic.com'),
(1, 'María Prieto', 'asus', 'maria.prieto@asus.com'),
(2, 'Pedro Troncoso','kyocera', 'pedro.troncoso@kyocera.com'),
(2, 'Carolina Fritz', 'epson', 'carolina.fritz@epson.com'),
(2, 'Eduardo Flores', 'EduNet', 'eduardo.flores@edunet.com'),
(2, 'José Alvarez', 'Dimerc', 'jose.alvarez@dimerc.com'),
(4, 'Andrés Lopez', 'Samsung', 'andres.lopez@samsung.com');

INSERT INTO cliente (nombre, apellido, direccion) VALUES
('Julian', 'Perez', 'Ohiggins 34'),
('Manuel', 'Cid', 'pasaje 4'),
('Felipe', 'Sanchez', 'San martin 88'),
('Raul', 'Bilbao', 'Carrera 12'),
('Maria', 'Flores', 'Pratt 93');

INSERT INTO producto (id_categoria, nombre, color, precio, stockGlobal) VALUES
(1, 'Notebook Dell Alien 4', 'Azul', '700000',25),
(1, 'Notebook Dell 1', 'Blanco', '650000',50),
(2, 'Impresora laser Kyocera', 'Negro', '120000',45),
(1, 'Notebook Asus Rog 2', 'Negro', '1000000',33),
(2, 'Impresora cartucho Kyocera', 'Blanco', '100000',58),
(1, 'Notebook Dell Alien 5', 'Azul', '12000000',70),
(4, 'Galaxy S23', 'Azul', '1000000',100),
(4, 'Galaxy A23', 'Negro', '700000',65),
(2, 'Impresora laser Epson', 'Azul', '250000',50),
(2, 'Impresora cartucho Epson', 'Azul', '700000',80),
(1, 'Notebook Dell Alienware R15', 'Azul', '2000000',5);

INSERT INTO telefonocontacto (id_proveedor, nombre_recibe, telefono) VALUES
(1,'Carlos','1234567890'),
(1,'Sofía', '9876543210'),
(2, 'Andrés', '4567890123'),
(2, 'María', '8901234567'),
(3, 'Alejandra', '2345678901'),
(3, 'Javier', '6789012345'),
(4, 'Laura', '0123456789'),
(4, 'Roberto', '5678901234'),
(5, 'Isabel', '9012345678'),
(5, 'Pedro', '3456789012'),
(6, 'Miguel', '56965545676'),
(6, 'Antonio', '3654646466'),
(6, 'Francisca R.', '456778745'),
(7, 'Jazmin', '225345663'),
(7, 'Elson', '85456373654'),
(8, 'Luis', '4566745647'),
(8, 'Claudio', '678474647');

INSERT INTO rompeProvProduct (id_proveedor,id_producto,stockProveedor) VALUES 
(1,1,10),
(1,2,30),
(1,6,50),
(2,1,15),
(2,2,20),
(2,6,20),
(3,4,33),
(4,3,45),
(4,5,58),
(5,9,30),
(5,10,60),
(6,9,15),
(6,10,5),
(7,9,5),
(7,10,15),
(8,6,100),
(8,7,65),
(1,11,5);

INSERT INTO rompeclientproduct (id_producto, id_cliente, unidadesVendidas) VALUES
(1,1,3),
(1,2,1),
(2,1,10),
(2,2,3),
(2,3,1),
(2,4,8),
(3,1,1),
(3,2,4),
(3,3,1),
(3,4,5),
(3,5,9),
(4,1,1),
(4,2,3),
(4,3,6),
(4,4,1),
(4,5,10),
(5,1,1),
(5,2,5),
(5,3,1),
(5,4,2),
(6,1,2),
(6,2,1),
(6,3,3),
(6,4,5),
(7,3,10),
(8,1,5),
(8,3,6),
(9,5,10);

-- Cuál es la categoría de productos que más se repite.

Select cat.nombre_categoria, COUNT(prod.id_categoria) as RepeticionCategoria, cat.id_categoria as codigoCat from producto as prod INNER JOIN categoria as cat ON prod.id_categoria = cat.id_categoria GROUP BY cat.nombre_categoria ORDER BY RepeticionCategoria DESC;

-- Cuáles son los productos con mayor stock

Select prod.nombre, prod.stockGlobal from producto as prod GROUP BY prod.nombre ORDER BY prod.stockGlobal DESC;

-- Qué color de producto es más común en nuestra tienda.

SELECT color, SUM(stockGlobal) AS stock_total FROM producto GROUP BY color ORDER BY stock_total DESC;

-- Cual o cuales son los proveedores con menor stock de productos.

SELECT prov.nombre_represent, SUM(rompepp.stockProveedor) AS totalStockProveedor FROM rompeProvProduct rompepp INNER JOIN proveedor prov ON rompepp.id_proveedor = prov.id_proveedor GROUP BY rompepp.id_proveedor ORDER BY totalStockProveedor ASC;

-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.

UPDATE categoria SET nombre_categoria = 'Electrónica y computación' WHERE id_categoria = ( SELECT prod.id_categoria FROM rompeclientproduct rompecp INNER JOIN producto prod ON rompecp.id_producto = prod.id_producto GROUP BY prod.id_producto ORDER BY SUM(rompecp.unidadesVendidas) DESC LIMIT 1);
