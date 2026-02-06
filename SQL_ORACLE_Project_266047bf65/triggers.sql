CREATE OR REPLACE TRIGGER trg_descontar_existencias
BEFORE INSERT ON detallepedido
FOR EACH ROW
BEGIN
    UPDATE productos SET existencia = existencia - :new.cantidad WHERE id_producto = :new.id_producto;
END;

CREATE OR REPLACE TRIGGER trg_verificar_precio_venta
BEFORE INSERT OR UPDATE ON productos
FOR EACH ROW
BEGIN
    IF :new.precio_venta < 1.1 * :new.precio_proveedor THEN
        RAISE_APPLICATION_ERROR(-20002, 'El precio de venta debe ser al menos un 10% superior al precio del proveedor.');
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_verificar_inventario
BEFORE INSERT ON detallepedido
FOR EACH ROW
DECLARE
    v_existencia NUMBER;
BEGIN
    SELECT existencia INTO v_existencia FROM productos WHERE id_producto = :new.id_producto;
    
    IF v_existencia < :new.cantidad THEN
        RAISE_APPLICATION_ERROR(-20003, 'No hay suficiente inventario para realizar el pedido.');
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_auditar_clientes
AFTER INSERT OR UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (tabla, accion, id_registro, fecha)
    VALUES ('clientes', CASE WHEN :new.id_cliente = :old.id_cliente THEN 'UPDATE' ELSE 'INSERT' END, :new.id_cliente, SYSDATE);
END;

CREATE OR REPLACE TRIGGER trg_auditar_pedidos
AFTER INSERT OR UPDATE ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (tabla, accion, id_registro, fecha)
    VALUES ('pedidos', CASE WHEN :new.id_pedido = :old.id_pedido THEN 'UPDATE' ELSE 'INSERT' END, :new.id_pedido, SYSDATE);
END;

CREATE OR REPLACE TRIGGER trg_registrar_valor_total
AFTER INSERT ON detallepedido
FOR EACH ROW
BEGIN
    UPDATE pedidos SET valortotal = (SELECT SUM(cantidad * precio_unitario) FROM detallepedido WHERE id_pedido = :new.id_pedido)
    WHERE id_pedido = :new.id_pedido;
END;