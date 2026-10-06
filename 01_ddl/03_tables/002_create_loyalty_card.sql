-- A client's stickers in one barbershop. Created with the first sticker (DEC-LOY-03), never
-- negative (INV-LOYAL-001).
CREATE TABLE loyalty.loyalty_card (
    id                      uuid        NOT NULL,
    barbershop_id           uuid        NOT NULL,
    client_id               uuid        NOT NULL,   -- no FK: identity-auth domain
    stickers_count          integer     NOT NULL DEFAULT 0,
    total_rewards_redeemed  integer     NOT NULL DEFAULT 0,
    last_updated            timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_loyalty_card PRIMARY KEY (id),
    CONSTRAINT uq_loyalty_card_client_barbershop UNIQUE (client_id, barbershop_id),
    CONSTRAINT chk_loyalty_card_counts CHECK (stickers_count >= 0 AND total_rewards_redeemed >= 0)
);
