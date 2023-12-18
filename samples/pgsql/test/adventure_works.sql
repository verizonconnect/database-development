SET client_encoding = 'UTF-8';
SET client_min_messages = error;
CREATE EXTENSION IF NOT EXISTS pgtap;

BEGIN;
SELECT plan(1);

SELECT schemas_are(ARRAY['human_resources'
                        ,'person'
                        ,'sales'
                        ,'production'
                        ,'common'
                        ,'purchasing'
                        ,'flyway'
                        ,'public']);

SELECT * FROM finish();
ROLLBACK;
