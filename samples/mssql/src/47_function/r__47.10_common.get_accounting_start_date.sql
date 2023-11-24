/****** Object:  UserDefinedFunction [common].[get_accounting_start_date]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[get_accounting_start_date]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute sys.sp_executesql @statement = N'
CREATE FUNCTION [common].[get_accounting_start_date]()
RETURNS [datetime] 
AS 
BEGIN
    RETURN CONVERT(datetime, ''20030701'', 112);
END;
' 
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_accounting_start_date', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Scalar function used in the usales_order_header trigger to set the ending account date.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_accounting_start_date'
GO
