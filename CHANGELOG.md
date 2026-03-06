# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0] - 2026-03-05

### Changed
* **BREAKING** Renamed Hex package from `exirc` to `exirc_next`
* **BREAKING** Bumped minimum Elixir version to `~> 1.17`
* **BREAKING** Bumped minimum OTP version to 27+
* Replaced deprecated `:error_logger` with Elixir `Logger` module in `ExIRC.Logger`
* Switched `applications` to `extra_applications` in `mix.exs`
* Migrated deprecated `preferred_cli_env` to `def cli`
* Updated `ex_doc` to `~> 0.35`, `excoveralls` to `~> 0.18`
* Migrated charlist syntax from `''` to `~c""` sigil
* Replaced deprecated `List.zip/1` with `Enum.zip/1`
* Fixed struct update warnings (use map updates where appropriate)
* Fixed string interpolation of `SenderInfo` struct in debug logging
* Formatted entire codebase with `mix format --migrate`
* Added `@moduledoc` to all public modules
* Fixed all Credo strict issues (alias ordering, trailing whitespace, zero-arity parens, implicit try)
* Updated GitHub Actions CI to modern Elixir/OTP with caching
* Updated package metadata for fork (maintainers, links)

### Added
* `credo` (`~> 1.7`) for static analysis with `.credo.exs` config
* `dialyxir` (`~> 1.4`) for type checking
* `mix_audit` (`~> 2.1`) for dependency security auditing
* `sobelow` (`~> 0.13`) for security static analysis
* `.formatter.exs` for consistent code formatting
* CI quality gates: `mix format --check-formatted`, `mix credo --strict`, `mix deps.audit`, `mix sobelow`

### Removed
* Legacy `.travis.yml` CI configuration
* `IO.inspect` calls from client and example handler

## [2.0.0] - 2020-07-19

* Update Deprecated `:simple_one_to_one` to use DynamicSupervisor [#89](https://github.com/bitwalker/exirc/pull/89)
* Switch to GitHub Actions for CI [#90](https://github.com/bitwalker/exirc/pull/90)
* Start a Changelog for the 2.0.0 release series [#91](https://github.com/bitwalker/exirc/pull/91)
