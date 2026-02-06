CREATE TABLE clientes (
    id_cliente NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    -- otros campos relevantes
);

CREATE TABLE productos (
    id_producto NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    precio_proveedor NUMBER,
    precio_venta NUMBER,
    existencia NUMBER,
    -- otros campos relevantes
);

CREATE TABLE pedidos (
    id_pedido NUMBER PRIMARY KEY,
    id_cliente NUMBER,
    fecha_pedido DATE,
    valortotal NUMBER,  -- nuevo atributo
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detallepedido (
    id_detalle NUMBER PRIMARY KEY,
    id_pedido NUMBER,
    id_producto NUMBER,
    cantidad NUMBER,
    precio_unitario NUMBER,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);