SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(32);

SELECT schemas_are(ARRAY[
    'common',
    'flyway',
    'human_resources',
    'person',
    'production',
    'public',
    'purchasing',
    'sales'
]);

SELECT schema_owner_is('common','postgres');
SELECT schema_owner_is('flyway','postgres');
SELECT schema_owner_is('human_resources','postgres');
SELECT schema_owner_is('person','postgres');
SELECT schema_owner_is('production','postgres');
SELECT schema_owner_is('public','postgres');
SELECT schema_owner_is('purchasing','postgres');
SELECT schema_owner_is('sales','postgres');

SELECT functions_are('common', ARRAY[
    'connectby',
    'crosstab',
    'crosstab2',
    'crosstab3',
    'crosstab4',
    'normal_rand',
    'uuid_generate_v1',
    'uuid_generate_v1mc',
    'uuid_generate_v3',
    'uuid_generate_v4',
    'uuid_generate_v5',
    'uuid_nil',
    'uuid_ns_dns',
    'uuid_ns_oid',
    'uuid_ns_url',
    'uuid_ns_x500'
]);

SELECT is(
    md5(p.prosrc), '5e297d5329d326bf986a7e9ef2789f4d',
    'Function common.connectby(text, text, text, text, integer) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'connectby'
    AND oidvectortypes(proargtypes) = 'text, text, text, text, integer'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '5e297d5329d326bf986a7e9ef2789f4d',
    'Function common.connectby(text, text, text, text, integer, text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'connectby'
    AND oidvectortypes(proargtypes) = 'text, text, text, text, integer, text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'c43ede5aed5998e317e8aa747b6ad7fb',
    'Function common.connectby(text, text, text, text, text, integer) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'connectby'
    AND oidvectortypes(proargtypes) = 'text, text, text, text, text, integer'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'c43ede5aed5998e317e8aa747b6ad7fb',
    'Function common.connectby(text, text, text, text, text, integer, text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'connectby'
    AND oidvectortypes(proargtypes) = 'text, text, text, text, text, integer, text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'd8730a9a4f84335d20018cbfbc33d80c',
    'Function common.crosstab(text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'crosstab'
    AND oidvectortypes(proargtypes) = 'text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'd8730a9a4f84335d20018cbfbc33d80c',
    'Function common.crosstab(text, integer) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'crosstab'
    AND oidvectortypes(proargtypes) = 'text, integer'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '83d964449ce05bab6b034096ec994fe5',
    'Function common.crosstab(text, text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'crosstab'
    AND oidvectortypes(proargtypes) = 'text, text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'd8730a9a4f84335d20018cbfbc33d80c',
    'Function common.crosstab2(text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'crosstab2'
    AND oidvectortypes(proargtypes) = 'text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'd8730a9a4f84335d20018cbfbc33d80c',
    'Function common.crosstab3(text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'crosstab3'
    AND oidvectortypes(proargtypes) = 'text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'd8730a9a4f84335d20018cbfbc33d80c',
    'Function common.crosstab4(text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'crosstab4'
    AND oidvectortypes(proargtypes) = 'text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '447d863b6cb83a4aaa2252d6087a8ce2',
    'Function common.normal_rand(integer, double precision, double precision) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'normal_rand'
    AND oidvectortypes(proargtypes) = 'integer, double precision, double precision'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '21ed6db9a12cddb2b4389c47fb0b626b',
    'Function common.uuid_generate_v1() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_generate_v1'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '76430797001a6b05b94db0b23ce06c14',
    'Function common.uuid_generate_v1mc() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_generate_v1mc'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'a9f592e3ddc55c988db12cf19466c845',
    'Function common.uuid_generate_v3(uuid, text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_generate_v3'
    AND oidvectortypes(proargtypes) = 'uuid, text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), 'bf35f7759293b23de18e6ecfa57aaf98',
    'Function common.uuid_generate_v4() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_generate_v4'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '652ae453dac795e196ce8300f1bad8f8',
    'Function common.uuid_generate_v5(uuid, text) body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_generate_v5'
    AND oidvectortypes(proargtypes) = 'uuid, text'
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '4c1c0f60c981170458b623f250003a49',
    'Function common.uuid_nil() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_nil'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '446d755e248c9f38a23e5a728a387962',
    'Function common.uuid_ns_dns() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_ns_dns'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '27b7b58039b58cc86c36e0841276e121',
    'Function common.uuid_ns_oid() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_ns_oid'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '983b2b683b5313c28b90893fb744e61b',
    'Function common.uuid_ns_url() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_ns_url'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT is(
    md5(p.prosrc), '4097345620c46079cbdf0010d8fabb46',
    'Function common.uuid_ns_x500() body should match checksum'
)
   FROM pg_catalog.pg_namespace n
   LEFT JOIN pg_catalog.pg_proc p
     ON p.pronamespace = n.oid
    AND proname = 'uuid_ns_x500'
    AND oidvectortypes(proargtypes) = ''
  WHERE n.nspname = 'common';

SELECT extensions_are('common', ARRAY[
    'tablefunc',
    'uuid-ossp'
]);




SELECT * FROM finish();
ROLLBACK;
