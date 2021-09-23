CREATE SCHEMA IF NOT EXISTS ecommerce;

DROP TABLE IF EXISTS ecommerce.customers;
DROP TABLE IF EXISTS ecommerce.orders;
DROP TABLE IF EXISTS ecommerce.order_reviews;
DROP TABLE IF EXISTS ecommerce.geolocation;
DROP TABLE IF EXISTS ecommerce.order_items;
DROP TABLE IF EXISTS ecommerce.order_payments;
DROP TABLE IF EXISTS ecommerce.products;
DROP TABLE IF EXISTS ecommerce.sellers;
DROP TABLE IF EXISTS ecommerce.product_category_name_translation;

CREATE TABLE ecommerce.customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix CHAR(5),
    customer_city TEXT,
    customer_state CHAR(2),
    CONSTRAINT PK_customers PRIMARY KEY (customer_id)
);
CREATE TABLE ecommerce.orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    CONSTRAINT PK_orders PRIMARY KEY (order_id)
);
CREATE TABLE ecommerce.order_reviews(
    review_id TEXT,
    order_id TEXT,
    review_score SMALLINT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
    /* CONSTRAINT PK_order_reviews PRIMARY KEY (review_id) */
);
CREATE TABLE ecommerce.geolocation (
    geolocation_zip_code_prefix CHAR(5),
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city TEXT,
    geolocation_state CHAR(2)
    /* CONSTRAINT PK_geolocation PRIMARY KEY (geolocation_zip_code_prefix) */
);
CREATE TABLE ecommerce.order_items (
  order_id TEXT,
  order_item_id INT,
  product_id TEXT,
  seller_id TEXT,
  shipping_limit_date TIMESTAMP,
  price NUMERIC,
  freight_value NUMERIC
  /* CONSTRAINT PK_order_items PRIMARY KEY (order_item_id) */
);
CREATE TABLE ecommerce.order_payments (
  /* payment_id SERIAL PRIMARY KEY, */
  order_id TEXT,
  payment_sequential INT,
  payment_type TEXT,
  payment_installments INT,
  payment_value NUMERIC
);
CREATE TABLE ecommerce.products (
  product_id TEXT,
  product_category_name TEXT,
  product_name_length INT,
  product_description_length INT,
  product_photos_qty INT,
  product_weight_g INT,
  product_length_cm INT,
  product_height_cm INT,
  product_width_cm INT,
  CONSTRAINT PK_products PRIMARY KEY (product_id)
);
CREATE TABLE ecommerce.sellers (
  seller_id TEXT,
  seller_zip_code_prefix CHAR(5),
  seller_city TEXT,
  seller_state CHAR(2),
  CONSTRAINT PK_sellers PRIMARY KEY (seller_id)
);
CREATE TABLE ecommerce.product_category_name_translation (
  product_category_name TEXT,
  product_category_name_english TEXT,
  CONSTRAINT PK_product_category_name_translation PRIMARY KEY (product_category_name)
);

-- Add foreign key constraints
/* ALTER TABLE ecommerce.customers
ADD CONSTRAINT FK_geolocation 
FOREIGN KEY (geolocation_zip_code_prefix) 
REFERENCES ecommerce.geolocation(geolocation_zip_code_prefix)
ON DELETE CASCADE; */

ALTER TABLE ecommerce.orders
ADD CONSTRAINT FK_customers
FOREIGN KEY (customer_id) 
REFERENCES ecommerce.customers(customer_id)
ON DELETE CASCADE;

ALTER TABLE ecommerce.order_reviews
ADD CONSTRAINT FK_orders
FOREIGN KEY (order_id) 
REFERENCES ecommerce.orders(order_id)
ON DELETE CASCADE;

ALTER TABLE ecommerce.order_items
ADD CONSTRAINT FK_orders
FOREIGN KEY (order_id) 
REFERENCES ecommerce.orders(order_id)
ON DELETE CASCADE;

/* ALTER TABLE ecommerce.order_items
ADD CONSTRAINT FK_products
FOREIGN KEY (product_id) 
REFERENCES ecommerce.products(product_id)
ON DELETE CASCADE; */

/* ALTER TABLE ecommerce.order_items
ADD CONSTRAINT FK_sellers
FOREIGN KEY (seller_id) 
REFERENCES ecommerce.sellers(seller_id)
ON DELETE CASCADE; */

ALTER TABLE ecommerce.order_payments
ADD CONSTRAINT FK_orders
FOREIGN KEY (order_id)
REFERENCES ecommerce.orders(order_id)
ON DELETE CASCADE;

/* ALTER TABLE ecommerce.products
ADD CONSTRAINT FK_product_category_name_translation 
FOREIGN KEY (product_category_name) 
REFERENCES ecommerce.product_category_name_translation(product_category_name)
ON DELETE CASCADE; */

/* ALTER TABLE ecommerce.sellers
ADD CONSTRAINT FK_geolocation 
FOREIGN KEY (seller_zip_code_prefix) 
REFERENCES ecommerce.geolocation(geolocation_zip_code_prefix)
ON DELETE CASCADE; */

COPY ecommerce.customers
FROM
  '/source-data/olist_customers_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.orders
FROM
  '/source-data/olist_orders_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.order_reviews
FROM
  '/source-data/olist_order_reviews_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.geolocation
FROM
  '/source-data/olist_geolocation_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.order_items
FROM
  '/source-data/olist_order_items_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.order_payments
FROM
  '/source-data/olist_order_payments_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.products
FROM
  '/source-data/olist_products_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.sellers
FROM
  '/source-data/olist_sellers_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.product_category_name_translation
FROM
  '/source-data/product_category_name_translation.csv' CSV DELIMITER ',' HEADER;