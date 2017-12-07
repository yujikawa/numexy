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

  test "add vector and scalar" do
    x = Numexy.new([1,2,3])
    y = 4
    v = Numexy.add(x, y)
    assert v.array == [5,6,7]
    assert v.shape == {3, nil}
    v = Numexy.add(y, x)
    assert v.array == [5,6,7]
    assert v.shape == {3, nil}
  end

  test "add vector and vector" do
    x = Numexy.new([1,2,3])
    y = Numexy.new([4,5,2])
    v = Numexy.add(x, y)
    assert v.array == [5,7,5]
    assert v.shape == {3, nil}
  end

  test "add matrix and scalar" do
    x = Numexy.new([[1,2,3],[4,5,6]])
    y = 4
    m = Numexy.add(x, y)
    assert m.array == [[5,6,7],[8,9,10]]
    assert m.shape == {2, 3}
    x = 4
    y = Numexy.new([[1,2,3],[4,5,6]])
    m = Numexy.add(x, y)
    assert m.array == [[5,6,7],[8,9,10]]
    assert m.shape == {2, 3}
  end

  test "add matrix and matrix" do
    x = Numexy.new([[1,2,3],[4,5,6]])
    y = Numexy.new([[4,5,2],[1,7,3]])
    m = Numexy.add(x, y)
    assert m.array == [[5,7,5],[5,12,9]]
    assert m.shape == {2, 3}
  end

  test "multiplication vector and scalar" do
    x = Numexy.new([1,2,3])
    y = 3
    v = Numexy.mul(x, y)
    assert v.array == [3,6,9]
    assert v.shape == {3, nil}
  end

  test "multiplication vector and vector" do
    x = Numexy.new([1,2,3])
    y = Numexy.new([4,5,2])
    v = Numexy.mul(x, y)
    assert v.array == [4,10,6]
    assert v.shape == {3, nil}
  end

  test "multiplication matrix and scalar" do
    x = Numexy.new([[1,2,3],[4,5,6]])
    y = 4
    m = Numexy.mul(x, y)
    assert m.array == [[4,8,12],[16,20,24]]
    assert m.shape == {2, 3}
    x = 4
    y = Numexy.new([[1,2,3],[4,5,6]])
    m = Numexy.mul(x, y)
    assert m.array == [[4,8,12],[16,20,24]]
    assert m.shape == {2, 3}
  end

  test "multiplication matrix and matrix" do
    x = Numexy.new([[1,2,3],[4,5,6]])
    y = Numexy.new([[4,5,2],[1,7,3]])
    m = Numexy.mul(x, y)
    assert m.array == [[4,10,6],[4,35,18]]
    assert m.shape == {2, 3}
  end

  test "inner product (vector and vector)" do
    x = Numexy.new([1,2,3])
    y = Numexy.new([1,2,3])
    assert Numexy.dot(x, y) == 14
  end

  test "inner product (matrix and vector)" do
    x = Numexy.new([[1,6,4],[2,9,5]])
    y = Numexy.new([1,2,3])
    m = Numexy.dot(x, y)
    assert m.array == [25, 35]
    assert m.shape == {2, nil}
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

  test "vector sum." do
    v = Numexy.new([2,9,5])
    assert 16 == Numexy.sum(v)
  end

  test "matrix sum." do
    m = Numexy.new([[1,2,3],[4,5,6]])
    assert 21 == Numexy.sum(m)
  end

  test "vector avarage." do
    v = Numexy.new([2,9,5])
    assert 5.333333333333333 == Numexy.avg(v)
  end

  test "matrix avarage." do
    m = Numexy.new([[1,2,3],[4,5,6]])
    assert 3.5 == Numexy.avg(m)
  end

end
