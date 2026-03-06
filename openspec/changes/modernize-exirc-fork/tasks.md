## 1. Project Configuration & Tooling
- [x] 1.1 Update `mix.exs` — rename app to `:exirc_next`, bump version to `3.0.0`, bump Elixir to `~> 1.17`, update package metadata for fork
- [x] 1.2 Update `mix.exs` — switch `applications` to `extra_applications` in `application/0`
- [x] 1.3 Update dependencies — bump `ex_doc` and `excoveralls` to latest versions
- [x] 1.4 Add `credo` as a dev dependency
- [x] 1.5 Add `dialyxir` as a dev dependency
- [x] 1.6 Add `mix_audit` as a dev dependency (dependency security auditing)
- [x] 1.7 Add `sobelow` as a dev dependency (security static analysis)
- [x] 1.8 Create `.credo.exs` with project-appropriate configuration
- [x] 1.9 Create `.formatter.exs` with project formatting rules
- [x] 1.10 Remove legacy `.travis.yml`

## 2. Logger Modernization
- [x] 2.1 Replace `ExIRC.Logger` module — swap `:error_logger` calls with Elixir `Logger`
- [x] 2.2 Remove `String.to_charlist` conversions no longer needed after Logger switch
- [x] 2.3 Update any modules that call `ExIRC.Logger` if the API changes

## 3. Code Modernization
- [x] 3.1 Run `mix format --migrate` across the entire codebase (charlist `''` → `~c""`, formatting)
- [x] 3.2 Add `@moduledoc` to all modules missing documentation
- [x] 3.3 Run `mix credo --strict` and fix reported issues
- [x] 3.4 Review and update typespecs for correctness and completeness (fixed `List.zip` → `Enum.zip`, added `@type t` to ClientState and Message)
- [x] 3.5 Modernize pattern matching and syntax where it improves clarity (fixed `preferred_cli_env` → `def cli`, struct updates → map updates)
- [x] 3.6 Clean up `ExIRC.Client` — fixed alias ordering, removed `IO.inspect` calls, cleaned up duplicate `@doc` attributes

## 4. Testing & CI
- [x] 4.1 Ensure all existing tests pass on Elixir 1.17+ / OTP 27+ (50 tests, 0 failures)
- [x] 4.2 Update GitHub Actions CI matrix to target Elixir 1.17/1.18/1.19 and OTP 27/28
- [x] 4.3 Add `mix credo --strict` to CI pipeline
- [x] 4.4 Add `mix dialyzer` to CI pipeline (passes with 0 errors)
- [x] 4.5 Add `mix format --check-formatted` to CI pipeline
- [x] 4.6 Add `mix deps.audit` to CI pipeline
- [x] 4.7 Add `mix sobelow` to CI pipeline

## 5. Documentation & Cleanup
- [x] 5.1 Update README to reflect fork status, new requirements, and updated usage
- [x] 5.2 Update CHANGELOG with modernization entry
- [x] 5.3 Remove or update example projects to work with modern Elixir
- [x] 5.4 Update `openspec/project.md` to reflect new tech stack and conventions
