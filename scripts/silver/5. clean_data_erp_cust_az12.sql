SELECT
    CASE
        WHEN cid LIKE 'NAS%'
        THEN SUBSTRING(cid, 4, LENGTH(cid))
        ELSE cid
    END cid,
    bdate,
    gen
FROM
    bronze.erp_cust_az12