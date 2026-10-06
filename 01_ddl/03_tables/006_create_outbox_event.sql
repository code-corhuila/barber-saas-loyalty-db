-- Events of this domain (StickerGranted, RewardRedeemed), written in the same transaction as the
-- change and relayed by barber-saas-worker (norm 5.3.11, ADR-016). failed_at and last_error are
-- here from the start: an event the worker cannot deliver leaves the pending list.
CREATE TABLE loyalty.outbox_event (
    id              uuid        NOT NULL,
    aggregate_type  text        NOT NULL,   -- 'loyalty_card'
    aggregate_id    uuid        NOT NULL,
    event_type      text        NOT NULL,   -- e.g. 'StickerGranted'
    payload         jsonb       NOT NULL,
    correlation_id  text        NOT NULL,
    occurred_at     timestamptz NOT NULL DEFAULT now(),
    published_at    timestamptz NULL,
    failed_at       timestamptz NULL,
    last_error      text        NULL,
    CONSTRAINT pk_outbox_event PRIMARY KEY (id),
    CONSTRAINT chk_outbox_event_last_error CHECK (char_length(last_error) <= 500)
);
