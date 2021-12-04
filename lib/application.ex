defmodule UtilRPG2.Application do
  @moduledoc """
  Entrypoint for UtilRPG2.
  """

  use Application

  def start(_type, _args) do
    Supervisor.start_link([UtilRPG2.Consumer], strategy: :one_for_one)
  end

end
