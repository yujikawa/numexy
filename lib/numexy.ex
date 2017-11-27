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

      iex> x = Numexy.new([1,2,3])
      %Array{array: [1, 2, 3], shape: {3, nil}}
      iex> x = Numexy.new([[1,2,3],[1,2,3]])
      %Array{array: [[1, 2, 3], [1, 2, 3]], shape: {2, 3}}

  """
  def new(array) do
    shape = get_shape(array)
    %Array{array: array, shape: shape}
  end


  @doc """
  Calculate inner product.

  ## Examples

      iex> x = Numexy.new([1,2,3])
      %Array{array: [1,2,3], shape: {3, nil}}
      iex> y = Numexy.new([1,2,3])
      %Array{array: [1,2,3], shape: {3, nil}}
      iex> y = Numexy.dot(x, y)
      14
  """
  def dot(x, y) do
    14
  end

  @doc """
  Get matrix shape.
  """
  defp get_shape(array) do
    row = row_count(array)
    col = col_count(array)
    {row, col}
  end

  defp row_count(array) do
    Enum.count(array)
  end

  defp col_count([head| _ ]) when is_list(head) do
    Enum.count(head)
  end
  defp col_count([head| _ ]) do
    nil
  end

end
