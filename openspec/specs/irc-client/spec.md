# irc-client Specification

## Purpose
TBD - created by archiving change modernize-exirc-fork. Update Purpose after archive.
## Requirements
### Requirement: Modern Logger Integration
The `ExIRC.Logger` module SHALL use Elixir's `Logger` module instead of Erlang's deprecated `:error_logger`. Log levels SHALL map to standard Elixir Logger levels (`:info`, `:warning`, `:error`).

#### Scenario: Info messages use Logger.info
- **WHEN** the library logs an informational message
- **THEN** it is emitted via `Logger.info/1` (not `:error_logger.info_report/1`)

#### Scenario: Warning messages use Logger.warning
- **WHEN** the library logs a warning message
- **THEN** it is emitted via `Logger.warning/1` (not `:error_logger.warning_report/1`)

#### Scenario: Error messages use Logger.error
- **WHEN** the library logs an error message
- **THEN** it is emitted via `Logger.error/1` (not `:error_logger.error_report/1`)

#### Scenario: No charlist conversions for logging
- **WHEN** a string is logged
- **THEN** it is passed directly as a binary string without `String.to_charlist/1` conversion

