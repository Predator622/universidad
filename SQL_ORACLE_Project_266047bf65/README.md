# README

## Resumen

Este proyecto implementa una base de datos Oracle con un esquema inicial, procedimientos almacenados y funciones en Python utilizando SQLAlchemy, además de disparadores para garantizar la integridad y auditoría de los datos.

### Arquitectura

- **database_schema.sql**: Define el esquema inicial de la base de datos.
- **procedures_and_functions.py**: Contiene las implementaciones de procedimientos almacenados y funciones en Python que interactúan con Oracle mediante SQLAlchemy.
- **triggers.sql**: Script SQL para definir los disparadores necesarios.

### Flujo

1. Se crea el esquema inicial utilizando `database_schema.sql`.
2. Los procedimientos almacenados y funciones se implementan en `procedures_and_functions.py` para realizar operaciones específicas como la actualización del inventario, inserción de detalles de pedidos, etc.
3. Los disparadores se definen en `triggers.sql` para manejar eventos como descontar existencias al hacer un pedido o registrar auditoría.

### Validaciones y Casos Bordes

- **Validación de Precios**: Cada vez que se actualiza el precio de venta, se verifica que este sea al menos un 10% superior al precio del proveedor.
- **Inventario Controlado**: Se evita realizar pedidos si las existencias son insuficientes.

### Ejemplos de Implementación

#### Procedimiento Almacenado para Actualizar Inventario
# procedures_and_functions.py
from sqlalchemy import create_engine, text

def update_inventory(product_id, new_quantity):
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("EXEC sp_update_inventory(:product_id, :new_quantity)")
        result = connection.execute(query, product_id=product_id, new_quantity=new_quantity)

#### Disparador para Descontar Existencias
-- triggers.sql
CREATE OR REPLACE TRIGGER trg_descontar_existencias
BEFORE INSERT ON detallepedido
FOR EACH ROW
BEGIN
    UPDATE producto SET existencia = existencia - :new.cantidad WHERE id_producto = :new.id_producto;
END;

#### Función para Gama de Productos Más Vendidos
# procedures_and_functions.py
def most_sold_product_range():
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("SELECT * FROM sp_most_sold_product_range()")
        result = connection.execute(query)
        
        return [row for row in result]

### Cómo Validé

Se realizaron pruebas de humo para verificar que los procedimientos almacenados y disparadores funcionan correctamente, asegurando la integridad y consistencia de los datos.

- Ejecución manual de cada procedimiento almacenado.
- Pruebas unitarias en Python para las funciones que interactúan con Oracle.
- Simulación de eventos que activan los disparadores para verificar su correcto funcionamiento.