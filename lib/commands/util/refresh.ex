defmodule UtilRPG2.Commands.Util.Refresh do
  alias Nostrum.Struct.Interaction

  alias UtilRPG2.Util

  alias UtilRPG2.Interactions

  def get, do: %{
    name: "refresh",
    description: "Owner-only, refreshes the bot's commands.",
    default_permissions: false,
  }

  def run(_) do
    Interactions.register_cmds()
    %{
      content: "Check your console logs to see if it was a success."
    }
  end
end
