CREATE SCHEMA ecommerce;

DROP TABLE IF EXISTS ecommerce.dim_ecommerce;
CREATE TABLE ecommerce.dim_ecommerce
(
    dim_ecommerce_id SERIAL PRIMARY KEY NOT NULL,
    ecommerce_id   INT NOT NULL,
    ecommerce_name VARCHAR(30),
    row_created      timestamp default getdate() not null,
    row_last_updated timestamp default getdate() not null
);

DROP TABLE IF EXISTS ecommerce.dim_customers;
CREATE TABLE ecommerce.dim_customers
(
    dim_customer_id SERIAL NOT NULL PRIMARY KEY,
    customer_id     INT NOT NULL,
    first_name      VARCHAR(30),
    last_name       VARCHAR(30),
    birth_date      DATE,
    phone           VARCHAR(15),
    street_address  VARCHAR(60),
    city            VARCHAR(30),
    postcode        VARCHAR(20),
    country         VARCHAR(30),
    country_code    VARCHAR(15),
    row_created      timestamp default getdate() not null,
    row_last_updated timestamp default getdate() not null
);

DROP TABLE IF EXISTS ecommerce.dim_order_statuses;
CREATE TABLE ecommerce.dim_order_statuses
(
    dim_order_status_id SERIAL PRIMARY KEY NOT NULL,
    order_status_id   INT NOT NULL,
    order_status_name VARCHAR(30),
    row_created      timestamp default getdate() not null,
    row_last_updated timestamp default getdate() not null
);

DROP TABLE IF EXISTS ecommerce.dim_orderline;
CREATE TABLE ecommerce.dim_orderline
(
    dim_orderline_id SERIAL PRIMARY KEY NOT NULL,
    product_id  INT NOT NULL,
    sales_price BIGINT,
    order_id    INT NOT NULL,
    quantity    INT,
    order_date  DATE,
    row_created      timestamp default getdate() not null,
    row_last_updated timestamp default getdate() not null
);

DROP TABLE IF EXISTS ecommerce.dim_order;
CREATE TABLE ecommerce.dim_order
(
    dim_order_id SERIAL PRIMARY KEY NOT NULL,
    ecommerce_id      INT NOT NULL,
    order_id          INT NOT NULL,
    order_statuses_id INT NOT NULL,
    customer_id       INT NOT NULL,
    row_created      timestamp default getdate() not null,
    row_last_updated timestamp default getdate() not null
);

DROP TABLE IF EXISTS ecommerce.fact_order;
CREATE TABLE ecommerce.fact_order
(
    dim_order_id          INT PRIMARY KEY NOT NULL,
    dim_ecommerce_id      INT NOT NULL,
    dim_order_statuses_id INT NOT NULL,
    dim_customer_id       INT NOT NULL,
    row_created      timestamp default getdate() not null,
    row_last_updated timestamp default getdate() not null
)