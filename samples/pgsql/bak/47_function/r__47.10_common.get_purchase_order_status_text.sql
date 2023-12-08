
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[get_purchase_order_status_text]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute sys.sp_executesql @statement = N'
CREATE FUNCTION [common].[get_purchase_order_status_text](@status [tinyint])
RETURNS [nvarchar](15) 
AS 
-- Returns the sales order status text representation for the status value.
BEGIN
    DECLARE @ret [nvarchar](15);

    SET @ret = 
        CASE @status
            WHEN 1 THEN ''Pending''
            WHEN 2 THEN ''Approved''
            WHEN 3 THEN ''rejected''
            WHEN 4 THEN ''Complete''
            ELSE ''** Invalid **''
        END;
    
    RETURN @ret
END;
' 
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_purchase_order_status_text', N'PARAMETER',N'@status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the scalar function ufnGetpurchase_ordertstatusText. Enter a valid integer.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_purchase_order_status_text', @level2type=N'PARAMETER',@level2name=N'@status'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_purchase_order_status_text', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Scalar function returning the text representation of the status column in the purchase_order_header table.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_purchase_order_status_text'
GO
