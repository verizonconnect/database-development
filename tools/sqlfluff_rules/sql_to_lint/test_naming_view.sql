-- test_views.sql

-- This name is VALID
CREATE VIEW dbo.vw_object AS
    SELECT 1;
GO

-- This name is INVALID
CREATE VIEW dbo.this_view_is_invalid AS
    SELECT 1;
GO