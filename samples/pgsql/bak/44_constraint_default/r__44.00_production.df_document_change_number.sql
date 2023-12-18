
IF OBJECT_ID('[production].[df_document_change_number]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[document]
        ADD CONSTRAINT [df_document_change_number]
        DEFAULT ((0))
        FOR [change_number];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'document'
                                              , N'CONSTRAINT',N'df_document_change_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'document'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_document_change_number'
GO
