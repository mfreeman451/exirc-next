## ADDED Requirements

### Requirement: Modern Elixir and OTP Versions
The project SHALL require Elixir `~> 1.17` and OTP 27+ as minimum supported versions. The `mix.exs` SHALL specify these version constraints.

#### Scenario: Project compiles on Elixir 1.17
- **WHEN** running `mix compile` with Elixir 1.17 and OTP 27
- **THEN** the project compiles without errors or deprecation warnings

#### Scenario: Project rejects unsupported Elixir version
- **WHEN** running `mix compile` with Elixir < 1.17
- **THEN** mix reports an incompatible Elixir version error

### Requirement: Credo Static Analysis
The project SHALL include Credo as a dev dependency with a `.credo.exs` configuration file. The codebase SHALL pass `mix credo --strict` without errors.

#### Scenario: Credo passes in strict mode
- **WHEN** running `mix credo --strict`
- **THEN** no issues are reported

#### Scenario: Credo configuration exists
- **WHEN** a developer clones the project
- **THEN** a `.credo.exs` file exists at the project root with project-appropriate rules

### Requirement: Code Formatting
The project SHALL include a `.formatter.exs` configuration file. All source code SHALL be formatted according to `mix format`.

#### Scenario: Formatted code check passes
- **WHEN** running `mix format --check-formatted`
- **THEN** no formatting differences are reported

### Requirement: Dialyxir Type Checking
The project SHALL include Dialyxir as a dev dependency. All typespecs SHALL be valid and consistent.

#### Scenario: Dialyzer passes
- **WHEN** running `mix dialyzer`
- **THEN** no warnings are reported

### Requirement: Package Rename and Versioning
The Hex package SHALL be renamed from `exirc` to `exirc_next`. The version SHALL be bumped to `3.0.0`. The app atom in `mix.exs` SHALL be `:exirc_next`.

#### Scenario: Package identity reflects fork
- **WHEN** inspecting `mix.exs` project configuration
- **THEN** the app is `:exirc_next` at version `"3.0.0"`

#### Scenario: Dependency declaration works
- **WHEN** a consumer adds `{:exirc_next, "~> 3.0"}` to their deps
- **THEN** the package resolves and compiles correctly

### Requirement: Modern Mix Configuration
The `mix.exs` SHALL use `extra_applications` instead of `applications` in the `application/0` function. Package metadata SHALL reflect the fork's maintainership and repository links.

#### Scenario: Application starts correctly
- **WHEN** the application is started
- **THEN** all required OTP applications (`:logger`, `:ssl`, `:crypto`) are available

#### Scenario: Package metadata reflects fork
- **WHEN** inspecting `mix.exs` package configuration
- **THEN** maintainers, links, and description reflect the fork, not the upstream project

### Requirement: Dependency Security Auditing
The project SHALL include `mix_audit` as a dev dependency. The `mix deps.audit` command SHALL check for known vulnerabilities in dependencies.

#### Scenario: Dependency audit passes
- **WHEN** running `mix deps.audit`
- **THEN** no known vulnerabilities are reported in project dependencies

### Requirement: Security Static Analysis
The project SHALL include `sobelow` as a dev dependency for security-focused static analysis.

#### Scenario: Sobelow passes
- **WHEN** running `mix sobelow`
- **THEN** no security issues are reported

### Requirement: CI Pipeline Quality Gates
The GitHub Actions CI pipeline SHALL run formatting checks, Credo, Dialyzer, security audits, and tests on modern Elixir/OTP versions.

#### Scenario: CI runs all quality checks
- **WHEN** a commit is pushed or a PR is opened
- **THEN** CI runs `mix format --check-formatted`, `mix credo --strict`, `mix dialyzer`, `mix deps.audit`, `mix sobelow`, and `mix test`

#### Scenario: CI uses modern Elixir/OTP matrix
- **WHEN** CI is triggered
- **THEN** tests run against Elixir 1.17+ and OTP 27+
