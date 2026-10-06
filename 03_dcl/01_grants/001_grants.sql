GRANT USAGE ON SCHEMA loyalty TO loyalty_reader, loyalty_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA loyalty TO loyalty_reader;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA loyalty TO loyalty_writer;
ALTER DEFAULT PRIVILEGES IN SCHEMA loyalty GRANT SELECT ON TABLES TO loyalty_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA loyalty GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO loyalty_writer;

-- The domain grants its writer role to its own login user (Annex J J.7). The user exists only
-- where the infrastructure created it, so the grant is conditional. No other domain is granted
-- loyalty_reader: other domains read this data through loyalty-api (Annex J J.3.3).
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'loyalty_app') THEN
        GRANT loyalty_writer TO loyalty_app;
    END IF;
END
$$;
