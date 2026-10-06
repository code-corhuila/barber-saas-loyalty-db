-- The reward a barbershop gives after stickers_required stickers. One per barbershop, as the
-- contract exposes a single /loyalty/config; is_active false switches the program off.
CREATE TABLE loyalty.loyalty_rewards_config (
    id                  uuid    NOT NULL,
    barbershop_id       uuid    NOT NULL,
    stickers_required   integer NOT NULL DEFAULT 10,
    reward_description  text    NOT NULL,
    is_active           boolean NOT NULL DEFAULT true,
    CONSTRAINT pk_loyalty_rewards_config PRIMARY KEY (id),
    CONSTRAINT uq_loyalty_rewards_config_barbershop UNIQUE (barbershop_id),
    CONSTRAINT chk_loyalty_rewards_config_stickers CHECK (stickers_required >= 1),
    CONSTRAINT chk_loyalty_rewards_config_description CHECK (char_length(reward_description) BETWEEN 1 AND 255)
);
