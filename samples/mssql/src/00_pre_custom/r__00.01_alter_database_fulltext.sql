IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
    EXEC [${database_name}].[dbo].[sp_fulltext_database] @action = 'enable'
GO
