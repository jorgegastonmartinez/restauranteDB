USE restauranteDB;

-- STORED PROCEDURES 1: registrar_fichaje
-- Objetivo: Insertar un fichaje de entrada de un empleado.
-- Beneficio: Automatiza el registro de asistencia, evita tener que escribir la consulta de inserción manual.
-- Tablas: fichajes, empleados.

DELIMITER //

CREATE PROCEDURE registrar_fichaje(IN idEmpleado INT, IN horaEntrada TIME)
BEGIN
    INSERT INTO fichajes (id_empleado, fecha, hora_ingreso)
    VALUES (idEmpleado, CURDATE(), horaEntrada);
END;

//
DELIMITER ;

-- LLAMADA
CALL registrar_fichaje(3, '09:00:00');

-- STORED PROCEDURES 2: cerrar_fichaje
-- Objetivo: Registrar la hora de egreso de un empleado en el último fichaje abierto.
-- Beneficio: Permite cerrar el registro de asistencia del día automáticamente.
-- Tablas: fichajes.

DELIMITER //

CREATE PROCEDURE cerrar_fichaje(IN idEmpleado INT, IN horaSalida TIME)
BEGIN
    UPDATE fichajes
    SET hora_egreso = horaSalida
    WHERE id_empleado = idEmpleado
      AND fecha = CURDATE()
      AND hora_egreso IS NULL;
END;

//
DELIMITER ;

-- LLAMADA
CALL cerrar_fichaje(3, '17:30:00');

-- STORED PROCEDURES 3: registrar_venta
-- Objetivo: Insertar una venta con su detalle de productos vendidos.
-- Beneficio: Centraliza en un procedimiento la lógica de registrar ventas, reduciendo errores.
-- Tablas: ventas, productos_vendidos.

DELIMITER //

CREATE PROCEDURE registrar_venta(IN turnoVenta ENUM('desayuno','almuerzo','merienda'), IN total DECIMAL(10,2))
BEGIN
    INSERT INTO ventas (fecha, turno, total)
    VALUES (CURDATE(), turnoVenta, total);
END;

//
DELIMITER ;

-- LLAMADA
CALL registrar_venta('almuerzo', 15400.50);

-- STORED PROCEDURES 4: reporte_ventas_turno
-- Objetivo: Generar un reporte de las ventas totales agrupadas por turno en un rango de fechas.
-- Beneficio: Facilita obtener estadísticas de ventas sin armar la query cada vez.
-- Tablas: ventas.

DELIMITER //

CREATE PROCEDURE reporte_ventas_turno(IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    SELECT turno, SUM(total) AS total_turno
    FROM ventas
    WHERE fecha BETWEEN fechaInicio AND fechaFin
    GROUP BY turno;
END;

//
DELIMITER ;

-- LLAMADA
CALL reporte_ventas_turno('2025-08-01', '2025-08-08');