defmodule Lispex.Eval do
  alias Lispex.Env

  def eval(x, env, _) do
    case env do
      nil -> eval(x, Env.new(%{}))
      _ -> eval(x, env)
    end
  end

  def eval(x, env) when is_number(x), do: {x, env}

  def eval(x, env) when is_atom(x), do: {Env.get(x, env), env}

  def eval([:define, symbol, exp], env) do
    {nil, %{env | symbol => elem(eval(exp, env), 0)}}
  end

  # def eval([:cond, [cond0, exp0] | t], env) do

  # end

  def eval(x, env) when is_list(x) do
    proc = hd(x) |> eval(env) |> elem(0)
    [_ | exp] = x
    parent_env = env
    child_env = Env.new_env(env)
    args = compute_args(exp, child_env) |> Enum.into([], fn x -> elem(x, 0) end)
    {proc.(args), parent_env}
  end

  def compute_args([], _) do
    []
  end

  def compute_args([h | t], env) do
    {result, env} = eval(h, env)
    [{result, env} | compute_args(t, env)]
  end

end
