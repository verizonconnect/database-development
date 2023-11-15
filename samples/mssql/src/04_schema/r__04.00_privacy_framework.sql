/* Copyright © 2020. Verizon Connect Ireland Limited. All rights reserved. */
IF SCHEMA_ID('privacy_framework') IS NULL
BEGIN
    DECLARE @sql NVARCHAR(300) = 'CREATE SCHEMA [privacy_framework] AUTHORIZATION [dbo];';
    EXEC sys.sp_executesql @stmt = @sql;
END
GO
