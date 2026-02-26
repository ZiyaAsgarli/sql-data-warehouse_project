/*
===============================================================================
Stored Procedure: Yüklənmə Prosesi (Bronze Layer Data Loading)
===============================================================================
Script-in Məqsədi:
    Bu Stored Procedure, CRM və ERP sistemlərindən gələn CSV formatındakı xam (raw) 
    dataları Data Warehouse-un 'bronze' schema-sındakı cədvəllərə yükləmək üçün 
    dizayn edilib. Proses 'Truncate and Load' (Full Load) məntiqi ilə işləyir.

İşləmə Mexanizmi (Execution Flow):
    1. Hər bir cədvəl üçün mövcud datalar silinir (TRUNCATE TABLE).
    2. Yeni datalar lokal qovluqdan sürətli şəkildə cədvələ daxil edilir (BULK INSERT).
    3. Hər cədvəlin və ümumi prosesin yüklənmə vaxtı (execution time) hesablanıb çapa verilir.
    4. Gözlənilməz xətalar zamanı proses TRY...CATCH bloku vasitəsilə idarə olunur 
       və xəta (error) detalları konsola (messages) yazdırılır.

XƏBƏRDARLIQ (WARNING):
    Bu prosedur işə salındıqda (EXECUTE edildikdə) 'bronze' cədvəllərindəki 
    bütün köhnə datalar tamamilə silinəcək və yalnız qeyd olunan CSV fayllarındakı 
    datalarla əvəzlənəcək.
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @START_TIME DATETIME, @END_TIME DATETIME, @BATCH_START_TIME DATETIME,@BATCH_END_TIME DATETIME
	BEGIN TRY
		SET @BATCH_START_TIME = GETDATE()
		PRINT '====================================================';
		PRINT 'BRONZE LAYER YUKLENIR';
		PRINT '====================================================';

		PRINT '----------------------------------------------------';
		PRINT 'CRM TABLE YUKLENIR';
		PRINT '----------------------------------------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_cust_info]';
		TRUNCATE TABLE [bronze].[crm_cust_info]

		PRINT '>> Inserting Data into: [bronze].[crm_cust_info]';
		BULK INSERT [bronze].[crm_cust_info]
		FROM 'C:\Users\ZiyaAsgerli\Desktop\SQL\dwh_project\datasets\source_crm\cust_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'YUKLENME VAXTI: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+ 'SANIYE'   
		PRINT '----------------------------------------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_prd_info]';
		TRUNCATE TABLE [bronze].[crm_prd_info]

		PRINT '>> Inserting Data into: [bronze].[crm_prd_info]';
		BULK INSERT [bronze].[crm_prd_info]
		FROM 'C:\Users\ZiyaAsgerli\Desktop\SQL\dwh_project\datasets\source_crm\prd_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'YUKLENME VAXTI: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+ 'SANIYE'   
		PRINT '----------------------------------------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_sales_details]';
		TRUNCATE TABLE [bronze].[crm_sales_details]

		PRINT '>> Inserting Data into: [bronze].[crm_sales_details]';
		BULK INSERT [bronze].[crm_sales_details]
		FROM 'C:\Users\ZiyaAsgerli\Desktop\SQL\dwh_project\datasets\source_crm\sales_details.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'YUKLENME VAXTI: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+ 'SANIYE'   
		PRINT '----------------------------------------------------';


		PRINT '----------------------------------------------------';
		PRINT 'ERP TABLE YUKLENIR';
		PRINT '----------------------------------------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table: [bronze].[erp_cust_az12]';
		TRUNCATE TABLE [bronze].[erp_cust_az12]

		PRINT '>> Inserting Data into: [bronze].[erp_cust_az12]';
		BULK INSERT [bronze].[erp_cust_az12]
		FROM 'C:\Users\ZiyaAsgerli\Desktop\SQL\dwh_project\datasets\source_erp\cust_az12.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'YUKLENME VAXTI: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+ 'SANIYE'   
		PRINT '----------------------------------------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table: [bronze].[erp_loc_a101]';
		TRUNCATE TABLE [bronze].[erp_loc_a101]

		PRINT '>> Inserting Data into: [bronze].[erp_loc_a101]';
		BULK INSERT [bronze].[erp_loc_a101]
		FROM 'C:\Users\ZiyaAsgerli\Desktop\SQL\dwh_project\datasets\source_erp\loc_a101.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'YUKLENME VAXTI: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+ 'SANIYE'   
		PRINT '----------------------------------------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table: [bronze].[erp_px_cat_g1v2]';
		TRUNCATE TABLE [bronze].[erp_px_cat_g1v2]

		PRINT '>> Inserting Data into: [bronze].[erp_px_cat_g1v2]';
		BULK INSERT [bronze].[erp_px_cat_g1v2]
		FROM 'C:\Users\ZiyaAsgerli\Desktop\SQL\dwh_project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'YUKLENME VAXTI: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+ 'SANIYE'   
		PRINT '----------------------------------------------------';

		SET @BATCH_END_TIME = GETDATE();
		PRINT '=========================================='
		PRINT 'BRONZE LAYER YUKLENMESI BASA CATDI';
        PRINT '   - TOTAL YUKLENME VAXTI: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH
	    PRINT '=========================================='
		PRINT 'BRONZE LAYER YUKLENERKEN EROR ASKARLANDI'
		PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER: ' + CAST(ERROR_NUMBER()AS NVARCHAR);
		PRINT 'ERROR LINE: ' + CAST(ERROR_LINE()AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
