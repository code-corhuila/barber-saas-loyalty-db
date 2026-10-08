# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-10-08

User stories: code-corhuila/barber-saas-docs#9, code-corhuila/barber-saas-docs#59

### Added

- deploy: add the migration runner with its own changelog tables
- ddl: create the loyalty schema
- ddl: create loyalty rewards config
- ddl: create loyalty card
- ddl: create loyalty transaction
- ddl: create reward coupon
- ddl: create idempotency key
- ddl: create outbox event
- ddl: create processed event
- dcl: create roles
- dcl: grant the writer role to the domain user

### Fixed

- ddl: drop the outcome of processed_event to match the data model

### Changed

- ddl: create indexes

### Documentation

- readme: point the header to Barber Saas and barber-saas-docs
- readme: explain the schema, the one-sticker rule and the processed events
- readme: list the columns of processed_event

### Tests

- ci: rebuild the schema from an empty database on every pull request

### Maintenance

- db: ignore local env files and liquibase output
- github: add the pull request template
- github: track the story environment on the board
- liquibase: add the master changelog and the ddl, dml, dcl and tcl families

[2.0.0]: https://github.com/code-corhuila/barber-saas-loyalty-db/releases/tag/v2.0.0
