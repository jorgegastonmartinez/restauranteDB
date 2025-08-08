# Título del Proyecto

RestauranteDB


# Autor

Jorge Martinez.


# Curso
Backend 


# Comisión
81830


## Sobre mi proyecto

Este proyecto tiene como finalidad el diseño y desarrollo de una base de datos relacional orientada a la gestión operativa de un restaurante. Se enfoca en organizar y centralizar información clave vinculada al personal, control de inventario, proveedores y registro de asistencia, permitiendo así una administración más eficiente de los recursos internos del establecimiento. A través de un modelo estructurado, se busca reflejar los procesos reales que se dan en la operación diaria del restaurante.


## Objetivo

El objetivo del proyecto es construir una base de datos relacional que centralice y gestione la información esencial del funcionamiento diario del restaurante, abarcando múltiples áreas funcionales:

* Recursos Humanos: registrar datos del personal y sus roles (salón, cocina, administración), así como controlar su asistencia mediante fichaje diario.

* Inventario: cargar y actualizar el stock mensual de insumos, permitiendo su trazabilidad, control de consumo y relación directa con las compras a proveedores.

* Proveedores: almacenar y relacionar datos de los proveedores con los productos e insumos suministrados.

* Ventas: registro de operaciones de venta por día, permitiendo identificar tendencias y picos de demanda.

* Mermas: cargar los desperdicios o pérdidas de productos, insumos o preparaciones, con el fin de identificar puntos críticos y optimizar costos operativos.

El sistema está diseñado para ofrecer una visión integrada de la operación, permitiendo mejorar la eficiencia interna, reducir pérdidas, y generar información útil para áreas contables, logísticas y analíticas.


## Situación Problemática

En la operación diaria de un restaurante, se manejan grandes volúmenes de información relacionados con la asistencia del personal, control de inventario, compras a proveedores, ventas, y pérdidas por mermas. Cuando esta información no está organizada de forma estructurada o depende de registros manuales (papel, planillas de cálculo, mensajes), se generan múltiples problemas operativos y administrativos:

1. Falta de control sobre la asistencia del personal, lo que impide verificar puntualidad y cumplimiento de horarios.

2. Gestión desorganizada del inventario, dificultando el seguimiento de insumos, detectando faltantes o excesos de stock de forma tardía.

3. Datos de proveedores dispersos o incompletos, lo que complica la reposición de insumos, la comparación de precios y la planificación de compras.

4. Ausencia de registros precisos de ventas por turno o categoría, impidiendo analizar el desempeño del restaurante y anticipar necesidades de producción.

5. Falta de control sobre las mermas, lo que genera pérdidas invisibles que impactan negativamente en los costos operativos.

La ausencia de una base de datos relacional impide que estas áreas estén conectadas entre sí, generando ineficiencias, pérdida de tiempo y mayor margen de error humano.

La implementación de una base de datos relacional busca resolver estas problemáticas mediante la centralización, organización y vinculación de la información clave, ofreciendo una herramienta integral que permite mejorar el control de insumos, optimizar recursos humanos, analizar resultados de ventas y reducir pérdidas por mala gestión de stock o producción.


## Modelo de Negocio 

La organización que utiliza esta solución es un restaurante urbano ubicado en una zona comercial de oficinas, cuya propuesta gastronómica abarca desayuno, almuerzo y merienda, siendo el almuerzo el punto más fuerte de ventas por el flujo de clientes en horarios laborales.

El restaurante opera con un modelo mixto de atención en salón y take-away, con una alta rotación de comensales al mediodía. Para garantizar una gestión eficiente, su estructura organizativa se divide en tres áreas clave:

- Salón: personal a cargo de la atención al cliente, servicio de mesa, take-away y armado de pedidos.

- Cocina: equipo responsable de la producción diaria de alimentos, organización de la mise en place, control de calidad y despacho de platos.

- Administración: encargados de coordinar compras, stock, proveedores, personal y supervisión general de las operaciones.

Este modelo permite centralizar toda la información operativa clave en una única base de datos, lo que optimiza la gestión, reduce errores humanos y proporciona datos analíticos valiosos para la toma de decisiones estratégicas, como planificación de compras, control de costos, productividad del personal y desempeño por turno o producto.



## Tablas

### Tabla empleados

Almacena los datos del personal del restaurante. Cada empleado tiene asignado un rol operativo (salón, cocina o administración), además de un número de documento único y una fecha de ingreso al establecimiento. También se controla si el empleado está activo o no.

    id_empleado: clave primaria, se autoincrementa

    dni: tiene restricción UNIQUE para evitar duplicados

    rol: restringido a los tres tipos definidos

    activo: por defecto es TRUE

    clave_acceso: NOT NULL


### Tabla fichajes

    id_fichaje: identificador único del registro de asistencia.

    id_empleado: clave foránea que conecta con la tabla Empleados.

    fecha: indica el día del fichaje.

    hora_ingreso: hora exacta en que el empleado fichó.

    hora_egreso puede quedar NULL si el empleado aún no egresó 

### Tabla proveedores

    id_proveedor: identificador único del proveedor.
    Clave primaria (PRIMARY KEY) de la tabla.

    nombre: nombre del proveedor o empresa proveedora.
    Campo obligatorio.

    telefono: número de contacto (opcional).

    email: correo electrónico del proveedor (opcional).



### Tabla productos

    id_producto: identificador único del producto.
    Clave primaria.

    nombre: nombre del producto o insumo (ej: tomate, pollo, aceite).
    Campo obligatorio.

    unidad_medida: unidad en la que se mide el producto (kg, litros, unidades, etc.).
    Campo obligatorio para control del inventario.

    id_proveedor: referencia al proveedor que suministra el producto.
    Clave foránea que enlaza con proveedores(id_proveedor).



### Tabla inventario

    id_inventario: identificador único del registro de inventario.
    Clave primaria (PRIMARY KEY).

    id_producto: referencia al producto cuyo stock se está registrando.
    Clave foránea vinculada a productos(id_producto).

    mes: mes y año del registro en formato AAAA-MM (ejemplo: '2025-08').
    Campo obligatorio para diferenciar inventarios mensuales.

    cantidad: cantidad disponible del producto en ese mes.
    Campo obligatorio, puede tener decimales para mayor precisión.

    Restricción única: combinación de id_producto y mes para evitar duplicados en el mismo período.


### Tabla ventas

    id_venta: identificador único de la venta.
    Clave primaria.

    fecha: fecha en que se realizó la venta.
    Campo obligatorio.

    turno: turno de la venta, con los valores permitidos: desayuno, almuerzo o merienda.
    Campo obligatorio.

    total: monto total de la venta en moneda local.
    Campo obligatorio.



### Tabla productos_vendidos

    id_producto_vendido: identificador único del ítem vendido.
    Clave primaria.

    id_venta: referencia a la venta asociada.
    Clave foránea que se relaciona con ventas(id_venta).

    id_producto: producto que fue vendido.
    Clave foránea que se relaciona con productos(id_producto).

    cantidad: cantidad de unidades vendidas del producto.
    Campo obligatorio.

    precio_unitario: precio unitario del producto al momento de la venta.
    Campo obligatorio. Esto te permite mantener un historial de precios aunque el valor cambie en el futuro.



### Tabla mermas
La tabla mermas permite registrar pérdidas de productos por razones como vencimiento, mala manipulación, rotura, etc. Esto es clave para llevar un buen control del inventario.

    id_merma: identificador único de la merma.
    Clave primaria.

    id_producto: producto afectado por la merma.
    Clave foránea que se relaciona con productos(id_producto).

    fecha: fecha en que se registró la merma.
    Campo obligatorio.

    cantidad: cantidad del producto descartada.
    Puede tener decimales.

    motivo: razón de la merma. Ejemplo: "producto vencido", "rotura", "sobrante no reutilizable", etc.



### Tabla compras_proveedor

    id_compra: identificador único de la compra.

    id_proveedor: clave foránea del proveedor.

    nro_factura: número o código de la factura.

    fecha: fecha de emisión de la factura.

    importe_total: suma total de la factura.

    metodo_pago: puede ser "efectivo", "transferencia", "tarjeta", etc. (opcional).



### Tabla detalle_compras_proveedor

    id_detalle: identificador del ítem.

    id_compra: clave foránea que se relaciona con compras.

    id_producto: producto comprado.

    cantidad: cantidad adquirida.

    precio_unitario: precio por unidad de ese producto.




### Tabla productos_venta

    id_producto_venta 

    nombre: Nombre del producto que se ofrece al cliente

    descripcion	Detalles adicionales 

    precio_venta Precio final al cliente

    unidad_venta Cómo se vende: "unidad", "porción", "vaso", etc.

    activo	BOOLEAN	Indica si está disponible en el menú




### Tabla recetas

    id_receta: identificador único de la receta.
    Clave primaria.

    id_producto_venta: referencia al producto que se elabora con esta receta (ej. milanesa con papas).
    Clave foránea a productos_venta(id_producto_venta).

    descripcion: texto opcional para describir preparación, pasos, aclaraciones, etc.



### Tabla detalle_receta

    id_detalle: identificador único del ingrediente dentro de la receta.
    Clave primaria.

    id_receta: identifica a qué receta pertenece ese ingrediente.
    Clave foránea a recetas(id_receta).

    id_producto: producto del inventario que se utiliza como ingrediente.
    Clave foránea a productos(id_producto).

    cantidad: cantidad utilizada para 1 unidad del producto de venta.

    unidad_medida: libre, por ejemplo: "g", "ml", "unidad", "cucharada", etc.



## Índice

[Diagrama Entidad-Relacion ER](./Captura%20de%20pantalla%202025-08-08%20a%20la(s)%2012.40.54.png)
[Inserción de datos](./insert_data.sql)

[Inserción de datos](./insert_data.sql)


## Contacto

- **Linkedin** [LinkedIn](https://www.linkedin.com/in/jorgegastonmartinez/)  
- **Correo** [Correo Electrónico](mailto:jgastonmartinez@gmail.com)