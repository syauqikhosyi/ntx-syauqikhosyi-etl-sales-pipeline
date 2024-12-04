# etl-sales-pipeline
A scalable ETL pipeline to process e-commerce sales data by extracting from multiple sources (CSV), transforming the data into meaningful insights, and loading it into a data warehouse.

---

## Language And Data Platform
* For managing the data pipeline and data container, writer use `Docker`
* For orchestrate data pipeline and data manipulation, writer use `Airflow`
* For write the scripts, writer use `Python`
---

## Application
* For write the scripts and manage file management, writer use `VSCode`
* For manage data container, writer use `Docker Desktop`
---

## File Management Setup
1. **etl-sales-pipeline** folder's contain:
    * `data`: Sales and product data in CSV format.
    * `etl`: Folder for implementing the ETL pipeline with the following subfolders:
    * `extract.py`: Scripts to extract data from CSV files.
    * `transform.py`: Scripts to clean, normalize, and calculate derived metrics.
    * `load.py`: Scripts to load transformed data into CSV files.
    * `dags`: Folder containing the Airflow DAG to orchestrate the ETL pipeline.
    * `config`: Configuration files for Airflow (currently empty).
    * `logs`: Logs generated during the pipeline execution.
    * `Dockerfile`: File to set up dependencies for Airflow.
    * `docker-compose.yml`: File to run the Airflow instance in Docker.
    * `requirements.txt`: File listing all Python dependencies.

## Docker Setup
1. Install Docker Desktop and Open `Docker Desktop Installer.exe`
2. When prompted, ensure the Use WSL 2 instead of Hyper-V option on the Configuration page is selected or not depending on your choice of backend
3. Follow the instructions on the installation wizard to authorize the installer and proceed with the install
4. When the installation is successful, select Close to complete the installation process
---

## Airflow Setup and Run
1. Install airflow for Airflow in this command:
```
pip install apache-airflow
```
2. Create `docker-compose.yaml`, `Dockerfile`, and `requirements.txt` files base on folder **`etl-sales-pipeline/etl/airflow`**
3. To run airflow, you can use this command in terminal
```
docker-compose up -d
```

4. To close Airflow, you can use this command in terminal
```
docker-compose down
```
---

## Pipeline Components and Execution
* Extract: Data is extracted from transactions.csv and products.csv using extract.py.
* Transform: Transformations include:
Data cleaning and normalization.
Calculating metrics: total revenue, sales performance, customer frequency, and inventory valuation.
* Load: Transformed data is loaded into the PostgreSQL database.
Orchestration: The Airflow DAG in the dags folder orchestrates the ETL process.

---

## Project Overview
This project demonstrates the following:

* Data cleaning and transformation using Python (pandas).
* Workflow orchestration using Apache Airflow.
* Modular code design for scalability and maintainability.
* Dockerized solution for seamless deployment.

For further instructions or issues, feel free to contact the repository maintainer.

## Additional Resources
This repo has several reference sources for working on it:
* [Hands On Apache Airflow in Data Engineer](https://github.com/saipulrx/de-basic-class-airflow)
* [Getting started with Airflow in 10 mins](https://marclamberti.com/blog/getting-started-airflow/)
* [Simple data pipeline](https://github.com/goFrendiAsgard/platform-data)