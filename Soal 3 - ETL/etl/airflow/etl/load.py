import os

def load_to_csv(dataframes, output_dir='output'):
    os.makedirs(output_dir, exist_ok=True)
    for name, df in dataframes.items():
        df.to_csv(os.path.join(output_dir, f"{name}.csv"))