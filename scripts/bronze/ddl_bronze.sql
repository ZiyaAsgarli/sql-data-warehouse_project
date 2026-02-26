/*
===============================================================================
Bronze Layer üçün DDL Script-i (Create Tables)
===============================================================================
Script-in Məqsədi:
    Bu script 'bronze' schema-sı daxilində mənbə sistemlərindən (CRM və ERP) 
    gələn xam (raw) dataları saxlamaq üçün lazımi cədvəlləri (tables) yaradır.
    Hər bir 'CREATE TABLE' əmrindən əvvəl cədvəlin mövcud olub-olmadığı yoxlanılır 
    və əgər varsa, köhnə cədvəl silinir (drop edilir).

XƏBƏRDARLIQ (WARNING):
    Bu script-i işlətmək mövcud cədvəlləri drop edəcəyi üçün içindəki bütün xam datalar 
    qalıcı olaraq silinəcək. Bu script əsasən yeni data yüklənməsindən (Full Load) əvvəl 
    strukturu sıfırlamaq və ya ilk dəfə qurmaq üçün istifadə edilməlidir. Ehtiyatla davam edin.
===============================================================================
*/

-- ============================================================================
-- CRM Sistemindən Gələn Datalar üçün Cədvəllər
-- ============================================================================

-- Müştəri məlumatları cədvəli (Customer Info)
IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_martial_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

-- Məhsul məlumatları cədvəli (Product Info)
IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);

-- Satış detalları cədvəli (Sales Details)
IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- ============================================================================
-- ERP Sistemindən Gələn Datalar üçün Cədvəllər
-- ============================================================================

-- Ünvan/Lokasiya məlumatları cədvəli (Location/Country Info)
IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);

-- ERP üzrə müştəri məlumatları cədvəli (ERP Customer Info)
IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR (50)
);

-- Məhsul kateqoriyaları cədvəli (Product Categories)
IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
