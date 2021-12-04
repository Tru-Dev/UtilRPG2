defmodule UtilRPG2.Util do
  @spec roll(amt :: pos_integer, die :: pos_integer) :: {list(pos_integer), pos_integer}
  def roll(amt, die) do
    l = roll_list(amt, die, [Enum.random(1..die)])
    {l, Enum.sum(l)}
  end

  @spec roll_list(amtrem :: pos_integer, die :: pos_integer, l :: list(pos_integer)) :: list(pos_integer)
  defp roll_list(amtrem, die, l) when amtrem > 1 do
    roll_list(amtrem - 1, die, [Enum.random(1..die)] ++ l)
  end

  defp roll_list(1, _, l) do
    l
  end

  def gen_roll_result(1, die, 0) do
    {_, result} = roll(1, die)
    "You rolled a #{result} (d#{die})."
  end

  def gen_roll_result(amt, die, 0) when amt > 1 do
    {rolls, result} = roll(amt, die)
    "You rolled **#{amt}d#{die}**: #{inspect(rolls, charlists: :as_list)}, totaling #{result}."
  end

  def gen_roll_result(1, die, mod) do
    {_, result} = roll(1, die)
    modstr = if mod < 0, do: "#{mod}", else: "+#{mod}"
    modres = result + mod
    "You rolled a #{modres} (d#{die}#{modstr}, original #{result})."
  end

  def gen_roll_result(amt, die, mod) when amt > 1 do
    {rolls, result} = roll(amt, die)
    modstr = if mod < 0, do: "#{mod}", else: "+#{mod}"
    modres = result + mod
    "You rolled **#{amt}d#{die}#{modstr}**: #{inspect(rolls, charlists: :as_list)}, totaling #{modres} (original #{result})."
  end
end
