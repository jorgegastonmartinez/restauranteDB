USE restauranteDB;

-- FUNCION 1: calcular_antiguedad_empleado
-- Devuelve la cantidad de días trabajados por un empleado desde su fecha de ingreso.
-- Objetivo: Saber la antigüedad exacta de un empleado en días.
-- Tablas involucradas: empleados (columna fecha_ingreso).

DELIMITER //

CREATE FUNCTION calcular_antiguedad_empleado(fecha_ingreso DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE antiguedad INT;
    SET antiguedad = DATEDIFF(CURDATE(), fecha_ingreso);
    RETURN antiguedad;
END;
//
DELIMITER ;

-- CONSULTA
SELECT nombre, apellido, calcular_antiguedad_empleado(fecha_ingreso) AS dias_trabajados
FROM empleados;


-- FUNCION 2: estado_empleado
-- Devuelve un texto indicando si un empleado está activo o no.
-- Objetivo: Mejorar la legibilidad de reportes de personal.
-- Tablas involucradas: empleados (columna activo).

DELIMITER //

CREATE FUNCTION estado_empleado(activo BOOLEAN)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN IF(activo = TRUE, 'Activo', 'Inactivo');
END;
//
DELIMITER ;

-- CONSULTA
SELECT nombre, apellido, estado_empleado(activo) AS estado
FROM empleados;

-- FUNCION 3: costo_total_compra
-- Calcula el costo total de una compra de proveedor multiplicando cantidad × precio unitario.
-- Objetivo: Automatizar el cálculo de totales en detalle de compras.
-- Tablas involucradas: detalle_compras_proveedor.

DELIMITER //

CREATE FUNCTION costo_total_compra(cantidad DECIMAL(10,2), precio DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cantidad * precio;
END;
//
DELIMITER ;

-- CONSULTA
SELECT id_compra, id_producto, costo_total_compra(cantidad, precio_unitario) AS subtotal
FROM detalle_compras_proveedor;

-- FUNCION 4: stock_producto_mes
-- Objetivo: Devolver la cantidad disponible en inventario de un producto para un mes dado.
-- Tablas que usa: inventario.

DELIMITER //

CREATE FUNCTION stock_producto_mes(idProd INT, mesParam VARCHAR(7))
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE stock DECIMAL(10,2);
    SELECT cantidad 
    INTO stock
    FROM inventario
    WHERE id_producto = idProd AND mes = mesParam;
    RETURN IFNULL(stock, 0);
END;

//
DELIMITER ;

-- CONSULTA
SELECT p.nombre, stock_producto_mes(p.id_producto, '2025-06') AS stock_septiembre
FROM productos p;
