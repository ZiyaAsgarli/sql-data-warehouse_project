/*
=================================================================
Database və Schema-ların Yaradılması (Create Database and Schemas)
=================================================================
Script-in Məqsədi:
    Bu script 'DataWarehouse' adlı yeni database yaradır, lakin əvvəlcə onun mövcud olub-olmadığını yoxlayır.
    Əgər database artıq mövcuddursa, o silinir (dropped) və yenidən yaradılır. Əlavə olaraq, bu script 
    database daxilində üç schema qurur: 'bronze', 'silver' və 'gold'.

XƏBƏRDARLIQ (WARNING):
    Bu script-i işlətmək, mövcud olduğu halda bütün 'DataWarehouse' database-ini siləcək (drop edəcək).
    Database-dəki bütün datalar qalıcı olaraq silinəcək. Ehtiyatla davam edin və bu script-i 
    işlətməzdən əvvəl müvafiq backup-ların (ehtiyat nüsxələrinin) olduğundan əmin olun.
*/

-- Master database-ə keçid edirik ki, server səviyyəsində əməliyyatlar (məsələn, database yaratmaq/silmək) apara bilək
USE master;
GO

-- 'DataWarehouse' adlı database-in serverdə mövcud olub-olmadığını yoxlayırıq
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    -- Əgər database varsa, digər proseslərin aktiv connection-larını anında kəsirik (Rollback Immediate)
    -- və database-i Single-User mode-a keçiririk ki, Drop edərkən locking xətası (error) almayaq
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    
    -- Köhnə database-i serverdən tamamilə silirik (Drop)
    DROP DATABASE DataWarehouse;
END;
GO

-- Yeni təmiz 'DataWarehouse' database-ini yaradırıq
CREATE DATABASE DataWarehouse;
GO

-- Yaradılmış yeni database-in içinə keçid edirik
USE [DataWarehouse];
GO

-- ============================================================================
-- Medallion Architecture Schema-larının Yaradılması
-- ============================================================================

-- 1. Bronze Layer (Raw Data): Source sistemlərdən gələn xam (işlənməmiş) datanı saxlamaq üçün schema
CREATE SCHEMA bronze;
GO

-- 2. Silver Layer (Cleansed & Standardized Data): Təmizlənmiş, filtrlənmiş və standartlaşdırılmış datanı saxlamaq üçün schema
CREATE SCHEMA silver;
GO

-- 3. Gold Layer (Business-Ready Data): Analytics və hesabatlar (Power BI/Reporting) üçün hazır, modelləşdirilmiş datanı saxlamaq üçün schema
CREATE SCHEMA gold;
GO
