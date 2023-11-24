/****** Object:  UserDefinedFunction [common].[get_product_list_cost]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[get_product_list_cost]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute sys.sp_executesql @statement = N'
CREATE FUNCTION [common].[get_product_list_cost](@product_id [int], @order_date [datetime])
RETURNS [money] 
AS 
BEGIN
    DECLARE @list_price money;

    SELECT @list_price = plph.[list_price] 
    FROM [production].[product] p 
        INNER JOIN [production].[product_list_price_history] plph 
        ON p.[product_id] = plph.[product_id] 
            AND p.[product_id] = @product_id 
            AND @order_date BETWEEN plph.[start_date] AND COALESCE(plph.[end_date], CONVERT(datetime, ''99991231'', 112)); -- Make sure we get all the prices!

    RETURN @list_price;
END;
' 
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_product_list_cost', N'PARAMETER',N'@product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the scalar function get_product_list_cost. Enter a valid product_id from the production.product table.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_product_list_cost', @level2type=N'PARAMETER',@level2name=N'@product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_product_list_cost', N'PARAMETER',N'@order_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the scalar function get_product_list_cost. Enter a valid order date.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_product_list_cost', @level2type=N'PARAMETER',@level2name=N'@order_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_product_list_cost', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Scalar function returning the list price for a given product on a particular order date.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_product_list_cost'
GO
