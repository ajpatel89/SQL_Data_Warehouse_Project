INSERT INTO silver.erp_cust_az12

SELECT
    CASE
        WHEN cid LIKE 'NAS%'
        THEN SUBSTRING(cid, 4, LENGTH(cid))
        ELSE cid
    END cid,                                                    -- Removed 'NAS' prefix if present                          
    CASE
        WHEN bdate > CURRENT_DATE THEN NULL
        ELSE bdate
    END bdate,                                                  -- Set future birthdates to NULL
    CASE
        WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
        ELSE 'n/a'
    END AS gen                                                  -- Normalise gender values and handle unknown values
FROM
    bronze.erp_cust_az12