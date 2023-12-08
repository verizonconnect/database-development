
IF NOT EXISTS (SELECT 1 FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'flag' AND ss.name = N'common')
CREATE TYPE [common].[flag] FROM [bit] NOT NULL
GO
