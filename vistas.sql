USE restauranteDB;

-- VISTA 1: vista_asistencia_empleados
-- Muestra un resumen de la asistencia diaria de los empleados, incluyendo nombre, apellido, hora de ingreso y egreso.
-- Tablas que la componen: empleados, fichajes.

CREATE VIEW vista_asistencia_empleados AS
SELECT e.id_empleado, e.nombre, e.apellido, f.fecha, f.hora_ingreso, f.hora_egreso
FROM empleados e
JOIN fichajes f ON e.id_empleado = f.id_empleado;

-- CONSULTA
SELECT * 
FROM vista_asistencia_empleados;
SELECT nombre, apellido, fecha FROM vista_asistencia_empleados WHERE fecha = CURDATE();

-- VISTA 2: vista_inventario_mensual
-- Consulta el inventario disponible de productos por mes, junto con el proveedor correspondiente.
-- Tablas que la componen: inventario, productos, proveedores.

CREATE VIEW vista_inventario_mensual AS
SELECT p.nombre AS producto, pr.nombre AS proveedor, i.mes, i.cantidad
FROM inventario i
JOIN productos p ON i.id_producto = p.id_producto
JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor;

-- CONSULTA
SELECT * FROM vista_inventario_mensual;
SELECT producto, cantidad FROM vista_inventario_mensual WHERE mes = '2025-06';


-- VISTA 3: vista_ventas_detalladas
-- Obtiene un detalle de las ventas realizadas, incluyendo productos vendidos, cantidades, precios y totales.
-- Tablas que la componen: ventas, productos_vendidos, productos.

CREATE OR REPLACE VIEW vista_ventas_detalladas AS
SELECT v.id_venta, v.fecha, v.turno, p.nombre AS producto, pv.cantidad, pv.precio_unitario, 
       (pv.cantidad * pv.precio_unitario) AS subtotal
FROM ventas v
JOIN productos_vendidos pv ON v.id_venta = pv.id_venta
JOIN productos p ON pv.id_producto = p.id_producto;

-- CONSULTA
SELECT * FROM vista_ventas_detalladas;
SELECT fecha, producto, subtotal FROM vista_ventas_detalladas WHERE turno = 'almuerzo';

-- VISTA 4: vista_compras_proveedores
-- Muestra todas las compras realizadas a proveedores con su desglose por producto.
-- Tablas que la componen: compras_proveedor, detalle_compras_proveedor, productos, proveedores.

CREATE OR REPLACE VIEW vista_compras_proveedores AS
SELECT c.id_compra, c.fecha, pr.nombre AS proveedor, d.cantidad, d.unidad_medida, 
       d.precio_unitario, (d.cantidad * d.precio_unitario) AS subtotal, p.nombre AS producto
FROM compras_proveedor c
JOIN detalle_compras_proveedor d ON c.id_compra = d.id_compra
JOIN productos p ON d.id_producto = p.id_producto
JOIN proveedores pr ON c.id_proveedor = pr.id_proveedor;

-- CONSULTA
SELECT * FROM vista_compras_proveedores;
SELECT proveedor, SUM(subtotal) AS total_comprado 
FROM vista_compras_proveedores 
GROUP BY proveedor;

-- VISTA 5: vista_mermas
-- Registra las mermas de productos, indicando fecha, motivo y cantidad perdida.
-- Tablas que la componen: mermas, productos.

CREATE OR REPLACE VIEW vista_mermas AS
SELECT m.fecha, p.nombre AS producto, m.cantidad, m.motivo
FROM mermas m
JOIN productos p ON m.id_producto = p.id_producto;

-- CONSULTA
SELECT * FROM vista_mermas;
SELECT producto, SUM(cantidad) AS total_merma 
FROM vista_mermas 
GROUP BY producto;