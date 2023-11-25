
IF NOT EXISTS (SELECT 1 FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'name' AND ss.name = N'common')
CREATE TYPE [common].[name] FROM [nvarchar](50) NULL
GO
