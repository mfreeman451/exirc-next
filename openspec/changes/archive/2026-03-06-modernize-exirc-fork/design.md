## Context
ExIRC is forked from bitwalker/exirc, which targets Elixir 1.6 / OTP 21. Upstream is inactive. This fork must modernize to current Elixir/OTP while preserving the existing public API and IRC protocol behavior. The change is cross-cutting — it touches every module, the build system, CI, and documentation.

## Goals / Non-Goals
- Goals:
  - Target Elixir 1.17+ / OTP 27+ as minimum supported versions
  - Add Credo and Dialyxir for code quality enforcement
  - Replace all deprecated APIs (`:error_logger`)
  - Format the entire codebase with `mix format`
  - Establish CI gates for formatting, Credo, and Dialyzer
- Non-Goals:
  - Changing the public API surface (connect, logon, join, msg, handler pattern)
  - Adding new IRC protocol features (that's a separate proposal)
  - Rewriting the core GenServer architecture
  - Changing the event handler dispatch pattern
  - Changing internal module names from `ExIRC.*` (kept for API compatibility despite package rename)

## Decisions
- **Elixir ~> 1.17**: This is the current stable release. Skipping intermediate versions since upstream is dead and there's no existing user base to migrate gradually.
  - Alternative: `~> 1.15` for broader compatibility — rejected because there's no reason to support older versions for a fresh fork.
- **Logger module over :error_logger**: Direct replacement. The `ExIRC.Logger` wrapper module will be updated to delegate to Elixir's `Logger` with appropriate levels (`Logger.info`, `Logger.warning`, `Logger.error`).
  - Alternative: Remove the wrapper entirely and call `Logger` directly everywhere — considered but the wrapper provides a single place to adjust log metadata or behavior.
- **Credo strict mode**: Enforces consistent style. Will use a custom `.credo.exs` to disable checks that don't fit the project (e.g., module doc requirements for internal structs may be relaxed).
- **Dialyxir**: Added for typespec validation. Will not block CI initially if there are pre-existing issues — first pass will fix obvious spec errors, then enable `--halt-exit-status` once clean.
- **Package rename to `exirc_next`**: Clean break from upstream. The app atom becomes `:exirc_next` in mix.exs, but internal module names (`ExIRC.*`) stay the same to minimize code churn. Users add `{:exirc_next, "~> 3.0"}` to their deps.
- **Version 3.0.0**: Signals breaking changes (Elixir version, package rename). Follows semver — major bump for incompatible changes.
- **mix_audit**: Adds `mix deps.audit` for checking known vulnerabilities in dependencies. Zero-config, runs against the Elixir security advisories database.
- **sobelow**: Security-focused static analysis. While primarily aimed at Phoenix apps, it catches general Elixir security issues (hardcoded secrets, unsafe deserialization, directory traversal). Useful as a safety net.

## Risks / Trade-offs
- **Breaking change for any existing users** — Mitigated by the fact that upstream is dead and this is a new fork. Semantic versioning bump to 3.0.0 and package rename to `exirc_next` signal the clean break.
- **Formatter may change test expectations** — Run tests after formatting to catch any string-comparison issues. Low risk since IRC protocol strings are in test data, not code formatting.
- **Dialyzer initial noise** — May surface many warnings in first pass. Plan: fix obvious issues, suppress or `@dialyzer` annotate acceptable ones, enable strict CI gate once clean.

## Migration Plan
1. Update mix.exs and deps first (get the project compiling on modern Elixir)
2. Fix Logger deprecation (small, isolated change)
3. Add formatter and format codebase (pure whitespace/style change)
4. Add Credo and fix issues (style fixes, no behavior changes)
5. Add Dialyxir and address type issues (spec fixes)
6. Update CI, docs, and examples last
- Rollback: Each step is independently revertible via git

## Resolved Questions
- **Package name**: Renamed to `exirc_next` for clean separation from upstream
- **Version**: Bumped to `3.0.0` to signal breaking changes
- **Additional dev tools**: Added `mix_audit` and `sobelow` for security auditing
