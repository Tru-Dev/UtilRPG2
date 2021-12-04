defmodule UtilRPG2.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:READY, _msg, _ws_state}) do
    Api.update_status(:online, "some D&D")
    UtilRPG2.Interactions.register_cmds()
  end

  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    case interaction.type do
      2 -> UtilRPG2.Interactions.handle_cmd(interaction)
      _ -> nil
    end
  end

  def handle_event(_event) do
    :noop
  end
end
