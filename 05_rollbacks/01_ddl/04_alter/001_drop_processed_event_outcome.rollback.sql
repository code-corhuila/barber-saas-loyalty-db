ALTER TABLE loyalty.processed_event ADD COLUMN outcome text NOT NULL DEFAULT 'PROCESSED';
ALTER TABLE loyalty.processed_event ALTER COLUMN outcome DROP DEFAULT;
ALTER TABLE loyalty.processed_event
    ADD CONSTRAINT chk_processed_event_outcome CHECK (outcome IN ('PROCESSED','IGNORED'));
