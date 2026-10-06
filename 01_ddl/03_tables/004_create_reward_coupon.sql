-- The coupon a redemption issues (FR-015). USED exactly when used_at is set.
CREATE TABLE loyalty.reward_coupon (
    id              uuid        NOT NULL,
    barbershop_id   uuid        NOT NULL,
    client_id       uuid        NOT NULL,
    status          text        NOT NULL DEFAULT 'ACTIVE',
    appointment_id  uuid        NULL,           -- set when the coupon pays an appointment
    created_at      timestamptz NOT NULL DEFAULT now(),
    used_at         timestamptz NULL,
    CONSTRAINT pk_reward_coupon PRIMARY KEY (id),
    CONSTRAINT chk_reward_coupon_status CHECK (status IN ('ACTIVE','USED')),
    CONSTRAINT chk_reward_coupon_used   CHECK ((status = 'USED') = (used_at IS NOT NULL))
);
