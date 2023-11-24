
IF OBJECT_ID('[purchasing].[pk_ship_method_ship_method_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[ship_method]
        ADD CONSTRAINT [pk_ship_method_ship_method_id]
        PRIMARY KEY CLUSTERED (ship_method_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'ship_method'
                                              , N'CONSTRAINT',N'pk_ship_method_ship_method_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'ship_method'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_ship_method_ship_method_id'
GO
