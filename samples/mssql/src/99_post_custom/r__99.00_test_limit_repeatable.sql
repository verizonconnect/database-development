/* Copyright 2023. Verizon Connect Ireland Limited. All rights reserved. */
IF NOT EXISTS (SELECT   1 --Ensure BEGIN/END block is only executed once
               FROM     ${flyway:defaultSchema}.${flyway:table} AS ft
               WHERE    ft.[script] LIKE '%${flyway:filename}'
                        AND ft.[success] = 1)
    BEGIN
        PRINT 'here';
    END;
