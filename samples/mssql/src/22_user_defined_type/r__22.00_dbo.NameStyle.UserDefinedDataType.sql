﻿/****** Object:  UserDefinedDatatype [common].[name_style]    Script Date: 16/11/2023 08:45:04 ******/
IF NOT EXISTS (SELECT 1 FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'name_style' AND ss.name = N'common')
CREATE TYPE [common].[name_style] FROM [bit] NOT NULL
GO
