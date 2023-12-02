SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[production].[product_model_catalog_description]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [production].[product_model_catalog_description] 
AS 
SELECT 
    [product_model_id] 
    ,[name] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace html="http://www.w3.org/1999/xhtml"; 
        (/p1:ProductDescription/p1:Summary/html:p)[1]'', ''nvarchar(max)'') AS [summary] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Name)[1]'', ''nvarchar(max)'') AS [manufacturer] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Copyright)[1]'', ''nvarchar(30)'') AS [copyright] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:ProductURL)[1]'', ''nvarchar(256)'') AS [product_url] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:WarrantyPeriod)[1]'', ''nvarchar(256)'') AS [warranty_period] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:Description)[1]'', ''nvarchar(256)'') AS [warranty_description] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:NoOfYears)[1]'', ''nvarchar(256)'') AS [no_of_years] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:Description)[1]'', ''nvarchar(256)'') AS [maintenance_description] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:Wheel)[1]'', ''nvarchar(256)'') AS [Wheel] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:Saddle)[1]'', ''nvarchar(256)'') AS [saddle] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:Pedal)[1]'', ''nvarchar(256)'') AS [pedal] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:BikeFrame)[1]'', ''nvarchar(max)'') AS [bike_frame] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:Crankset)[1]'', ''nvarchar(256)'') AS [crankset] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Angle)[1]'', ''nvarchar(256)'') AS [picture_angle] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Size)[1]'', ''nvarchar(256)'') AS [picture_size] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:ProductPhotoID)[1]'', ''nvarchar(256)'') AS [product_photo_id] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Material)[1]'', ''nvarchar(256)'') AS [material] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Color)[1]'', ''nvarchar(256)'') AS [colour] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/ProductLine)[1]'', ''nvarchar(256)'') AS [product_line] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Style)[1]'', ''nvarchar(256)'') AS [style] 
    ,[catalog_description].value(N''declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/RiderExperience)[1]'', ''nvarchar(1024)'') AS [rider_experience] 
    ,[rowguid] 
    ,[modified_date]
FROM [production].[product_model] 
WHERE [catalog_description] IS NOT NULL;
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'VIEW',N'product_model_catalog_description', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each element in the xml column catalog_description for each product in the production.product_model table that has catalog data.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'VIEW',@level1name=N'product_model_catalog_description'
GO
