﻿
IF NOT EXISTS (SELECT 1 FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'account_number' AND ss.name = N'common')
CREATE TYPE [common].[account_number] FROM [nvarchar](15) NULL
GO
