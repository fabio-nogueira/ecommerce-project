CREATE SCHEMA raw_data;

DROP TABLE IF EXISTS raw_data.products;
CREATE TABLE raw_data.products
(
    product_id    VARCHAR(15) NOT NULL,
    product_name  VARCHAR(50) NOT NULL,
    url           VARCHAR(300),
    listing_price INT,
    sale_price    INT,
    discount      NUMERIC(19, 4) DEFAULT 0.0000,
    brand         VARCHAR(20),
    description   VARCHAR(500),
    rating        DOUBLE PRECISION,
    reviews       INT,
    images        VARCHAR(500)
);

DROP TABLE IF EXISTS raw_data.raw_data;
CREATE TABLE raw_data.raw_data
(
    raw_data_id   INT NOT NULL,
    raw_data_name VARCHAR(30)
);


DROP TABLE IF EXISTS raw_data.customers;
CREATE TABLE raw_data.customers
(
    customer_id    INT NOT NULL,
    first_name     VARCHAR(30),
    last_name      VARCHAR(30),
    birth_date     DATE,
    phone          VARCHAR(15),
    street_address VARCHAR(60),
    city           VARCHAR(30),
    postcode       VARCHAR(20),
    country        VARCHAR(30),
    country_code   VARCHAR(15)
);


DROP TABLE IF EXISTS raw_data.order_statuses;
CREATE TABLE raw_data.order_statuses
(
    order_status_id   INT NOT NULL,
    order_status_name VARCHAR(30)
);


DROP TABLE IF EXISTS raw_data.orderline;
CREATE TABLE raw_data.orderline
(
    product_id  INT NOT NULL,
    sales_price BIGINT,
    order_id    INT NOT NULL,
    quantity    INT,
    order_date  DATE
);


DROP TABLE IF EXISTS raw_data.order;
CREATE TABLE raw_data.order
(
    raw_data_id      INT NOT NULL,
    order_id          INT NOT NULL,
    order_statuses_id INT NOT NULL,
    customer_id       INT NOT NULL
)
