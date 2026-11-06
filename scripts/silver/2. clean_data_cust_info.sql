INSERT INTO silver.crm_cust_info

SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname) cst_firstname,                              -- remove unawanted spaces
    TRIM(cst_lastname)  cst_lastname,                               -- remove unawanted spaces
    CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
         WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
         ELSE 'n/a'                                                 -- handle missing values
    END AS cst_marital_status,                                      -- normalise & standardise 
    CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
         WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
         ELSE 'n/a'                                                 -- handle missing values
    END AS cst_gndr,                                                -- normalise & standardise 
    cst_create_date
FROM 
    (
    SELECT 
        *,
        ROW_NUMBER () OVER(
            PARTITION BY cst_id 
            ORDER BY cst_create_date DESC) AS flag_last             -- identify duplicates in promary key
    FROM 
        bronze.crm_cust_info
    ) new
WHERE
    flag_last = 1                                                   -- removes duplicates by only selecting most recent entry
