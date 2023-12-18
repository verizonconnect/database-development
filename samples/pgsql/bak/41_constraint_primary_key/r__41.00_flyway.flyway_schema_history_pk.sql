
IF OBJECT_ID('[flyway].[flyway_schema_history_pk]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [flyway].[flyway_schema_history]
        ADD CONSTRAINT [flyway_schema_history_pk]
        PRIMARY KEY CLUSTERED (installed_rank ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

