
IF OBJECT_ID('[production].[ck_document_status]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[document]
        WITH NOCHECK
        ADD CONSTRAINT [ck_document_status]
        CHECK ([status]>=(1) AND [status]<=(3));
    END;
GO

ALTER TABLE [production].[document] 
CHECK CONSTRAINT [ck_document_status]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'document'
                                              , N'CONSTRAINT',N'ck_document_status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [status] BETWEEN (1) AND (3)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'document'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_document_status'
GO
