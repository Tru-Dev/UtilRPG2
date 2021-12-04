defmodule UtilRPG2.Commands.Dice.Roll do
  alias Nostrum.Struct.Interaction

  alias UtilRPG2.Util

  def get, do: %{
    name: "roll",
    description: "Rolls one or more dice of a kind.",
    options: [
      %{
        type: 4,
        name: "kind",
        description: "Kind of dice to roll. Required.",
        min_value: 2,
        required: true,
      },
      %{
        type: 4,
        name: "amount",
        description: "Amount of dice to roll (default 1).",
        min_value: 1,
      },
      %{
        type: 4,
        name: "modifier",
        description: "Amount to add or subtract from your roll(s).",
      },
    ]
  }

  def run(%Interaction{data: %{options: [
    %{name: "kind", value: die},
    %{name: "amount", value: amt},
    %{name: "modifier", value: mod}
  ]}}) do
    %{
      content: Util.gen_roll_result(amt, die, mod)
    }
  end

  def run(%Interaction{data: %{options: [
    %{name: "kind", value: die},
    %{name: "amount", value: amt}
  ]}}) do
    %{
      content: Util.gen_roll_result(amt, die, 0)
    }
  end

  def run(%Interaction{data: %{options: [
    %{name: "kind", value: die},
    %{name: "modifier", value: mod}
  ]}}) do
    %{
      content: Util.gen_roll_result(1, die, mod)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "kind", value: die}]}}) do
    %{
      content: Util.gen_roll_result(1, die, 0)
    }
  end
end
