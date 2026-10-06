DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'loyalty_app') THEN
        REVOKE loyalty_writer FROM loyalty_app;
    END IF;
END
$$;
ALTER DEFAULT PRIVILEGES IN SCHEMA loyalty REVOKE ALL ON TABLES FROM loyalty_reader, loyalty_writer;
REVOKE ALL ON ALL TABLES IN SCHEMA loyalty FROM loyalty_reader, loyalty_writer;
REVOKE USAGE ON SCHEMA loyalty FROM loyalty_reader, loyalty_writer;
