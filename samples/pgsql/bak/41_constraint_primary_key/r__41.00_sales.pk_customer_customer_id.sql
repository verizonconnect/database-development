
IF OBJECT_ID('[sales].[pk_customer_customer_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[customer]
        ADD CONSTRAINT [pk_customer_customer_id]
        PRIMARY KEY CLUSTERED (customer_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'customer'
                                              , N'CONSTRAINT',N'pk_customer_customer_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'customer'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_customer_customer_id'
GO
