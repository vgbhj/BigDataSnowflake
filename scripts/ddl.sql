CREATE TABLE mock_data (
    id INTEGER,
    customer_first_name VARCHAR(255),
    customer_last_name VARCHAR(255),
    customer_age INTEGER,
    customer_email VARCHAR(255),
    customer_country VARCHAR(255),
    customer_postal_code VARCHAR(255),
    customer_pet_type VARCHAR(255),
    customer_pet_name VARCHAR(255),
    customer_pet_breed VARCHAR(255),
    seller_first_name VARCHAR(255),
    seller_last_name VARCHAR(255),
    seller_email VARCHAR(255),
    seller_country VARCHAR(255),
    seller_postal_code VARCHAR(255),
    product_name VARCHAR(255),
    product_category VARCHAR(255),
    product_price NUMERIC,
    product_quantity INTEGER,
    sale_date VARCHAR(10),
    sale_customer_id INTEGER,
    sale_seller_id INTEGER,
    sale_product_id INTEGER,
    sale_quantity INTEGER,
    sale_total_price NUMERIC,
    store_name VARCHAR(255),
    store_location VARCHAR(255),
    store_city VARCHAR(255),
    store_state VARCHAR(255),
    store_country VARCHAR(255),
    store_phone VARCHAR(255),
    store_email VARCHAR(255),
    pet_category VARCHAR(255),
    product_weight NUMERIC,
    product_color VARCHAR(255),
    product_size VARCHAR(255),
    product_brand VARCHAR(255),
    product_material VARCHAR(255),
    product_description TEXT,
    product_rating NUMERIC,
    product_reviews INTEGER,
    product_release_date VARCHAR(10),
    product_expiry_date VARCHAR(10),
    supplier_name VARCHAR(255),
    supplier_contact VARCHAR(255),
    supplier_email VARCHAR(255),
    supplier_phone VARCHAR(255),
    supplier_address VARCHAR(255),
    supplier_city VARCHAR(255),
    supplier_country VARCHAR(255)
);

CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    age INTEGER,
    email VARCHAR(255),
    country VARCHAR(255),
    postal_code VARCHAR(255),
    pet_type VARCHAR(255),
    pet_name VARCHAR(255),
    pet_breed VARCHAR(255)
);

CREATE TABLE dim_seller (
    seller_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    country VARCHAR(255),
    postal_code VARCHAR(255)
);

CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(255),
    pet_category VARCHAR(255),
    weight NUMERIC,
    color VARCHAR(255),
    size VARCHAR(255),
    brand VARCHAR(255),
    material VARCHAR(255),
    description TEXT,
    rating NUMERIC,
    reviews INTEGER,
    release_date DATE,
    expiry_date DATE,
    quantity INTEGER
);

CREATE TABLE dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    contact VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255)
);

CREATE TABLE fact_sales (
    sale_id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES dim_customer(customer_id),
    seller_id INTEGER REFERENCES dim_seller(seller_id),
    product_id INTEGER REFERENCES dim_product(product_id),
    store_id INTEGER REFERENCES dim_store(store_id),
    supplier_id INTEGER REFERENCES dim_supplier(supplier_id),
    sale_date DATE,
    sale_quantity INTEGER,
    sale_total_price NUMERIC
);