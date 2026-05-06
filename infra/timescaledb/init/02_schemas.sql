-- Create application schema
CREATE SCHEMA IF NOT EXISTS thesis;

-- Create least-privilege application user
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'thesis_app') THEN
        CREATE ROLE thesis_app WITH LOGIN PASSWORD 'thesis_app_pass';
    END IF;
END
$$;

-- Grant schema usage
GRANT USAGE ON SCHEMA thesis TO thesis_app;
GRANT USAGE ON SCHEMA public TO thesis_app;

-- Grant table privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA thesis TO thesis_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO thesis_app;

-- Grant sequence privileges
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA thesis TO thesis_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO thesis_app;

-- Default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA thesis
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO thesis_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO thesis_app;

-- thesis_app cannot drop tables or create new ones
-- thesis_user (superuser) handles DDL only