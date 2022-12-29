CREATE SCHEMA config;

DROP TABLE IF EXISTS config.last_loaded_date;
CREATE TABLE ecommerce.last_loaded_date
(
    dag_name VARCHAR(100),
    last_loaded_date   DATE
);

INSERT INTO ecommerce.last_loaded_date (dag_name) VALUES ('fact_order');