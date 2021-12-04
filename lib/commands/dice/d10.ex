defmodule UtilRPG2.Commands.Dice.D10 do
  alias Nostrum.Struct.Interaction

  alias UtilRPG2.Util

  def get, do: %{
    name: "d10",
    description: "Rolls one or more d10s.",
    options: [
      %{
        type: 4,
        name: "amount",
        description: "Amount of d10s to roll (default 1).",
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
      content: Util.gen_roll_result(amt, 10, mod)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "amount", value: amt}]}}) do
    %{
      content: Util.gen_roll_result(amt, 10, 0)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "modifier", value: mod}]}}) do
    %{
      content: Util.gen_roll_result(1, 10, mod)
    }
  end

  def run(%Interaction{}) do
    %{
      content: Util.gen_roll_result(1, 10, 0)
    }
  end
end
