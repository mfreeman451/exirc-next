# Change: Modernize ExIRC as Standalone Fork (exirc_next v3.0.0)

## Why
The upstream exirc library (bitwalker/exirc) appears abandoned — last meaningful commit was years ago, targeting Elixir 1.6 and OTP 21. This fork needs to become a fully standalone, modern Elixir library that targets current Elixir/OTP versions, uses contemporary tooling (Credo, formatter), and follows modern Elixir best practices throughout the codebase.

## What Changes
- **BREAKING** Rename Hex package from `exirc` to `exirc_next`
- **BREAKING** Bump version to `3.0.0`
- **BREAKING** Bump minimum Elixir version from `~> 1.6` to `~> 1.17` (current stable)
- **BREAKING** Bump minimum OTP version to 27+
- Update `mix.exs` metadata to reflect the fork (maintainers, links, description)
- Add Credo for static analysis with a project `.credo.exs` config
- Add `.formatter.exs` and format the entire codebase with `mix format`
- Replace deprecated `:error_logger` with Elixir's `Logger` module
- Update dependencies (`ex_doc`, `excoveralls`) to latest versions
- Add Dialyxir for static type checking
- Add `mix_audit` for dependency security auditing
- Add `sobelow` for Phoenix/Elixir security static analysis
- Remove legacy `.travis.yml` CI config
- Modernize code patterns:
  - Use modern `Logger` calls instead of `:error_logger`
  - Clean up module structure and ensure consistent use of `@moduledoc` / `@doc`
  - Update typespecs where needed
  - Leverage newer Elixir syntax and patterns where they improve clarity
- Update `application/0` in mix.exs to use `extra_applications` (modern convention)
- Update example code and README to reflect fork status

## Impact
- Affected specs: build-tooling, irc-client, code-quality
- Affected code: All lib/ files, mix.exs, test/ files, config, CI
- Users upgrading from upstream exirc will need Elixir 1.17+ and OTP 27+
- Users will need to update their dependency from `{:exirc, ...}` to `{:exirc_next, "~> 3.0"}`
