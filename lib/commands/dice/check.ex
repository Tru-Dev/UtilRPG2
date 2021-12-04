defmodule UtilRPG2.Commands.Dice.Check do
  alias Nostrum.Struct.Interaction

  alias UtilRPG2.Util

  def get, do: %{
    name: "check",
    description: "Makes a d20-based ability check.",
    options: [
      %{
        type: 3,
        name: "advantage",
        description: "Roll with advantage or disadvantage.",
        choices: [
          %{name: "advantage", value: "advantage"},
          %{name: "disadvantage", value: "disadvantage"},
        ]
      },
      %{
        type: 4,
        name: "modifier",
        description: "Modifier applied to check.",
      },
    ]
  }

  def run(%Interaction{data: %{options: [
    %{name: "advantage", value: "advantage"},
    %{name: "modifier", value: mod}
  ]}}) do
    %{
      content: gen_adv_check(mod)
    }
  end

  def run(%Interaction{data: %{options: [
    %{name: "advantage", value: "disadvantage"},
    %{name: "modifier", value: mod}
  ]}}) do
    %{
      content: gen_dis_check(mod)
    }
  end

  def run(%Interaction{data: %{options: [
    %{name: "advantage", value: "advantage"},
  ]}}) do
    %{
      content: gen_adv_check(0)
    }
  end

  def run(%Interaction{data: %{options: [
    %{name: "advantage", value: "disadvantage"},
  ]}}) do
    %{
      content: gen_dis_check(0)
    }
  end

  def run(%Interaction{data: %{options: [%{name: "modifier", value: mod}]}}) do
    %{
      content: gen_check(mod)
    }
  end

  def run(%Interaction{}) do
    %{
      content: gen_check(0)
    }
  end

  defp gen_check(0) do
    r = Enum.random(1..20)
    nat = case r do
      1 -> "\nCritical fail... (Nat 1)"
      20 -> "\nCritical Success! (Nat 20)"
      _ -> ""
    end
    "You rolled a #{r}.#{nat}"
  end

  defp gen_check(mod) do
    r = Enum.random(1..20)
    modstr = if mod < 0, do: "#{mod}", else: "+#{mod}"
    nat = case r do
      1 -> "\nCritical fail... (Nat 1)"
      20 -> "\nCritical Success! (Nat 20)"
      _ -> ""
    end
    mr = r + mod
    "You rolled a #{mr} (#{r}#{modstr}).#{nat}"
  end

  defp gen_adv_check(0) do
    r1 = Enum.random(1..20)
    r2 = Enum.random(1..20)
    r = max(r1, r2)
    nat = case r do
      1 -> "\nCritical fail... (Nat 1)"
      20 -> "\nCritical Success! (Nat 20)"
      _ -> ""
    end
    "You rolled a #{r} (#{r1}, #{r2}, advantage).#{nat}"
  end

  defp gen_adv_check(mod) do
    r1 = Enum.random(1..20)
    r2 = Enum.random(1..20)
    r = max(r1, r2)
    nat = case r do
      1 -> "\nCritical fail... (Nat 1)"
      20 -> "\nCritical Success! (Nat 20)"
      _ -> ""
    end
    modstr = if mod < 0, do: "#{mod}", else: "+#{mod}"
    mr = r + mod
    "You rolled a #{mr} (#{r1}, #{r2}, mod #{modstr}, advantage).#{nat}"
  end

  defp gen_dis_check(0) do
    r1 = Enum.random(1..20)
    r2 = Enum.random(1..20)
    r = min(r1, r2)
    nat = case r do
      1 -> "\nCritical fail... (Nat 1)"
      20 -> "\nCritical Success! (Nat 20)"
      _ -> ""
    end
    "You rolled a #{r} (#{r1}, #{r2}, disadvantage).#{nat}"
  end

  defp gen_dis_check(mod) do
    r1 = Enum.random(1..20)
    r2 = Enum.random(1..20)
    r = min(r1, r2)
    nat = case r do
      1 -> "\nCritical fail... (Nat 1)"
      20 -> "\nCritical Success! (Nat 20)"
      _ -> ""
    end
    modstr = if mod < 0, do: "#{mod}", else: "+#{mod}"
    mr = r + mod
    "You rolled a #{mr} (#{r1}, #{r2}, mod #{modstr}, disadvantage).#{nat}"
  end
end
