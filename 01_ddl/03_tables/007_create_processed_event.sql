-- The ids of the events this service already processed (EventEnvelope.id). The worker delivers at
-- least once: the row is written in the same transaction as the effect, so a redelivery finds it
-- and answers DUPLICATE without acting again (ADR-016).
CREATE TABLE loyalty.processed_event (
    event_id      uuid        NOT NULL,
    event_type    text        NOT NULL,
    outcome       text        NOT NULL,
    processed_at  timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_processed_event PRIMARY KEY (event_id),
    CONSTRAINT chk_processed_event_outcome CHECK (outcome IN ('PROCESSED','IGNORED'))
);
