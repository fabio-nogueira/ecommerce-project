from datetime import datetime
import random
from airflow.decorators import dag, task
import pandas as pd
from faker import Faker
import faker_commerce
import logging as log


@dag(dag_id="get_orders", schedule_interval='@daily', start_date=datetime(2022, 12, 1), catchup=False)
def taskflow():
    @task
    def generate_customers():
        # Some european countries
        locales = ['de_DE', 'en_GB', 'es_ES', 'fi_FI', 'fr_FR', 'nl_BE', 'nl_NL', 'pl_PL']
        list_fake_data = []
        for locale in locales:
            fake = Faker(locale)
            fake_data = [{
                "first_name": fake.first_name(),
                "last_name": fake.last_name(),
                "birth_date": fake.date_of_birth().strftime("%d-%m-%Y"),
                "phone": fake.phone_number(),
                "street_address": fake.street_address(),
                "city": fake.city(),
                "postcode": fake.postcode(),
                "country": fake.current_country(),
                "country_code": fake.current_country_code()}
                for x in range(10)]

            for i in fake_data:
                list_fake_data.append(i)

        df_fake_data = pd.DataFrame(list_fake_data)
        df_fake_data.to_csv('customers.csv', na_rep='', index=False)
        log.info(str(df_fake_data))

    @task
    def generate_products():
        fake = Faker('en_US')
        fake.add_provider(faker_commerce.Provider)
        fake_data = [{
            "product_name": fake.ecommerce_name(),
            "price": random.randint(1, 1000)}
            for x in range(100)]
        df_fake_data = pd.DataFrame(fake_data)
        df_fake_data.to_csv('products.csv.csv', na_rep='', index=False)
        import os
        log.info('Stored in', str(os.path.dirname(os.path.abspath("products.csv.csv"))))
        log.info(str(df_fake_data))

    @task
    def generate_shippers():
        fake = Faker('en_US')
        fake_data = [{
            "shipper_name": fake.company(),
            "shipper_suffix": fake.company_suffix()}
            for x in range(100)]
        df_fake_data = pd.DataFrame(fake_data)
        df_fake_data.to_csv('shippers.csv', na_rep='', index=False)
        log.info(str(df_fake_data))

    @task
    def generate_orders():
        df_products = pd.read_csv('products.csv.csv')
        df_customers = pd.read_csv('customers.csv')
        df_shippers = pd.read_csv('shippers.csv')
        random_products = df_products.sample(5).reset_index(drop=True)
        random_customers = df_customers.sample(5).reset_index(drop=True)
        random_shippers = df_shippers.sample(5).reset_index(drop=True)
        fake = Faker()
        fake_date = [{
            "order_date": fake.date_this_decade()}
            for x in range(5)]
        df_fake_date = pd.DataFrame(fake_date)

        df_orders = pd.merge(random_products, random_customers, right_index=True, left_index=True) \
            .merge(random_shippers, left_index=True, right_index=True) \
            .merge(df_fake_date, left_index=True, right_index=True)

        df_orders.to_csv('orders.csv', na_rep='', index=False)
        log.info(str(df_orders))

    (generate_customers(), generate_products(), generate_shippers()) >> generate_orders()


taskflow()
