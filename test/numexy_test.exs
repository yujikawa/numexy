defmodule NumexyTest do
  use ExUnit.Case
  doctest Numexy

  test "vector struct" do
    v = Numexy.new([1,2,3])
    assert v.array == [1,2,3]
    assert v.shape == {3, nil}
  end

  test "matrix struct" do
    m = Numexy.new([[1,2,3],[1,2,3]])
    assert m.array == [[1,2,3],[1,2,3]]
    assert m.shape == {2, 3}
  end

  test "inner product (vector and vector)" do
    x = Numexy.new([1,2,3])
    y = Numexy.new([1,2,3])
    assert Numexy.dot(x, y) == 14
  end

  test "inner product (matrix and matrix)" do
    x = Numexy.new([[1,6,4],[2,9,5]])
    y = Numexy.new([[4,3],[7,5],[2,7]])
    m = Numexy.dot(x, y)
    assert m.array == [[54,61],[81,86]]
    assert m.shape == {2, 2}
  end

  test "transpose matrix." do
    x = Numexy.new([[4,3],[7,5],[2,7]])
    m = Numexy.transpose(x)
    assert m.array == [[4,7,2],[3,5,7]]
    assert m.shape == {2, 3}
  end

  #  test "inner product (matrix)" do
  #    x = Numexy.new([[1,2,3]])
  #    y = Numexy.new([[1,2,3],[1,2,3],[1,2,3]])
  #    assert Numexy.dot(x, y) == %Array{array: [[ 6, 12, 18]], shape: {1, 3}}
  #  end

  test "matrix ones." do
    m = Numexy.ones({2, 3})
    assert m.array == [[1,1,1],[1,1,1]]
    assert m.shape == {2, 3}
  end

  test "vector ones." do
    m = Numexy.ones({3, nil})
    assert m.array == [1,1,1]
    assert m.shape == {3, nil}
  end

  test "matrix zeros." do
    m = Numexy.zeros({2, 3})
    assert m.array == [[0,0,0],[0,0,0]]
    assert m.shape == {2, 3}
  end

  test "vector zeros." do
    m = Numexy.zeros({3, nil})
    assert m.array == [0,0,0]
    assert m.shape == {3, nil}
  end

end
