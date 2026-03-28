INSERT INTO person.address_type (address_type_id, name, rowguid)
VALUES  (1, 'Billing',      'b84f78b1-4efe-4a0e-8cb7-70e9f112f886')
       ,(2, 'Home',          '41bc2ff6-f0fc-475f-8eb9-cec0805aa0f2')
       ,(3, 'Main Office',   '8eeec28c-07a2-4fb9-ad0a-42d4a0bbc575')
       ,(4, 'Primary',       '24cb3088-4345-47c4-86c5-17b535133d1e')
       ,(5, 'Shipping',      'b29da3f8-19a3-47da-9daa-15c84f4a83a5')
       ,(6, 'Archive',       'a67f238a-5ba2-444b-966c-0467ed9c427f')
ON CONFLICT (address_type_id) DO UPDATE SET
    name          = EXCLUDED.name
   ,rowguid       = EXCLUDED.rowguid
   ,modified_date = NOW() AT TIME ZONE 'utc';
