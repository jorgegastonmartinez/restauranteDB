USE restauranteDB;

-- TRIGGER 1: trg_desactivar_clave
-- Objetivo: Cada vez que un empleado se da de baja (activo = FALSE), se borra su clave_acceso automáticamente.
-- Beneficio: Evita que empleados inactivos puedan entrar al sistema.
-- Tablas: empleados.

DELIMITER //

CREATE TRIGGER trg_desactivar_clave
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
    IF NEW.activo = FALSE THEN
        SET NEW.clave_acceso = NULL;
    END IF;
END;
//

DELIMITER ;

-- PRUEBA
UPDATE empleados SET activo = FALSE WHERE id_empleado = 2;
SELECT * FROM empleados WHERE id_empleado = 2;

-- DROP TRIGGER IF EXISTS trg_desactivar_clave;

-- TRIGGER 2: trg_control_merma_negativa
-- Objetivo: Evitar que se inserten mermas con cantidad negativa.
-- es muy util si alguien intenta registrar una merma de -3 kg, lanza un error y no permite guardar el dato.
-- Beneficio: Garantiza integridad de datos en mermas.
-- Tablas: mermas.

DELIMITER //

CREATE TRIGGER trg_control_merma_negativa
BEFORE INSERT ON mermas
FOR EACH ROW
BEGIN
    IF NEW.cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: la cantidad de merma debe ser mayor que cero';
    END IF;
END;

//
DELIMITER ;

INSERT INTO mermas (id_producto, fecha, cantidad, motivo)
VALUES (1, '2025-06-08', -3, 'Error de carga');
