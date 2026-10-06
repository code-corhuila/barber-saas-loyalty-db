-- Every sticker earned and every reward redeemed, append-only: the log behind StickerGranted and
-- RewardRedeemed. It reaches the tenant through its card.
CREATE TABLE loyalty.loyalty_transaction (
    id                  uuid        NOT NULL,
    loyalty_card_id     uuid        NOT NULL,
    appointment_id      uuid        NULL,       -- no FK: appointment domain
    type                text        NOT NULL,
    granted_by_user_id  uuid        NOT NULL,   -- no FK: identity-auth domain
    created_at          timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_loyalty_transaction PRIMARY KEY (id),
    CONSTRAINT fk_loyalty_transaction_card FOREIGN KEY (loyalty_card_id)
        REFERENCES loyalty.loyalty_card (id) ON DELETE CASCADE,
    CONSTRAINT chk_loyalty_transaction_type CHECK (type IN ('STICKER_EARNED','REWARD_REDEEMED'))
);
