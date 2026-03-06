defmodule Example do
  use Application

  alias Example.Bot

  @impl true
  def start(_type, _args) do
    children =
      Application.get_env(:exirc_example, :bots)
      |> Enum.map(fn bot -> {Bot, bot} end)

    opts = [strategy: :one_for_one, name: Example.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
