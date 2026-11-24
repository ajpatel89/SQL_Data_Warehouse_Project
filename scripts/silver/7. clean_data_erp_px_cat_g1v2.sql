INSERT INTO silver.erp_px_cat_g1v2

SELECT
    id,                     -- no issues, matches cat_id in silver.crm_prd_info
    cat,                    -- no unawated spaces
    subcat,                 -- no unawated spaces
    maintenance             -- no unawated spaces
FROM
    bronze.erp_px_cat_g1v2