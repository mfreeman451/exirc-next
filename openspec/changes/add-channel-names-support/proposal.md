# Change: Add proper NAMES command support for channel user listing

## Why
The IRC NAMES command (RFC 2812 Section 3.2.5) allows clients to request the list of users in a channel. ExIRC has partial NAMES support but it is broken: the `names!/1` command ignores its channel argument, user role prefixes are stripped from the names list event, and there is no `RPL_ENDOFNAMES` handling to signal when the full list has been received.

## What Changes
- Fix `names!/1` in `ExIRC.Commands` to actually send the channel name with the NAMES command
- Add `RPL_ENDOFNAMES` (366) handling in `ExIRC.Client` so consumers know when the names list is complete
- Send a structured names list (list of strings) in the `:names_list` event instead of a raw string
- Preserve user role prefixes (`@`, `+`, `%`, `&`, `~`) in the `:names_list` event so consumers can determine user roles
- Add an `:end_of_names` event that fires when `RPL_ENDOFNAMES` is received
- Add tests for the NAMES command flow

## Impact
- Affected specs: `irc-client`
- Affected code:
  - `lib/exirc/commands.ex` — fix `names!/1` to include channel argument
  - `lib/exirc/client.ex` — update `RPL_NAMREPLY` handler, add `RPL_ENDOFNAMES` handler
  - `test/client_test.exs` — add NAMES integration tests
