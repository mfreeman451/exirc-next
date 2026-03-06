import Config

config :exirc_example,
  bots: [
    %{
      server: "irc.libera.chat",
      port: 6667,
      nick: "exirc-example",
      user: "exirc-example",
      name: "ExIRC Example Bot",
      channel: "#exirc-test"
    }
  ]
