"""
Regularly collects raw data and generate dim and fact tables.
"""
import datetime
from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.utils.task_group import TaskGroup

postgres_conn_id='my_postgres_conn_id'

with DAG(
    dag_id="fact_order",
    start_date=datetime.datetime(2022, 12, 12),
    schedule_interval="@daily",
    catchup=False,
    template_searchpath="assets/sql/fact_order/",
) as dag:
    with TaskGroup(group_id='table_exports') as tg1:
        PostgresOperator(
            task_id="get_last_loaded_date",
            postgres_conn_id=postgres_conn_id,
            sql="get_last_loaded_date.sql"
            ),
        PostgresOperator(
            task_id="create_stg_table",
            postgres_conn_id=postgres_conn_id,
            sql="create_stg_table.sql"
        ),
        PostgresOperator(
            task_id="insert_fact_table",
            postgres_conn_id=postgres_conn_id,
            sql="insert_fact_table.sql"
        ),
        PostgresOperator(
            task_id="update_last_loaded_date",
            postgres_conn_id=postgres_conn_id,
            sql="update_last_loaded_date.sql"
        )