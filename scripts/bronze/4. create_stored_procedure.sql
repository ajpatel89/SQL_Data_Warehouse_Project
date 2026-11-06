/* 
Here is a summary of the key benefits of creating a stored procedure for your data warehouse pipeline:

* Encapsulation & Modularity: Combines multi-step workflows (truncating tables, loading files, logging) into a single, cohesive unit triggered by one command (`CALL`).
* Centralised Maintenance: Changes to file paths, schema logic, or table additions only need to be updated in one place on the database server.
* Optimised Performance: Keeps execution logic entirely server-side, reducing unnecessary network round-trips between your client environment and the database engine.
* Error Handling & Control: Enables robust transaction control, structured exception blocks (`BEGIN ... EXCEPTION`), and detailed error capture (`SQLSTATE`, `SQLERRM`).
* Enhanced Security: Allows you to restrict direct table access by granting users and applications permission *only* to execute the procedure rather than modifying raw data directly.
 */



CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    v_start_time TIMESTAMP;
    v_end_time TIMESTAMP;
    v_duration INTERVAL;
    v_total_start TIMESTAMP;
BEGIN
    v_total_start := clock_timestamp();
    
    RAISE NOTICE '==================================================';
    RAISE NOTICE 'Starting Bronze Layer Load Process...';
    RAISE NOTICE '==================================================';

    -- 1. CRM Customer Info
    BEGIN
        v_start_time := clock_timestamp();
        RAISE NOTICE '-> Truncating and loading bronze.crm_cust_info...';
        TRUNCATE TABLE bronze.crm_cust_info;
        EXECUTE format('COPY bronze.crm_cust_info FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','', ENCODING ''UTF8'')', 
                       '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_crm/cust_info.csv');
        v_end_time := clock_timestamp();
        v_duration := v_end_time - v_start_time;
        RAISE NOTICE '   Completed bronze.crm_cust_info in %', v_duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'ERROR in bronze.crm_cust_info -> Code: %, Message: %', SQLSTATE, SQLERRM;
    END;

    -- 2. CRM Product Info
    BEGIN
        v_start_time := clock_timestamp();
        RAISE NOTICE '-> Truncating and loading bronze.crm_prd_info...';
        TRUNCATE TABLE bronze.crm_prd_info;
        EXECUTE format('COPY bronze.crm_prd_info FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','', ENCODING ''UTF8'')', 
                       '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_crm/prd_info.csv');
        v_end_time := clock_timestamp();
        v_duration := v_end_time - v_start_time;
        RAISE NOTICE '   Completed bronze.crm_prd_info in %', v_duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'ERROR in bronze.crm_prd_info -> Code: %, Message: %', SQLSTATE, SQLERRM;
    END;

    -- 3. CRM Sales Details
    BEGIN
        v_start_time := clock_timestamp();
        RAISE NOTICE '-> Truncating and loading bronze.crm_sales_details...';
        TRUNCATE TABLE bronze.crm_sales_details;
        EXECUTE format('COPY bronze.crm_sales_details FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','', ENCODING ''UTF8'')', 
                       '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_crm/sales_details.csv');
        v_end_time := clock_timestamp();
        v_duration := v_end_time - v_start_time;
        RAISE NOTICE '   Completed bronze.crm_sales_details in %', v_duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'ERROR in bronze.crm_sales_details -> Code: %, Message: %', SQLSTATE, SQLERRM;
    END;

    -- 4. ERP Customer AZ12
    BEGIN
        v_start_time := clock_timestamp();
        RAISE NOTICE '-> Truncating and loading bronze.erp_cust_az12...';
        TRUNCATE TABLE bronze.erp_cust_az12;
        EXECUTE format('COPY bronze.erp_cust_az12 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','', ENCODING ''UTF8'')', 
                       '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv');
        v_end_time := clock_timestamp();
        v_duration := v_end_time - v_start_time;
        RAISE NOTICE '   Completed bronze.erp_cust_az12 in %', v_duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'ERROR in bronze.erp_cust_az12 -> Code: %, Message: %', SQLSTATE, SQLERRM;
    END;

    -- 5. ERP Location A101
    BEGIN
        v_start_time := clock_timestamp();
        RAISE NOTICE '-> Truncating and loading bronze.erp_loc_a101...';
        TRUNCATE TABLE bronze.erp_loc_a101;
        EXECUTE format('COPY bronze.erp_loc_a101 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','', ENCODING ''UTF8'')', 
                       '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv');
        v_end_time := clock_timestamp();
        v_duration := v_end_time - v_start_time;
        RAISE NOTICE '   Completed bronze.erp_loc_a101 in %', v_duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'ERROR in bronze.erp_loc_a101 -> Code: %, Message: %', SQLSTATE, SQLERRM;
    END;

    -- 6. ERP Product Category G1V2
    BEGIN
        v_start_time := clock_timestamp();
        RAISE NOTICE '-> Truncating and loading bronze.erp_px_cat_g1v2...';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        EXECUTE format('COPY bronze.erp_px_cat_g1v2 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','', ENCODING ''UTF8'')', 
                       '/Users/ajaypatel/Documents/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv');
        v_end_time := clock_timestamp();
        v_duration := v_end_time - v_start_time;
        RAISE NOTICE '   Completed bronze.erp_px_cat_g1v2 in %', v_duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'ERROR in bronze.erp_px_cat_g1v2 -> Code: %, Message: %', SQLSTATE, SQLERRM;
    END;

    RAISE NOTICE '==================================================';
    RAISE NOTICE 'Bronze Layer Load Completed Successfully in %', clock_timestamp() - v_total_start;
    RAISE NOTICE '==================================================';
END;
$$;


CALL bronze.load_bronze();