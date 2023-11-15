IF NOT EXISTS  (SELECT  1
                FROM    sys.extended_properties AS ep
                WHERE   ep.major_id = 0
                        AND ep.minor_id = 0
                        AND ep.class_desc = 'DATABASE'
                        AND ep.name = 'Copyright Notice')
BEGIN
    EXEC sys.sp_addextendedproperty @name = N'Copyright Notice'
                                   ,@value = N'Copyright © 2023 Verizon Connect IRL Limited. All rights reserved.';
END;
GO
