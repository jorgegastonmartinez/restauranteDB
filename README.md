# Título del Proyecto

RestauranteDB

# Autor

Jorge Martinez

# Curso
SQL

# Entrega
Proyecto final

# Comisión
81830

## Sobre mi proyecto

Este proyecto tiene como finalidad el diseño y desarrollo de una base de datos relacional orientada a la gestión operativa de un restaurante. Se enfoca en organizar y centralizar información clave vinculada al personal, control de inventario, proveedores y registro de asistencia, permitiendo así una administración más eficiente. A través de un modelo estructurado, se busca reflejar los procesos reales que se dan en la operación diaria del restaurante.

## Objetivo

El objetivo del proyecto es construir una base de datos relacional que centralice y gestione la información esencial del funcionamiento diario del restaurante, abarcando múltiples áreas funcionales:

* Recursos Humanos: registrar datos del personal y sus roles (salón, cocina, administración), así como controlar su asistencia mediante fichaje diario.

* Inventario: cargar y actualizar el stock mensual de insumos, permitiendo su trazabilidad, control de consumo y relación directa con las compras a proveedores.

* Proveedores: almacenar y relacionar datos de los proveedores con los productos e insumos suministrados.

* Ventas: registro de operaciones de venta por día, permitiendo identificar tendencias y picos de demanda.

* Mermas: cargar los desperdicios o pérdidas de productos, insumos o preparaciones, con el fin de identificar puntos críticos y optimizar costos operativos.

El sistema está diseñado para ofrecer una visión integrada de la operación, permitiendo mejorar, reducir pérdidas, y generar información útil para áreas contables, logísticas y analíticas.


## Situación Problemática

En la operación diaria de un restaurante, se manejan grandes volúmenes de información relacionados con la asistencia del personal, control de inventario, compras a proveedores, ventas, y pérdidas por mermas. Cuando esta información no está organizada de forma estructurada o depende de registros manuales (papel, planillas de cálculo, mensajes), se generan múltiples problemas operativos y administrativos:

1. Falta de control sobre la asistencia del personal, lo que impide verificar puntualidad y cumplimiento de horarios.

2. Gestión desorganizada del inventario, dificultando el seguimiento de insumos, detectando faltantes o excesos de stock de forma tardía.

3. Datos de proveedores dispersos o incompletos, lo que complica la reposición de insumos, la comparación de precios y la planificación de compras.

4. Ausencia de registros precisos de ventas por turno o categoría, impidiendo analizar el desempeño del restaurante y anticipar necesidades de producción.

5. Falta de control sobre las mermas, lo que genera pérdidas invisibles que impactan negativamente en los costos operativos.

La ausencia de una base de datos relacional impide que estas áreas estén conectadas entre sí, generando ineficiencias, pérdida de tiempo y mayor margen de error humano.

La implementación de una base de datos relacional busca resolver estas problemáticas mediante la centralización, organización y vinculación de la información, ofreciendo una herramienta integral que permite mejorar el control de insumos, optimizar recursos humanos, analizar resultados de ventas y reducir pérdidas por mala gestión de stock o producción.


## Modelo de Negocio 

La organización que utiliza esta solución es un restaurante urbano ubicado en una zona comercial de oficinas, cuya propuesta gastronómica abarca desayuno, almuerzo y merienda, siendo el almuerzo el punto más fuerte de ventas por el flujo de clientes en horarios laborales.

El restaurante opera con un modelo mixto de atención en salón y take-away, con una alta rotación de comensales al mediodía. Para garantizar una gestión eficiente, su estructura organizativa se divide en tres áreas clave:

- Salón: personal a cargo de la atención al cliente, servicio de mesa, take-away y armado de pedidos.

- Cocina: equipo responsable de la producción diaria de alimentos, organización de la mise en place, control de calidad y despacho de platos.

- Administración: encargados de coordinar compras, stock, proveedores, personal y supervisión general de las operaciones.

Este modelo permite centralizar toda la información operativa clave en una única base de datos, lo que optimiza la gestión, reduce errores humanos y proporciona datos analíticos valiosos para la toma de decisiones estratégicas, como planificación de compras, control de costos, productividad del personal y desempeño por turno o producto.


## Tablas

### Tabla 'empleados'

Almacena los datos del personal del restaurante. Cada empleado tiene asignado un rol operativo (salón, cocina o administración), además de un número de documento único y una fecha de ingreso al establecimiento. También se controla si el empleado está activo o no.

    id_empleado: identificador único del empleado.
    → clave primaria, se autoincrementa.

    nombre: nombre del empleado.
    → hasta 50 caracteres, obligatorio.

    apellido: apellido del empleado. 
    → Hasta 50 caracteres, obligatorio.

    dni: documento de identidad del empleado.
    → hasta 15 caracteres, obligatorio. Tiene restricción UNIQUE para evitar duplicados.

    rol: El puesto o función del empleado.
    → restringido a los tres tipos definidos.

    fecha_ingreso: Fecha en que el empleado ingresó a la empresa.
    → obligatorio.

    activo: Indica si el empleado está trabajando en la empresa. 
    → por defecto es TRUE.

    clave_acceso: contraseña o clave de acceso del empleado.
    → hasta 20 caracteres, obligatorio.

### Tabla 'fichajes'

Registra los horarios de entrada y salida de los empleados. 

    id_fichaje: identificador único del registro de asistencia.
    → clave primaria, se autoincrementa.

    id_empleado: dentificador del empleado que hace el fichaje.
    → clave foránea que conecta con la tabla empleados.

    fecha: indica el día del fichaje.
    → obligatorio.

    hora_ingreso: hora exacta en que el empleado fichó.
    → obligatorio.

    hora_egreso: Hora en que el empleado salió ese día.
    → puede quedar NULL si el empleado aún no registró su salida.

### Tabla 'proveedores'

Almacena la información de los proveedores que suministran productos o servicios al restaurante.

    id_proveedor: identificador único del proveedor.
    → clave primaria, se autoincrementa.

    nombre: nombre del proveedor.
    → obligatorio, hasta 100 caracteres.

    telefono: número de teléfono del proveedor.
    → opcional, hasta 20 caracteres.

    email: correo electrónico del proveedor.
    → opcional, hasta 100 caracteres.

    categoria: tipo o categoría del proveedor (por ejemplo: alimentos, limpieza, etc.).
    → opcional, hasta 50 caracteres.

### Tabla 'productos'

Contiene los productos que utiliza el restaurante vinculados a sus proveedores.

    id_producto: identificador único del producto.
    → clave primaria, se autoincrementa.

    nombre: nombre del producto.
    → obligatorio, hasta 100 caracteres.

    unidad_medida: unidad en la que se mide el producto (ejemplo: kg, litros, unidad).
    → obligatorio, hasta 20 caracteres.

    id_proveedor: identificador del proveedor que suministra el producto.
    → clave foránea que conecta con la tabla proveedores, obligatorio.

### Tabla 'inventario'

Hace un recuento de los productos por mes.

    id_inventario: identificador único del registro de inventario.
    → clave primaria, se autoincrementa.

    id_producto: identificador del producto al que corresponde el inventario.
    → clave foránea que conecta con la tabla productos, obligatorio.

    mes: mes y año del registro en formato YYYY-MM.
    → obligatorio.

    cantidad: cantidad del producto en ese mes.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

    Restricción única en la combinación (id_producto, mes):
    → garantiza que no haya registros duplicados para el mismo producto en un mismo mes.

### Tabla 'ventas'

Registra las ventas realizadas en distintos turnos del día.

    id_venta: identificador único de la venta.
    → clave primaria, se autoincrementa.

    fecha: fecha en que se realizó la venta.
    → obligatorio.

    turno: turno del día en que se efectuó la venta.
    → obligatorio, valores posibles: 'desayuno', 'almuerzo', 'merienda'.

    total: monto total de la venta.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

### Tabla 'productos_vendidos'

Registra los productos vendidos en cada venta, detallando cantidades y precios.

    id_producto_vendido: identificador único del registro de producto vendido.
    → clave primaria, se autoincrementa.

    id_venta: identificador de la venta a la que pertenece este producto vendido.
    → clave foránea que conecta con la tabla ventas, obligatorio.

    id_producto: identificador del producto vendido.
    → clave foránea que conecta con la tabla productos, obligatorio.

    cantidad: cantidad del producto vendido en esa venta.
    → tipo entero y obligatorio.

    precio_unitario: precio por unidad del producto en esa venta.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

### Tabla 'mermas'

Registra las pérdidas o desperdicios de productos en la empresa.

    id_merma: identificador único del registro de merma.
    → clave primaria, se autoincrementa.

    id_producto: identificador del producto que sufrió la merma.
    → clave foránea que conecta con la tabla productos, obligatorio.

    fecha: fecha en que ocurrió la merma.
    → obligatorio.

    cantidad: cantidad del producto que se perdió o desperdició.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

    motivo: razón o descripción breve del por qué se produjo la merma.
    → opcional, hasta 100 caracteres.

### Tabla 'compras_proveedor'

Registra las compras realizadas a los proveedores.

    id_compra: identificador único de la compra.
    → clave primaria, se autoincrementa.

    id_proveedor: identificador del proveedor al que se le realizó la compra.
    → clave foránea que conecta con la tabla proveedores, obligatorio.

    nro_factura: número o código de la factura de la compra.
    → obligatorio, hasta 50 caracteres.

    fecha: fecha en que se realizó la compra.
    → obligatorio.

    importe_total: monto total de la compra.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

    metodo_pago: forma o método de pago utilizado (ejemplo: efectivo, tarjeta).
    → opcional, hasta 50 caracteres.

### Tabla 'detalle_compras_proveedor'

Registra el detalle de los productos comprados en cada compra realizada a proveedores.

    id_detalle: identificador único del detalle de compra.
    → clave primaria, se autoincrementa.

    id_compra: identificador de la compra a la que pertenece este detalle.
    → clave foránea que conecta con la tabla compras_proveedor, obligatorio.

    id_producto: identificador del producto comprado.
    → clave foránea que conecta con la tabla productos, obligatorio.

    cantidad: cantidad del producto comprado en esta compra.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

    unidad_medida: unidad en la que se mide la cantidad (ejemplo: kg, litros, unidad).
    → obligatorio, hasta 20 caracteres.

    precio_unitario: precio por unidad del producto en esta compra.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

### Tabla 'productos_venta'

Contiene los productos que se ofrecen para la venta en el restaurante.

    id_producto_venta: identificador único del producto para la venta.
    → clave primaria, se autoincrementa.

    nombre: nombre del producto vendido.
    → obligatorio, hasta 100 caracteres.

    descripcion: descripción detallada del producto.
    → opcional, tipo texto.

    precio_venta: precio al que se vende el producto.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

    unidad_venta: unidad en la que se vende el producto (ejemplo: unidad, plato, porción).
    → opcional, hasta 20 caracteres, por defecto 'unidad'.

    activo: indica si el producto está activo para la venta.
    → opcional, valor booleano, por defecto TRUE.

### Tabla 'recetas'

Almacena las recetas asociadas a los productos que se venden en el restaurante.

    id_receta: identificador único de la receta.
    → clave primaria, se autoincrementa.

    id_producto_venta: identificador del producto de venta al que pertenece la receta.
    → clave foránea que conecta con la tabla productos_venta, obligatorio.

    descripcion: detalle o explicación de la receta.
    → opcional, tipo texto.

### Tabla 'detalle_receta'

Define los ingredientes y cantidades que componen cada receta asociada a un producto de venta.

    id_detalle: identificador único del detalle de la receta.
    → clave primaria, se autoincrementa.

    id_receta: identificador de la receta a la que pertenece este ingrediente.
    → clave foránea que conecta con la tabla recetas, obligatorio.

    id_producto: identificador del producto (ingrediente) usado en la receta.
    → clave foránea que conecta con la tabla productos, obligatorio.

    cantidad: cantidad del ingrediente necesaria para la receta.
    → obligatorio, con hasta 10 dígitos y 2 decimales.

    unidad_medida: unidad en la que se mide la cantidad (ejemplo: kg, litros, unidad).
    → opcional, hasta 20 caracteres.


## Vistas

### Vista 'vista_asistencia_empleados'

Muestra un resumen de la asistencia diaria de los empleados, incluyendo nombre, apellido, hora de ingreso y egreso.

    CREATE VIEW vista_asistencia_empleados AS
    SELECT e.id_empleado, e.nombre, e.apellido, f.fecha, f.hora_ingreso, f.hora_egreso
    FROM empleados e
    JOIN fichajes f ON e.id_empleado = f.id_empleado;

Consulta

    SELECT * 
    FROM vista_asistencia_empleados;
    SELECT nombre, apellido, fecha FROM vista_asistencia_empleados WHERE fecha = CURDATE();


### Vista 'vista_inventario_mensual'

Consulta el inventario disponible de productos por mes, junto con el proveedor correspondiente..

    CREATE VIEW vista_inventario_mensual AS
    SELECT p.nombre AS producto, pr.nombre AS proveedor, i.mes, i.cantidad
    FROM inventario i
    JOIN productos p ON i.id_producto = p.id_producto
    JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor;

Consulta

    SELECT * FROM vista_inventario_mensual;
    SELECT producto, cantidad FROM vista_inventario_mensual WHERE mes = '2025-06';

### Vista 'vista_ventas_detalladas'

Obtiene un detalle de las ventas realizadas, incluyendo productos vendidos, cantidades, precios y totales.

    CREATE OR REPLACE VIEW vista_ventas_detalladas AS
    SELECT v.id_venta, v.fecha, v.turno, p.nombre AS producto, pv.cantidad, pv.precio_unitario, 
       (pv.cantidad * pv.precio_unitario) AS subtotal
    FROM ventas v
    JOIN productos_vendidos pv ON v.id_venta = pv.id_venta
    JOIN productos p ON pv.id_producto = p.id_producto;

Consulta

    SELECT * FROM vista_ventas_detalladas;
    SELECT fecha, producto, subtotal FROM vista_ventas_detalladas WHERE turno = 'almuerzo';

### Vista 'vista_compras_proveedores'

Muestra todas las compras realizadas a proveedores con su desglose por producto.

    CREATE OR REPLACE VIEW vista_compras_proveedores AS
    SELECT c.id_compra, c.fecha, pr.nombre AS proveedor, d.cantidad, d.unidad_medida, 
       d.precio_unitario, (d.cantidad * d.precio_unitario) AS subtotal, p.nombre AS producto
    FROM compras_proveedor c
    JOIN detalle_compras_proveedor d ON c.id_compra = d.id_compra
    JOIN productos p ON d.id_producto = p.id_producto
    JOIN proveedores pr ON c.id_proveedor = pr.id_proveedor;

Consulta

    SELECT * FROM vista_compras_proveedores;
    SELECT proveedor, SUM(subtotal) AS total_comprado 
    FROM vista_compras_proveedores 
    GROUP BY proveedor;

### Vista 'vista_mermas'

Registra las mermas de productos, indicando fecha, motivo y cantidad perdida.

    CREATE OR REPLACE VIEW vista_mermas AS
    SELECT m.fecha, p.nombre AS producto, m.cantidad, m.motivo
    FROM mermas m
    JOIN productos p ON m.id_producto = p.id_producto;

Consulta

    SELECT * FROM vista_mermas;
    SELECT producto, SUM(cantidad) AS total_merma 
    FROM vista_mermas 
    GROUP BY producto;


## Funciones

### Funcion 'calcular_antiguedad_empleado'

Devuelve la cantidad de días trabajados por un empleado desde su fecha de ingreso.

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

Consulta

    SELECT nombre, apellido, calcular_antiguedad_empleado(fecha_ingreso) AS dias_trabajados
    FROM empleados;


### Funcion 'estado_empleado'

Devuelve un texto indicando si un empleado está activo o no.

    DELIMITER //

    CREATE FUNCTION estado_empleado(activo BOOLEAN)
    RETURNS VARCHAR(20)
    DETERMINISTIC
    BEGIN
        RETURN IF(activo = TRUE, 'Activo', 'Inactivo');
    END;
    //
    DELIMITER ;

Consulta

    SELECT nombre, apellido, estado_empleado(activo) AS estado
    FROM empleados;


### Funcion 'costo_total_compra'

Calcula el costo total de una compra de proveedor multiplicando cantidad × precio unitario.

    DELIMITER //

    CREATE FUNCTION costo_total_compra(cantidad DECIMAL(10,2), precio DECIMAL(10,2))
    RETURNS DECIMAL(10,2)
    DETERMINISTIC
    BEGIN
        RETURN cantidad * precio;
    END;
    //
    DELIMITER ;

Consulta

    SELECT id_compra, id_producto, costo_total_compra(cantidad, precio_unitario) AS subtotal
    FROM detalle_compras_proveedor;

### Funcion 'stock_producto_mes'

Devolver la cantidad disponible en inventario de un producto para un mes dado.

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

Consulta

    SELECT p.nombre, stock_producto_mes(p.id_producto, '2025-06') AS stock_septiembre
    FROM productos p;


## Stored procedures

### Stored procedures 'registrar_fichaje'

Automatiza el registro de asistencia, evita tener que escribir la consulta de inserción manual.

    DELIMITER //

    CREATE PROCEDURE registrar_fichaje(IN idEmpleado INT, IN horaEntrada TIME)
    BEGIN
        INSERT INTO fichajes (id_empleado, fecha, hora_ingreso)
        VALUES (idEmpleado, CURDATE(), horaEntrada);
    END;

    //
    DELIMITER ;

Llamada

    CALL registrar_fichaje(3, '09:00:00');

### Stored procedures 'cerrar_fichaje'

Permite cerrar el registro de asistencia del día automáticamente.

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

Llamada

    CALL cerrar_fichaje(3, '17:30:00');

### Stored procedures 'registrar_venta'

Centraliza en un procedimiento la lógica de registrar ventas, reduciendo errores.

    DELIMITER //

    CREATE PROCEDURE registrar_venta(IN turnoVenta ENUM('desayuno','almuerzo','merienda'), IN total DECIMAL(10,2))
    BEGIN
        INSERT INTO ventas (fecha, turno, total)
        VALUES (CURDATE(), turnoVenta, total);
    END;

    //
    DELIMITER ;

Llamada

    CALL registrar_venta('almuerzo', 15400.50);

### Stored procedures 'reporte_ventas_turno'

Facilita obtener estadísticas de ventas sin armar la query cada vez.

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

Llamada

    CALL reporte_ventas_turno('2025-08-01', '2025-08-08');

## Triggers

### Trigger 'trg_desactivar_clave'

Cada vez que un empleado se da de baja (activo = FALSE), se borra su clave_acceso automáticamente.

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

Prueba

    UPDATE empleados SET activo = FALSE WHERE id_empleado = 2;
    SELECT * FROM empleados WHERE id_empleado = 2;

### Trigger 'trg_control_merma_negativa'

Evitar que se inserten mermas con cantidad negativa.

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

Prueba

    INSERT INTO mermas (id_producto, fecha, cantidad, motivo)
    VALUES (1, '2025-06-08', -3, 'Error de carga');


## Índice

[Creación de tablas](./create_table.sql)

[Diagrama Entidad-Relacion ER](./Captura%20de%20pantalla%202025-08-08%20a%20la(s)%2012.40.54.png)

[Inserción de datos](./insert_data.sql)

[Vistas](./vistas.sql)

[Funciones](./funciones.sql)

[Stored procedures](./stored_procedures.sql)

[Triggers](./triggers.sql)


## Contacto

- **Linkedin** [LinkedIn](https://www.linkedin.com/in/jorgegastonmartinez/)  
- **Correo** [Correo Electrónico](mailto:jgastonmartinez@gmail.com)