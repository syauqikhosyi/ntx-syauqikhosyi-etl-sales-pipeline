from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
from etl.extract import extract_transactions, extract_products
from etl.transform import transform_data
from etl.load import load_to_csv

def extract():
    transactions = extract_transactions('/opt/airflow/data/transactions.csv')
    products = extract_products('/opt/airflow/data/products.csv')
    return {'transactions': transactions, 'products': products}

def transform(ti):
    data = ti.xcom_pull(task_ids='extract_data')
    transactions = data['transactions']
    products = data['products']
    results = transform_data(transactions, products)
    return results

def load(ti):
    dataframes = ti.xcom_pull(task_ids='transform_data')
    load_to_csv(dataframes)

default_args = {
    'start_date': datetime(2024, 1, 1),
    'retries': 1,
}

with DAG('etl_pipeline',
         default_args=default_args,
         schedule_interval='@daily',
         catchup=False) as dag:

    extract_task = PythonOperator(
        task_id='extract_data',
        python_callable=extract
    )

    transform_task = PythonOperator(
        task_id='transform_data',
        python_callable=transform
    )

    load_task = PythonOperator(
        task_id='load_data',
        python_callable=load
    )

    extract_task >> transform_task >> load_task
