INSERT INTO silver.crm_prd_info

SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,                  -- extract cat_id: replace '-' with '_' to match px_cat_g1v2
    SUBSTRING(prd_key,7) AS prd_key,                                    -- extract remaining characters from prd_key
    prd_nm,
    COALESCE(prd_cost,0) AS prd_cost,                                   -- replace NULLS with 0
    CASE UPPER(TRIM(prd_line))                                         
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        ELSE 'n/a'
    END AS prd_line,                                                    -- map product line codes with descriptive values
    prd_start_dt,
    LEAD(prd_start_dt) OVER 
                            (PARTITION BY prd_key 
                            ORDER BY prd_start_dt) -1 AS prd_end_dt     -- calculate end date as one day before the next start date 
FROM
    bronze.crm_prd_info


