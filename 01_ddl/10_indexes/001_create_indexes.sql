-- cards of a barbershop: the tenant filter of the staff list
CREATE INDEX IF NOT EXISTS idx_loyalty_card_barbershop_id ON loyalty.loyalty_card (barbershop_id);
-- history of a card
CREATE INDEX IF NOT EXISTS idx_loyalty_transaction_card_id ON loyalty.loyalty_transaction (loyalty_card_id);
-- one sticker per completed appointment, even if the event arrives twice or a manual grant names it
CREATE UNIQUE INDEX IF NOT EXISTS uq_loyalty_transaction_sticker_per_appointment
    ON loyalty.loyalty_transaction (appointment_id) WHERE type = 'STICKER_EARNED';
-- a client's coupons in a barbershop, by status
CREATE INDEX IF NOT EXISTS idx_reward_coupon_client_barbershop_status ON loyalty.reward_coupon (client_id, barbershop_id, status);
-- what the worker reads: pending events only, oldest first
CREATE INDEX IF NOT EXISTS idx_outbox_event_unpublished ON loyalty.outbox_event (occurred_at)
    WHERE published_at IS NULL AND failed_at IS NULL;
