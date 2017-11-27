defmodule NumexyTest do
  use ExUnit.Case
  doctest Numexy

  test "vector struct" do
    v = Numexy.new([1,2,3])
    assert v == %Array{array: [1,2,3], shape: {3, nil}}
  end

  #  test "matrix struct" do
  #    m = Numexy.new([[1,2,3],[1,2,3]])
  #    assert m.array == [[1,2,3],[1,2,3]]
  #    assert m.shape == {2, 3}
  #  end

  test "inner product (vector)" do
    x = Numexy.new([1,2,3])
    y = Numexy.new([1,2,3])
    assert Numexy.dot(x, y) == 14
  end

  #  test "inner product (matrix)" do
  #    x = Numexy.new([[1,2,3]])
  #    y = Numexy.new([[1,2,3],[1,2,3],[1,2,3]])
  #    assert Numexy.dot(x, y) == %Array{array: [[ 6, 12, 18]], shape: {1, 3}}
  #  end
end
