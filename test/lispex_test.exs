defmodule LispexTest do
  use ExUnit.Case
  doctest Lispex

  test "parse a variable" do
    assert Lispex.Parser.parse("a") == :a
  end
  test "parse a lisp expression" do
    assert Lispex.Parser.parse("(def add1 (lambda (x) (+ 1 x)))") ==
      [:def, :add1, [:lambda, [:x], [:+, 1, :x]]]
  end
  test "nested bracket" do
    assert Lispex.Parser.parse("(())") == [[]]
  end
  test "brackets don't match returns an error" do
    assert Lispex.Parser.parse("()))") == {:error, "brackets don't match"}
  end
  test "empty input returns error empty" do
    assert Lispex.Parser.parse("") == {:error, :empty}
  end

end
