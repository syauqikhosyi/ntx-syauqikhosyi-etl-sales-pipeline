import pandas as pd

def extract_transactions(file_path):
    return pd.read_csv(file_path)

def extract_products(file_path):
    return pd.read_csv(file_path)