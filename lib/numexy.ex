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
  def new(array) do
    shape = {row_count(array), col_count(array)}
    %Array{array: array, shape: shape}
  end

  defp row_count(array) do
    Enum.count(array)
  end

  defp col_count([head| _ ]) when is_list(head) do
    Enum.count(head)
  end

  defp col_count(_) do
    nil
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
  def dot(%Array{array: x, shape: {x_row, nil}}, %Array{array: y, shape: {y_row, nil}}) when x_row == y_row do
    # vector * vector
    dot_vector(x, y)
  end

  def dot(%Array{array: x, shape: {x_row, x_col}}, %Array{array: y, shape: {y_row, _}}) when x_col == y_row do
    # matrix * matrix
    m = for xi <- x, yi<-list_transpose(y), do: [xi, yi]
    m
    |> dot_matrix([])
    |> Enum.chunk_every(x_row)
    |> new
  end

  defp dot_vector(x ,y) do
    Enum.zip(x, y)
    |> Enum.reduce(0, fn({a,b},acc)-> a*b+acc end)
  end

  defp dot_matrix([], total), do: total
  defp dot_matrix([[x, y]|tail], total) do
    dot_matrix(tail, total ++ [dot_vector(x,y)])
  end


  @doc """
  Calculate transpose matrix.

  ## Examples

      iex> x = Numexy.new([[4,3],[7,5],[2,7]])
      %Array{array: [[4, 3], [7, 5], [2, 7]], shape: {3, 2}}
      iex> Numexy.transpose(x)
      %Array{array: [[4, 7, 2], [3, 5, 7]], shape: {2, 3}}
  """
  def transpose(%Array{array: x, shape: {_, col}}) when col != nil do
    x
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


end
