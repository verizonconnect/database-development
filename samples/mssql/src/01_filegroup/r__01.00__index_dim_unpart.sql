-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved. 
IF NOT EXISTS (SELECT 1 FROM sys.filegroups WHERE name='index_dim_unpart')
BEGIN
    ALTER DATABASE [${database_name}] ADD FILEGROUP [index_dim_unpart];
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_files WHERE name = N'${database_name}_index_dim_unpart_01')
BEGIN
    ALTER DATABASE [${database_name}] 
    ADD FILE ( NAME = N'${database_name}_index_dim_unpart_01'
              ,FILENAME =  N'${alter_database_data_path}${database_name}_index_dim_unpart_01.ndf' 
              ,SIZE = ${alter_database_data_size_medium} 
              ,MAXSIZE = UNLIMITED
              ,FILEGROWTH = ${alter_database_data_growth_medium} ) 
    TO FILEGROUP [index_dim_unpart]; 
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_files WHERE name = N'${database_name}_index_dim_unpart_02')
BEGIN
    ALTER DATABASE [${database_name}] 
    ADD FILE ( NAME = N'${database_name}_index_dim_unpart_02'
              ,FILENAME =  N'${alter_database_data_path}${database_name}_index_dim_unpart_02.ndf' 
              ,SIZE = ${alter_database_data_size_medium} 
              ,MAXSIZE = UNLIMITED
              ,FILEGROWTH = ${alter_database_data_growth_medium} ) 
    TO FILEGROUP [index_dim_unpart]; 
END
GO