# ExIRC Next

[![CI](https://github.com/mfreeman451/exirc/workflows/CI/badge.svg)](https://github.com/mfreeman451/exirc/actions)
[![Hex.pm Version](http://img.shields.io/hexpm/v/exirc_next.svg?style=flat)](https://hex.pm/packages/exirc_next)

A modern IRC client library for Elixir projects. Actively maintained fork of [bitwalker/exirc](https://github.com/bitwalker/exirc).

It aims to have a clear, well-documented API, with the minimal amount of code necessary to allow you to connect and communicate with IRC servers effectively. It implements the full RFC2812 protocol, and relevant parts of RFC1459.

## Requirements

- Elixir ~> 1.17
- OTP 27+

## Getting Started

Add ExIRC Next as a dependency to your project in `mix.exs`:

```elixir
defp deps do
  [{:exirc_next, "~> 3.0"}]
end
```

Then fetch it using `mix deps.get`.

To use ExIRC, you need to start a new client process and add event handlers. An example event handler module is located in `lib/exirc/example_handler.ex`. **The example handler is kept up to date with all events you can expect to receive from the client**.

There is also a variety of examples in `examples/`, the most up to date of which is `examples/bot`.

```elixir
defmodule MyBot do
  use GenServer

  defmodule State do
    defstruct host: "irc.libera.chat",
              port: 6667,
              pass: "",
              nick: "mybot",
              user: "mybot",
              name: "My Bot",
              client: nil,
              handlers: []
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, %State{})
  end

  def init(state) do
    # Start the client and handler processes
    {:ok, client} = ExIRC.start_link!()
    {:ok, handler} = ExampleHandler.start_link(nil)

    # Register the event handler with ExIRC
    ExIRC.Client.add_handler(client, handler)

    # Connect and logon to a server, join a channel and send a simple message
    ExIRC.Client.connect!(client, state.host, state.port)
    ExIRC.Client.logon(client, state.pass, state.nick, state.user, state.name)
    ExIRC.Client.join(client, "#elixir-lang")
    ExIRC.Client.msg(client, :privmsg, "#elixir-lang", "Hello world!")

    {:ok, %{state | client: client, handlers: [handler]}}
  end

  def terminate(_, state) do
    ExIRC.Client.quit(state.client, "Goodbye, cruel world.")
    ExIRC.Client.stop!(state.client)
    :ok
  end
end
```

A more robust example waits until connected before attempting to logon, and waits until logged on before joining channels. See the `examples` directory for more in-depth cases.

```elixir
defmodule ExampleApplication do
  use Application

  @impl true
  def start(_type, _args) do
    {:ok, client} = ExIRC.start_link!()

    children = [
      {ExampleConnectionHandler, client},
      {ExampleLoginHandler, [client, ["#mybot-testing"]]}
    ]

    opts = [strategy: :one_for_one, name: ExampleApplication.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule ExampleConnectionHandler do
  use GenServer

  defmodule State do
    defstruct host: "irc.libera.chat",
              port: 6667,
              pass: "",
              nick: "mybot",
              user: "mybot",
              name: "My Bot",
              client: nil
  end

  def start_link(client, state \\ %State{}) do
    GenServer.start_link(__MODULE__, [%{state | client: client}])
  end

  def init([state]) do
    ExIRC.Client.add_handler(state.client, self())
    ExIRC.Client.connect!(state.client, state.host, state.port)
    {:ok, state}
  end

  def handle_info({:connected, server, port}, state) do
    IO.puts("Connected to #{server}:#{port}")
    ExIRC.Client.logon(state.client, state.pass, state.nick, state.user, state.name)
    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end

defmodule ExampleLoginHandler do
  @moduledoc """
  Listens for login events and then joins the appropriate channels.
  """
  use GenServer

  def start_link(client, channels) do
    GenServer.start_link(__MODULE__, [client, channels])
  end

  def init([client, channels]) do
    ExIRC.Client.add_handler(client, self())
    {:ok, {client, channels}}
  end

  def handle_info(:logged_in, {client, channels} = state) do
    IO.puts("Logged in to server")
    Enum.each(channels, &ExIRC.Client.join(client, &1))
    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
```

## History

This project is a fork of [bitwalker/exirc](https://github.com/bitwalker/exirc), which is no longer actively maintained. ExIRC Next modernizes the codebase for current Elixir/OTP versions and adds contemporary tooling (Credo, Dialyxir, mix_audit, sobelow).

## License

MIT
