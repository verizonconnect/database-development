
IF OBJECT_ID('[sales].[pk_sales_person_quota_history_business_entity_id_quota_date]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_person_quota_history]
        ADD CONSTRAINT [pk_sales_person_quota_history_business_entity_id_quota_date]
        PRIMARY KEY CLUSTERED (business_entity_id ASC, quota_date ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_person_quota_history'
                                              , N'CONSTRAINT',N'pk_sales_person_quota_history_business_entity_id_quota_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_person_quota_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_sales_person_quota_history_business_entity_id_quota_date'
GO
