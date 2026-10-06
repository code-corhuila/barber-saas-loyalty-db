# barber-saas-loyalty-db

> loyalty bounded context: database (schema, seeds, migrations)

Part of the **Barber Saas** distributed system — team `barber-saas`, Grupo 2.
Governance and documentation live in [`barber-saas-docs`](https://github.com/code-corhuila/barber-saas-docs).

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `barber-saas-docs`.

---

## BarberSaaS — what this repository is

The `loyalty` schema (each barbershop's reward rule, the clients' sticker cards and their
append-only history, the coupons a redemption issues, idempotency keys, the outbox of loyalty
events and the events already processed) versioned with Liquibase (ADR-007), following annex A and
Annex J: it has **no database instance of its own**. Its runner applies the changesets to the single
PostgreSQL instance of `barber-saas-infra-postgres`, with its own changelog tables
(`databasechangelog_loyalty`). Model: `06-data/models.md` §6 and §10 in `barber-saas-docs`.

### How to run the migrations

From `barber-saas-infra-postgres`, with the platform up:

```bash
docker compose --env-file env/dev.env run --rm loyalty-db-migrate            # update
docker compose --env-file env/dev.env run --rm loyalty-db-migrate status --verbose
docker compose --env-file env/dev.env run --rm loyalty-db-migrate rollback-count 1
```

### Where the data is

Schema `loyalty` in database `barbersaas` of the shared instance. The service reads and writes it
as `loyalty_app` (granted `loyalty_writer` in `03_dcl/`); nobody else writes it. Clients and
appointments are referenced by id with no foreign key.

- **One sticker per completed appointment** is a database rule:
  `uq_loyalty_transaction_sticker_per_appointment` (unique `appointment_id` among `STICKER_EARNED`),
  because the sticker arrives by event and can be delivered twice (ADR-016).
- **`processed_event`** keeps the id of every event already handled, written in the same
  transaction as its effect, so a redelivered `AppointmentCompleted` answers `DUPLICATE` without
  acting again — also for an event that was `IGNORED` (no active program, a walk-in).
- `outbox_event` carries `failed_at` and `last_error` from the start, with the partial index the
  worker reads (`published_at` and `failed_at` null).

### How it is tested

`.github/workflows/db-ci.yml` builds the schema from an empty database, checks that a second
update applies nothing, rolls everything back and applies it again.

### What is missing

No seed data: the reward rule is configured by each owner through `barber-saas-loyalty-api`.
