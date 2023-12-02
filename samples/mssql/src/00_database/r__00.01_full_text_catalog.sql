IF NOT EXISTS (SELECT 1 FROM sysfulltextcatalogs ftc WHERE ftc.name = N'${flyway:database}_full_text_catalog')
CREATE FULLTEXT CATALOG [${flyway:database}_full_text_catalog] AS DEFAULT
GO
