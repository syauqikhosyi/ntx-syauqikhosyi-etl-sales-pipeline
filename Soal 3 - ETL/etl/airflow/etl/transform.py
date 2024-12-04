import pandas as pd

def transform_data(transactions, products):
    # Merge data
    merged_df = pd.merge(transactions, products, on='product_id', how='left')

    # Total revenue per product
    merged_df['revenue'] = merged_df['quantity'] * merged_df['total_price']
    revenue_per_product = merged_df.groupby('product_id').agg({'revenue': 'sum'})

    # Sales performance by channel
    sales_by_channel = merged_df.groupby('sales_channel').agg({'revenue': 'sum'})

    # Customer purchase frequency
    purchase_frequency = merged_df.groupby('customer_id').agg({'transaction_id': 'count'})

    # Inventory valuation
    merged_df['inventory_valuation'] = merged_df['quantity'] * merged_df['base_price']
    inventory_valuation = merged_df.groupby('product_id').agg({'inventory_valuation': 'sum'})

    return {
        'merged': merged_df,
        'revenue_per_product': revenue_per_product,
        'sales_by_channel': sales_by_channel,
        'purchase_frequency': purchase_frequency,
        'inventory_valuation': inventory_valuation,
    }
