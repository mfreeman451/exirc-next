## ADDED Requirements

### Requirement: NAMES Command Support
The client SHALL support the IRC NAMES command (RFC 2812 Section 3.2.5) to request the list of visible users in a channel. The `names!/1` function SHALL send `NAMES <channel>` to the server including the channel argument.

#### Scenario: Client sends NAMES command for a specific channel
- **WHEN** the client calls `names(client, "#test")`
- **THEN** the command `NAMES #test` SHALL be sent to the IRC server

#### Scenario: RPL_NAMREPLY delivers a structured names list with role prefixes
- **WHEN** the server sends an RPL_NAMREPLY (353) for a channel
- **THEN** the client SHALL emit a `{:names_list, channel, names}` event where `names` is a list of nick strings with role prefixes preserved (e.g., `["@op_user", "+voice_user", "regular_user"]`)

#### Scenario: RPL_ENDOFNAMES signals completion
- **WHEN** the server sends an RPL_ENDOFNAMES (366) for a channel
- **THEN** the client SHALL emit a `{:end_of_names, channel}` event to signal that the full names list has been received

#### Scenario: Channel user tracking still strips prefixes
- **WHEN** the server sends RPL_NAMREPLY with prefixed nicks
- **THEN** the internal channel user list SHALL continue to store nicks without prefixes (existing `trim_rank/1` behavior preserved)
