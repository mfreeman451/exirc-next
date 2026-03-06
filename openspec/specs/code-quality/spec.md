# code-quality Specification

## Purpose
TBD - created by archiving change modernize-exirc-fork. Update Purpose after archive.
## Requirements
### Requirement: Module Documentation
All public modules SHALL have `@moduledoc` attributes describing their purpose. Internal/private modules MAY use `@moduledoc false`.

#### Scenario: Public modules have moduledoc
- **WHEN** running Credo or reviewing source code
- **THEN** all public-facing modules (`ExIRC`, `ExIRC.Client`, `ExIRC.Commands`, `ExIRC.Channels`, `ExIRC.Utils`) have `@moduledoc` strings

### Requirement: No Deprecated API Usage
The codebase SHALL NOT use deprecated Erlang or Elixir APIs. All OTP and Elixir calls SHALL use current, supported APIs.

#### Scenario: No deprecated function calls
- **WHEN** compiling with `--warnings-as-errors`
- **THEN** no deprecation warnings are emitted

### Requirement: Consistent Code Style
The codebase SHALL follow Elixir community conventions as enforced by `mix format` and Credo. This includes consistent module structure, function ordering, and naming.

#### Scenario: Code passes formatter and linter
- **WHEN** running `mix format --check-formatted && mix credo --strict`
- **THEN** both commands exit with status 0

### Requirement: Clean Legacy Artifacts
Legacy CI configuration (`.travis.yml`) and outdated references to the upstream project SHALL be removed from the repository.

#### Scenario: No legacy CI files
- **WHEN** listing project root files
- **THEN** no `.travis.yml` file exists

