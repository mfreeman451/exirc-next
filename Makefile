.PHONY: lint test publish deps

deps:
	mix deps.get

lint:
	mix compile --warnings-as-errors
	mix format --check-formatted
	mix credo --strict
	mix dialyzer
	mix deps.audit
	mix sobelow --config

test:
	mix test

publish: lint test
	mix hex.publish
