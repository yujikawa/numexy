defmodule Array do

  defstruct array: [], shape: {nil, nil}

end

defmodule Numexy do
  @moduledoc """
  Documentation for Numexy.
  """

  @doc """
  New matrix.

  ## Examples

      iex> Numexy.new([1,2,3])
      %Array{array: [1, 2, 3], shape: {3, nil}}
      iex> Numexy.new([[1,2,3],[1,2,3]])
      %Array{array: [[1, 2, 3], [1, 2, 3]], shape: {2, 3}}

  """
  def new(array), do: %Array{array: array, shape: {row_count(array), col_count(array)}}
  defp row_count(array), do: Enum.count(array)
  defp col_count([head| _ ]) when is_list(head), do: Enum.count(head)
  defp col_count(_), do: nil

  @doc """
  Add vector or matrix.

  ## Examples

      iex> x = Numexy.new([1,2,3])
      %Array{array: [1,2,3], shape: {3, nil}}
      iex> y = 4
      iex> Numexy.add(x, y)
      %Array{array: [5,6,7], shape: {3, nil}}
  """
  def add(%Array{array: v, shape: {_, nil}}, s) when is_number(s), do: Enum.map(v, &(&1+s)) |> new
  def add(s, %Array{array: v, shape: {_, nil}}) when is_number(s), do: Enum.map(v, &(&1+s)) |> new
  def add(%Array{array: xv, shape: {xv_row, nil}}, %Array{array: yv, shape: {yv_row, nil}}) when xv_row == yv_row do
    # vector + vector
    Enum.zip(xv, yv)
    |> Enum.map(fn({a,b})->a+b end)
    |> new
  end
  def add(%Array{array: xm, shape: xm_shape}, %Array{array: ym, shape: ym_shape}) when xm_shape == ym_shape do
    # matrix + matrix
    {_, xm_col} = xm_shape
    xv = List.flatten(xm)
    yv = List.flatten(ym)
    Enum.zip(xv,yv)
    |> Enum.map(fn({a,b})->a+b end)
    |> Enum.chunk_every(xm_col)
    |> new
  end
  def add(%Array{array: m, shape: {_, col}}, s) when col != nil do
    m
    |> Enum.map(&(Enum.map(&1,fn(x)->x+s end)))
    |> new
  end
  def add(s, %Array{array: m, shape: {_, col}}) when col != nil do
    m
    |> Enum.map(&(Enum.map(&1,fn(x)->x+s end)))
    |> new
  end

  @doc """
  Multiplication vector or matrix.

  ## Examples

      iex> x = Numexy.new([1,2,3])
      %Array{array: [1,2,3], shape: {3, nil}}
      iex> y = 4
      iex> Numexy.mul(x, y)
      %Array{array: [4,8,12], shape: {3, nil}}
  """
  def mul(%Array{array: v, shape: {_, nil}}, s) when is_number(s), do: Enum.map(v, &(&1*s)) |> new
  def mul(s, %Array{array: v, shape: {_, nil}}) when is_number(s), do: Enum.map(v, &(&1*s)) |> new
  def mul(%Array{array: xv, shape: {xv_row, nil}}, %Array{array: yv, shape: {yv_row, nil}}) when xv_row == yv_row do
    # vector + vector
    Enum.zip(xv, yv)
    |> Enum.map(fn({a,b})->a*b end)
    |> new
  end
  def mul(%Array{array: xm, shape: xm_shape}, %Array{array: ym, shape: ym_shape}) when xm_shape == ym_shape do
    # matrix + matrix
    {_, xm_col} = xm_shape
    xv = List.flatten(xm)
    yv = List.flatten(ym)
    Enum.zip(xv,yv)
    |> Enum.map(fn({a,b})->a*b end)
    |> Enum.chunk_every(xm_col)
    |> new
  end
  def mul(%Array{array: m, shape: {_, col}}, s) when col != nil do
    m
    |> Enum.map(&(Enum.map(&1,fn(x)->x*s end)))
    |> new
  end
  def mul(s, %Array{array: m, shape: {_, col}}) when col != nil do
    m
    |> Enum.map(&(Enum.map(&1,fn(x)->x*s end)))
    |> new
  end

  @doc """
  Calculate inner product.

  ## Examples

      iex> x = Numexy.new([1,2,3])
      %Array{array: [1,2,3], shape: {3, nil}}
      iex> y = Numexy.new([1,2,3])
      %Array{array: [1,2,3], shape: {3, nil}}
      iex> Numexy.dot(x, y)
      14
  """
  def dot(%Array{array: xv, shape: {xv_row, nil}}, %Array{array: yv, shape: {yv_row, nil}}) when xv_row == yv_row do
    # vector * vector return scalar
    dot_vector(xv, yv)
  end

  def dot(%Array{array: m, shape: {_, m_col}}, %Array{array: v, shape: {v_row, nil}}) when m_col == v_row do
    # matrix * vector return vector
    m = for mi <- m, vi<-[v], do: [mi, vi]
    m
    |> Enum.map(fn([x,y])-> dot_vector(x, y) end)
    |> new
  end

  def dot(%Array{array: xm, shape: {x_row, x_col}}, %Array{array: ym, shape: {y_row, _}}) when x_col == y_row do
    # matrix * matrix return matrix
    m = for xi <- xm, yi<-list_transpose(ym), do: [xi, yi]
    m
    |> Enum.map(fn([x,y])-> dot_vector(x, y) end)
    |> Enum.chunk_every(x_row)
    |> new

  end

  defp dot_vector(xv ,yv) do
    Enum.zip(xv, yv)
    |> Enum.reduce(0, fn({a,b},acc)-> a*b+acc end)
  end

  @doc """
  Calculate transpose matrix.

  ## Examples

      iex> x = Numexy.new([[4,3],[7,5],[2,7]])
      %Array{array: [[4, 3], [7, 5], [2, 7]], shape: {3, 2}}
      iex> Numexy.transpose(x)
      %Array{array: [[4, 7, 2], [3, 5, 7]], shape: {2, 3}}
  """
  def transpose(%Array{array: m, shape: {_, col}}) when col != nil do
    m
    |> list_transpose
    |> new
  end

  defp list_transpose(list) do
    list
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Create ones matrix or vector.

  ## Examples

      iex> Numexy.ones({2, 3})
      %Array{array: [[1, 1, 1], [1, 1, 1]], shape: {2, 3}}
      iex> Numexy.ones({3, nil})
      %Array{array: [1, 1, 1], shape: {3, nil}}
  """
  def ones({row, nil}) do
    List.duplicate(1, row)
    |> new
  end

  def ones({row, col}) do
    List.duplicate(1, col)
    |> List.duplicate(row)
    |> new
  end

  @doc """
  Create zeros matrix or vector.

  ## Examples

      iex> Numexy.zeros({2, 3})
      %Array{array: [[0, 0, 0], [0, 0, 0]], shape: {2, 3}}
      iex> Numexy.zeros({3, nil})
      %Array{array: [0, 0, 0], shape: {3, nil}}
  """
  def zeros({row, nil}) do
    List.duplicate(0, row)
    |> new
  end

  def zeros({row, col}) do
    List.duplicate(0, col)
    |> List.duplicate(row)
    |> new
  end

  @doc """
  Sum matrix or vector.

  ## Examples

      iex> Numexy.new([2,9,5]) |> Numexy.sum
      16
      iex> Numexy.new([[1,2,3],[4,5,6]]) |> Numexy.sum
      21
  """
  def sum(%Array{array: v, shape: {_, nil}}) do
    v
    |> Enum.reduce(&(&1+&2))
  end

  def sum(%Array{array: m, shape: _}) do
    m
    |> Enum.reduce(0, &(Enum.reduce(&1, fn(x,acc)-> x+acc end) + &2))
  end

  @doc """
  Avarage matrix or vector.

  ## Examples

      iex> Numexy.new([2,9,5]) |> Numexy.avg
      5.333333333333333
      iex> Numexy.new([[1,2,3],[4,5,6]]) |> Numexy.avg
      3.5
  """
  def avg(%Array{array: v, shape: {row, nil}}) do
    v
    |> Enum.reduce(&(&1+&2))
    |> float_div(row)
  end

  def avg(%Array{array: m, shape: {row, col}}) do
    m
    |> Enum.reduce(0, &(Enum.reduce(&1, fn(x,acc)-> x+acc end) + &2))
    |> float_div(row*col)
  end

  defp float_div(dividend, divisor) do
    dividend / divisor
  end

  @doc """
  Get matrix or vector value.

  ## Examples

      iex> Numexy.new([2,9,5]) |> Numexy.get({2, nil})
      9
      iex> Numexy.new([[1,2,3],[4,5,6]]) |> Numexy.get({2, 1})
      4
  """
  def get(%Array{array: v, shape: {_, nil}}, {row, nil}), do: Enum.at(v, row - 1)
  def get(%Array{array: m, shape: _}, {row, col}), do: Enum.at(m, row - 1) |> Enum.at(col - 1)

  @doc """
  Get index of max value.

  ## Examples

      iex> Numexy.new([[1,2,9],[4,5,6]]) |> Numexy.argmax
      2
      iex> Numexy.new([[1,2,9],[4,6,3]]) |> Numexy.argmax(:row)
      [2, 1]
      iex> Numexy.new([[1,2,9],[4,6,3]]) |> Numexy.argmax(:col)
      [1, 1, 0]
  """
  def argmax(%Array{array: v, shape: {_, nil}}), do: v |> find_max_value_index

  def argmax(%Array{array: m, shape: _}) do
    m |> find_max_value_index
  end

  def argmax(%Array{array: m, shape: _}, :row) do
    m
    |> Enum.map(&(Numexy.find_max_value_index(&1)))
  end

  def argmax(%Array{array: m, shape: _}, :col) do
    m
    |> list_transpose
    |> Enum.map(&(Numexy.find_max_value_index(&1)))
  end

  def find_max_value_index(list) do
    flat_list = List.flatten(list)
    max_value = Enum.max(flat_list)
    flat_list |> Enum.find_index(&(&1==max_value))
  end

  @doc """
  Get step function value.

  ## Examples

      iex> Numexy.new([-2,9,5]) |> Numexy.step_function()
      %Array{array: [0, 1, 1], shape: {3, nil}}
  """
  def step_function(%Array{array: v, shape: {_, nil}}) do
    v
    |> Enum.map(&(step_function_output(&1)))
    |> new
  end

  defp step_function_output(num) when num > 0, do: 1
  defp step_function_output(num) when num <= 0, do: 0

  @doc """
  Get sigmoid function value.

  ## Examples

      iex> Numexy.new([-2,9,5]) |> Numexy.sigmoid()
      %Array{array: [0.11920292202211755, 0.9998766054240137, 0.9933071490757153], shape: {3, nil}}
  """
  def sigmoid(%Array{array: v, shape: {_, nil}}) do
    v
    |> Enum.map(&(1/(1+ :math.exp(-1 * &1))))
    |> new
  end

  @doc """
  Get relu function value.

  ## Examples

      iex> Numexy.new([-2,9,5]) |> Numexy.relu()
      %Array{array: [0, 9, 5], shape: {3, nil}}
  """
  def relu(%Array{array: v, shape: {_, nil}}) do
    v
    |> Enum.map(&(relu_output(&1)))
    |> new
  end

  defp relu_output(x) when x>0, do: x
  defp relu_output(x) when x<=0, do: 0

end
