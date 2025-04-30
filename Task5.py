
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load datasets
orders_df = pd.read_csv('customer_orders.csv')
orders_df['order_date'] = pd.to_datetime(orders_df['order_date'])

# Create cohort-based fields
orders_df['order_month'] = orders_df['order_date'].dt.to_period('M')
orders_df['cohort_month'] = orders_df.groupby('customer_id')['order_date'].transform('min').dt.to_period('M')

# Calculate cohort index
orders_df['cohort_index'] = (
    (orders_df['order_month'].dt.year - orders_df['cohort_month'].dt.year) * 12 +
    (orders_df['order_month'].dt.month - orders_df['cohort_month'].dt.month) + 1
)

# Group and reshape retention matrix
cohort_data = orders_df.groupby(['cohort_month', 'cohort_index'])['customer_id'].nunique().unstack(1)
cohort_size = cohort_data.iloc[:, 0]
retention = cohort_data.divide(cohort_size, axis=0).round(3) * 100

# Plot retention heatmap
plt.figure(figsize=(18, 8))
sns.heatmap(retention, annot=True, fmt=".1f", cmap="YlGnBu", cbar_kws={'label': 'Retention (%)'})
plt.title('Customer Retention by Monthly Cohort', fontsize=16)
plt.xlabel('Months Since First Purchase')
plt.ylabel('Cohort Month')
plt.tight_layout()
plt.savefig('visualizations/customer_retention_heatmap.png')
plt.show()
