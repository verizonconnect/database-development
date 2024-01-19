CREATE TABLE IF NOT EXISTS person.password(
    business_entity_id INT NOT NULL
   ,password_hash VARCHAR(128) NOT NULL
   ,password_salt VARCHAR(10) NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.password IS 'One way hashed authentication information';
COMMENT ON COLUMN person.password.password_hash IS 'password for the e-mail account.';
COMMENT ON COLUMN person.password.password_salt IS 'Random value concatenated with the password string before the password is hashed.';