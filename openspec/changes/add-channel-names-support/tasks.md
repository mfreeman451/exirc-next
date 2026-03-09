## 1. Fix NAMES command
- [x] 1.1 Fix `names!/1` in `ExIRC.Commands` to send `NAMES <channel>` instead of bare `NAMES`

## 2. Improve NAMES event handling
- [x] 2.1 Update `RPL_NAMREPLY` handler to send a list of nick strings (with prefixes preserved) in the `:names_list` event
- [x] 2.2 Add `RPL_ENDOFNAMES` (366) handler in `ExIRC.Client` that emits an `:end_of_names` event

## 3. Tests
- [x] 3.1 Add test for `names!/1` producing the correct IRC command
- [x] 3.2 Add test for `RPL_NAMREPLY` handler emitting `:names_list` with a structured list including prefixes
- [x] 3.3 Add test for `RPL_ENDOFNAMES` handler emitting `:end_of_names` event
