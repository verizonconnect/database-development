
IF OBJECT_ID('[human_resources].[pk_employee_pay_history_business_entity_id_rate_change_date]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[employee_pay_history]
        ADD CONSTRAINT [pk_employee_pay_history_business_entity_id_rate_change_date]
        PRIMARY KEY CLUSTERED (business_entity_id ASC, rate_change_date ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee_pay_history'
                                              , N'CONSTRAINT',N'pk_employee_pay_history_business_entity_id_rate_change_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee_pay_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_employee_pay_history_business_entity_id_rate_change_date'
GO
