/* Copyright 2023. Verizon Connect Ireland Limited. All rights reserved. */
IF DATABASE_PRINCIPAL_ID('db_role_alation_data_catalog') IS NULL
BEGIN
    CREATE ROLE [db_role_alation_data_catalog];

    EXEC sys.sp_addextendedproperty @name = N'Alation Data Catalog Role',
                                    @value = N'Role for Alation Data Catalog',
                                    @level0type = N'USER',
                                    @level0name = N'db_role_alation_data_catalog';
END;
GRANT SELECT ON DATABASE::[${database_name}] TO [db_role_alation_data_catalog];

GRANT EXECUTE ON privacy_framework.get_catalogue__table_level TO db_role_alation_data_catalog;
GRANT EXECUTE ON privacy_framework.get_catalogue__column_level TO db_role_alation_data_catalog;