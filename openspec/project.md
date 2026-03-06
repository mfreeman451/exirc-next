# Project Context

## Purpose
ExIRC Next is a modern IRC client library for Elixir, forked from bitwalker/exirc. It provides a clean, well-documented API for connecting to and communicating with IRC servers. It aims to implement the full RFC2812 protocol and relevant parts of RFC1459. Published on Hex as the `exirc_next` package (v3.0.0).

## Tech Stack
- Elixir (~> 1.17)
- OTP 27+
- SSL/TLS support via Erlang's `:ssl` module
- Credo for static analysis
- Dialyxir for type checking
- mix_audit for dependency security auditing
- sobelow for security static analysis
- ExCoveralls for test coverage
- ExDoc for documentation generation
- GitHub Actions for CI

## Project Conventions

### Code Style
- Standard Elixir conventions with `snake_case` for functions and variables, `PascalCase` for modules
- All code formatted with `mix format` (`.formatter.exs` configured)
- All code passes `mix credo --strict`
- Public API functions use typespecs (`@spec`) and `@doc` annotations
- All public modules have `@moduledoc`; internal structs use `@moduledoc false`
- Bang (`!`) suffix on functions that start processes or perform connect operations (e.g., `start!`, `connect!`, `start_link!`)
- Uses Elixir `Logger` module (not `:error_logger`) via `ExIRC.Logger` wrapper
- Module aliases are declared at the top of modules in alphabetical order

### Architecture Patterns
- **OTP Application**: `ExIRC.App` is the application entry point, starts a `DynamicSupervisor`
- **DynamicSupervisor**: `ExIRC` module acts as the supervisor, managing temporary `ExIRC.Client` child processes
- **GenServer clients**: Each IRC connection is a `ExIRC.Client` GenServer process with its own `ClientState` struct
- **Event handler pattern**: Consumers register handler pids via `add_handler/2`; the client sends events as plain messages (e.g., `:logged_in`, `{:received, message, sender}`, `{:joined, channel}`)
- **Transport abstraction**: `ExIRC.Client.Transport` wraps TCP/SSL socket operations so the client code is protocol-agnostic
- **Owner process linking**: Clients monitor their owner process and terminate if the owner dies
- **Key modules**:
  - `ExIRC` — DynamicSupervisor, top-level API for starting clients
  - `ExIRC.Client` — GenServer managing a single IRC connection, handles all IRC protocol events
  - `ExIRC.Commands` — macros/functions for building raw IRC command strings (used via `use ExIRC.Commands`)
  - `ExIRC.Utils` — IRC message parsing, server capability handling
  - `ExIRC.Channels` — channel state management (users, topics, types)
  - `ExIRC.Whois` / `ExIRC.Who` — structs for WHOIS/WHO query results
  - `ExIRC.SenderInfo` — struct representing a message sender (nick, host, user)
  - `ExIRC.Message` (`ExIRC.IrcMessage`) — struct for parsed IRC messages

### Testing Strategy
- Uses ExUnit with `async: false` for client tests (due to process-based state)
- Tests exercise `handle_data/2` directly by constructing `ExIRC.Message` structs and asserting on events received by the test process (registered as an event handler)
- Separate test files for channels, client, commands, and utils
- Coverage tracked via ExCoveralls
- CI runs on Elixir 1.17+ / OTP 27+

### Git Workflow
- Main branch: `master`
- PRs merged into `master`
- GitHub Actions CI runs tests, formatting, Credo, security audits on push
- Changelog follows Keep a Changelog format with Semantic Versioning

## Domain Context
- IRC (Internet Relay Chat) is a text-based communication protocol defined by RFC1459 and RFC2812
- Key IRC concepts: servers, channels (prefixed with `#`), nicks, messages (PRIVMSG, NOTICE), modes, topics, WHOIS/WHO queries
- Connection lifecycle: connect (TCP/SSL) -> logon (PASS/NICK/USER) -> join channels -> send/receive messages -> quit
- The client must handle PING/PONG keepalive (auto-ping enabled by default)
- Channel types are indicated by prefix characters; user prefixes indicate roles (operator `@`, voice `+`, etc.)
- CTCP (Client-To-Client Protocol) messages are supported for actions like `/me`

## Important Constraints
- Minimum Elixir version: 1.17
- Minimum OTP version: 27
- No external runtime dependencies (only `:logger`, `:ssl`, `:crypto`, `:inets` from OTP)
- Client processes are temporary (not restarted by the supervisor on crash)
- The library is designed to be embedded in user applications, not run standalone

## External Dependencies
- No external runtime dependencies beyond OTP
- Dev-only: `ex_doc`, `credo`, `dialyxir`, `mix_audit`, `sobelow`
- Test-only: `excoveralls` for coverage reporting
