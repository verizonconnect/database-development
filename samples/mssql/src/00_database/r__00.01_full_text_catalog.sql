IF NOT EXISTS (SELECT 1 FROM sysfulltextcatalogs ftc WHERE ftc.name = N'aw2016_full_text_catalog')
CREATE FULLTEXT CATALOG [aw2016_full_text_catalog] AS DEFAULT
GO
