-- The model of processed_event (06-data/models.md §10) has no outcome: a redelivery answers
-- DUPLICATE whatever the first answer was. New changeset: ddl-tables-007 is never edited.
ALTER TABLE loyalty.processed_event
    DROP CONSTRAINT IF EXISTS chk_processed_event_outcome,
    DROP COLUMN IF EXISTS outcome;
