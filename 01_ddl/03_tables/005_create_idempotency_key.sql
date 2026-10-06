CREATE TABLE loyalty.idempotency_key (
    key            text        NOT NULL,
    operation      text        NOT NULL,
    resource_id    uuid        NOT NULL,
    request_hash   text        NOT NULL,
    created_at     timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_idempotency_key PRIMARY KEY (key, operation),
    CONSTRAINT chk_idempotency_key_length CHECK (char_length(key) BETWEEN 8 AND 128)
);
