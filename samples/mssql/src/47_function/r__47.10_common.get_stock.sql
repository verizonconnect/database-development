/****** Object:  UserDefinedFunction [common].[get_stock]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[get_stock]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute sys.sp_executesql @statement = N'
CREATE FUNCTION [common].[get_stock](@product_id [int])
RETURNS [int] 
AS 
-- Returns the stock level for the product. This function is used internally only
BEGIN
    DECLARE @ret int;
    
    SELECT @ret = SUM(p.[quantity]) 
    FROM [production].[product_inventory] p 
    WHERE p.[product_id] = @product_id 
        AND p.[location_id] = ''6''; -- Only look at inventory in the misc storage
    
    IF (@ret IS NULL) 
        SET @ret = 0
    
    RETURN @ret
END;
' 
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_stock', N'PARAMETER',N'@product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the scalar function get_stock. Enter a valid product_id from the production.product_inventory table.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_stock', @level2type=N'PARAMETER',@level2name=N'@product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_stock', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Scalar function returning the quantity of inventory in location_id 6 (Miscellaneous Storage)for a specified product_id.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_stock'
GO
