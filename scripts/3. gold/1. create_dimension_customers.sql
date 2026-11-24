/* 
* General Principles
    - Naming convention: use snake_case, with lowercase letters and underscores to seperate words.
    - Language: use English for all names.
    - Avoid Reserved Words: do not use SQL reserved words as object nsames. 
*/

CREATE view gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,    -- surrogate key: system generated unique identifier assigend to each record in the table
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    la.cntry AS country,
    ci.cst_marital_status AS martial_status,
    CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr         -- CRM is the Master for gender info
         ELSE COALESCE(ca.gen, 'n/a')                       -- fallback to ERP data
    END AS gender,
    ca.bdate AS birth_date,
    ci.cst_create_date AS create_date
FROM
    silver.crm_cust_info AS ci
LEFT JOIN
    silver.erp_cust_az12 AS ca
        ON ci.cst_key = ca.cid
LEFT JOIN
    silver.erp_loc_a101 AS la
        ON ci.cst_key = la.cid