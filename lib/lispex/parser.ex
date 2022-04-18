defmodule Lispex.Parser do
  @moduledoc """
  lexical and syntactic analysis
  (lambda (x) (+ 1 x))
  -> ["(", "lambda", "(", "x", ")", "(" ,"+", "1", "x", ")", ")"]
  -> ["lambda", ["x"], ["+", 1, "x"]]
  """
  def parse(str) do
    tokens = tokenlize(str)
    cond do
      length(tokens) == 0 -> {:error, :empty}
      Enum.count(tokens, &(&1=="(")) != Enum.count(tokens, &(&1==")")) ->
        {:error, "brackets don't match"}
      true -> parse_tokens(tokens, []) |> hd()
    end
  end

  def tokenlize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
  end

  # On'(' make a new subtree
  def parse_tokens(["(" | t], acc) do
    {rem_tokens, sub_tree} = parse_tokens(t, [])
    parse_tokens(rem_tokens, [sub_tree | acc])
  end
  # On ')' accumulate the current sub tree in the parent tree
  def parse_tokens([")" | t], acc), do: {t, Enum.reverse(acc)}
  # On end of tokens roll back and start accumulating
  def parse_tokens([], acc), do: Enum.reverse(acc)
  # On a symbol accumulate it and parse remaining tokens
  def parse_tokens([h | t], acc), do: parse_tokens(t, [atom(h) | acc])

  defp atom(str) do
    try do
      String.to_integer(str)
    rescue
      _e in ArgumentError -> try do
        String.to_float(str)
      rescue
        _e in ArgumentError -> String.to_atom(str)
      end
    end
  end
end
