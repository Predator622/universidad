from sqlalchemy import create_engine, text

def update_inventory(product_id, new_quantity):
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("EXEC sp_update_inventory(:product_id, :new_quantity)")
        result = connection.execute(query, product_id=product_id, new_quantity=new_quantity)

def insert_order_detail(order_id, product_id, quantity, unit_price):
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("EXEC sp_insert_order_detail(:order_id, :product_id, :quantity, :unit_price)")
        result = connection.execute(query, order_id=order_id, product_id=product_id, quantity=quantity, unit_price=unit_price)

def most_sold_product_range():
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("SELECT * FROM sp_most_sold_product_range()")
        result = connection.execute(query)
        
        return [row for row in result]

def register_payment_method(client_code):
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("EXEC sp_register_payment_method(:client_code)")
        result = connection.execute(query, client_code=client_code)

def update_order_total(order_id):
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("EXEC sp_update_order_total(:order_id)")
        result = connection.execute(query, order_id=order_id)

def update_all_orders_totals():
    engine = create_engine('oracle+cx_oracle://username:password@hostname:port/service_name')
    
    with engine.connect() as connection:
        query = text("EXEC sp_update_all_orders_totals()")
        result = connection.execute(query)