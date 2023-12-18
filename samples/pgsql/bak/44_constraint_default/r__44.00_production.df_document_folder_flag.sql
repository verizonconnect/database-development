
IF OBJECT_ID('[production].[df_document_folder_flag]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[document]
        ADD CONSTRAINT [df_document_folder_flag]
        DEFAULT ((0))
        FOR [folder_flag];
    END;
GO

