COPY mock_data FROM '/data/MOCK_DATA (1).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (2).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (3).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (4).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (5).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (6).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (7).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (8).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (9).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (10).csv' DELIMITER ',' CSV HEADER;

INSERT INTO dim_customer (
    first_name, last_name, age, email, country, postal_code, 
    pet_type, pet_name, pet_breed
)
SELECT DISTINCT 
    customer_first_name, customer_last_name, customer_age, 
    customer_email, customer_country, customer_postal_code, 
    customer_pet_type, customer_pet_name, customer_pet_breed
FROM mock_data;

INSERT INTO dim_seller (
    first_name, last_name, email, country, postal_code
)
SELECT DISTINCT 
    seller_first_name, seller_last_name, seller_email, 
    seller_country, seller_postal_code
FROM mock_data;

INSERT INTO dim_store (
    name, location, city, state, country, phone, email
)
SELECT DISTINCT 
    store_name, store_location, store_city, store_state, 
    store_country, store_phone, store_email
FROM mock_data;

INSERT INTO dim_product (
    name, category, pet_category, weight, color, size, brand, 
    material, description, rating, reviews, release_date, 
    expiry_date, quantity
)
SELECT DISTINCT 
    product_name, product_category, pet_category, product_weight, 
    product_color, product_size, product_brand, product_material, 
    product_description, product_rating, product_reviews,
    TO_DATE(product_release_date, 'MM/DD/YYYY'),
    TO_DATE(product_expiry_date, 'MM/DD/YYYY'),
    product_quantity
FROM mock_data;

INSERT INTO dim_supplier (
    name, contact, email, phone, address, city, country
)
SELECT DISTINCT 
    supplier_name, supplier_contact, supplier_email, 
    supplier_phone, supplier_address, supplier_city, 
    supplier_country
FROM mock_data;

INSERT INTO fact_sales (
    sale_id, customer_id, seller_id, product_id, store_id, 
    supplier_id, sale_date, sale_quantity, sale_total_price
)
SELECT 
    m.id,
    c.customer_id,
    s.seller_id,
    p.product_id,
    st.store_id,
    sp.supplier_id,
    TO_DATE(m.sale_date, 'MM/DD/YYYY'),
    m.sale_quantity,
    m.sale_total_price
FROM mock_data m
JOIN dim_customer c ON m.customer_email = c.email
JOIN dim_seller s ON m.seller_email = s.email
JOIN dim_store st ON m.store_email = st.email
JOIN dim_product p ON m.product_name = p.name
JOIN dim_supplier sp ON m.supplier_email = sp.email;