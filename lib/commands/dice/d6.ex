defmodule UtilRPG2.Commands.Dice.D6 do
  alias Nostrum.Struct.Interaction

  alias UtilRPG2.Util

  def get, do: %{
    name: "d6",
    description: "Rolls one or more d6s.",
    options: [
      %{
        type: 4,
        name: "amount",
        description: "Amount of d6s to roll (default 1).",
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
      content: Util.gen_roll_result(amt, 6, mod)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "amount", value: amt}]}}) do
    %{
      content: Util.gen_roll_result(amt, 6, 0)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "modifier", value: mod}]}}) do
    %{
      content: Util.gen_roll_result(1, 6, mod)
    }
  end

  def run(%Interaction{}) do
    %{
      content: Util.gen_roll_result(1, 6, 0)
    }
  end
end
