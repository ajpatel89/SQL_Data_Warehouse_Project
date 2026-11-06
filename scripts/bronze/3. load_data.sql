COPY bronze.crm_cust_info
FROM '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY bronze.crm_prd_info
FROM '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY bronze.crm_sales_details
FROM '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY bronze.erp_cust_az12
FROM '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY bronze.erp_loc_a101
FROM '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY bronze.erp_px_cat_g1v2
FROM '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');