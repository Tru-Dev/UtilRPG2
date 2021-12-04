defmodule UtilRPG2.Commands.Dice.D8 do
  alias Nostrum.Struct.Interaction

  alias UtilRPG2.Util

  def get, do: %{
    name: "d8",
    description: "Rolls one or more d8s.",
    options: [
      %{
        type: 4,
        name: "amount",
        description: "Amount of d8s to roll (default 1).",
        min_value: 1,
      },
      %{
        type: 4,
        name: "modifier",
        description: "Amount to add or subtract from your roll(s).",
      },
    ]
  }

  def run(%Interaction{data: %{options: [%{name: "amount", value: amt}, %{name: "modifier", value: mod}]}}) do
    %{
      content: Util.gen_roll_result(amt, 8, mod)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "amount", value: amt}]}}) do
    %{
      content: Util.gen_roll_result(amt, 8, 0)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "modifier", value: mod}]}}) do
    %{
      content: Util.gen_roll_result(1, 8, mod)
    }
  end

  def run(%Interaction{}) do
    %{
      content: Util.gen_roll_result(1, 8, 0)
    }
  end
end
