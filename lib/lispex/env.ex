defmodule Lispex.Env do
  @moduledoc """
  environment for evaluation
  stdlib and user-defined env
  """
  @default %{
    :+ => fn x -> hd(x) + hd(tl(x)) end,
    :- => fn x -> hd(x) - hd(tl(x)) end,
    :* => fn x -> hd(x) * hd(tl(x)) end,
    :/ => fn x -> hd(x) / hd(tl(x)) end,
    :and => fn x -> hd(x) and hd(tl(x)) end,
    :or => fn x -> hd(x) or hd(tl(x)) end,
    :not => &(not(&1)),
    :lambda => fn [h | t] -> (fn ^h -> t end) end,
  }

  def new(env) do
    Map.merge(@default, env)
  end

  def put(k, v, env), do: %{env | k => v}
  def get(k, env) do
    case [Map.get(env, k), Map.get(env, :outer)] do
      [nil, nil] -> nil
      [nil, outer_env] -> get(k, outer_env)
      [val, _] -> val
    end
  end
end
