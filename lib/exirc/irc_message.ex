defmodule ExIRC.Message do
  @moduledoc """
  Represents a parsed IRC message.
  """
  @type t :: %__MODULE__{}
  defstruct server: ~c"",
            nick: ~c"",
            user: ~c"",
            host: ~c"",
            ctcp: nil,
            cmd: ~c"",
            args: []
end
