-- NOLOGIN roles carry the permissions. The login user loyalty_app is created by
-- barber-saas-infra-postgres from a secret; no password is ever versioned here.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'loyalty_reader') THEN
        CREATE ROLE loyalty_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'loyalty_writer') THEN
        CREATE ROLE loyalty_writer NOLOGIN;
    END IF;
END
$$;
