defmodule ExIRC.Logger do
  @moduledoc """
  A simple logging abstraction wrapping Elixir's Logger.
  """

  require Logger

  @doc """
  Log an informational message.
  """
  @spec info(binary) :: :ok
  def info(msg) do
    Logger.info(msg)
  end

  @doc """
  Log a warning message.
  """
  @spec warning(binary) :: :ok
  def warning(msg) do
    Logger.warning(msg)
  end

  @doc """
  Log an error message.
  """
  @spec error(binary) :: :ok
  def error(msg) do
    Logger.error(msg)
  end
end
