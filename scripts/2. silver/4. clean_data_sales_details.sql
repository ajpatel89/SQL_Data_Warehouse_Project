/* 
Data consistency between: Sales, Quantity & Price
* Business Rules: 
     * Sales = Quantity * Price
     * Values must not be NULL, Zero or Negative
 */

TRUNCATE TABLE silver.crm_sales_details

INSERT INTO silver.crm_sales_details

SELECT
    sls_ord_num,                                                                             -- no issues
    sls_prd_key,                                                                             -- no issues
    sls_cust_id,                                                                             -- no issues
CASE 
    WHEN sls_order_dt = 0 OR LENGTH(sls_order_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_order_dt::TEXT, 'YYYYMMDD')
END AS sls_order_dt,                                                                         -- Cleaned order date
CASE 
    WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_ship_dt::TEXT, 'YYYYMMDD')
END AS sls_ship_dt,                                                                          -- Cleaned ship date
CASE 
    WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_due_dt::TEXT, 'YYYYMMDD')
END AS sls_due_dt,                                                                           -- Cleaned ship date
CASE 
    WHEN sls_sales IS NULL or sls_sales <= 0 or sls_sales != sls_quantity * ABS(sls_price)
    THEN sls_quantity * sls_price
    ELSE sls_sales
END AS sls_sales,                                                                            -- Recalculate sales if original value is missing or incorrect
    sls_quantity,
CASE 
    WHEN sls_price IS NULL OR sls_price <= 0 
    THEN sls_sales / NULLIF(sls_quantity, 0)
    ELSE sls_price
END AS sls_price                                                                             -- Derive price if original value is invalid
FROM
    bronze.crm_sales_details;