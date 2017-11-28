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
  def dot(%Array{array: x, shape: {_, nil}}, %Array{array: y, shape: {_, nil}}) do
    # vector * vector
    Enum.zip(x, y)
    |> Enum.reduce(0, fn({a,b},acc)-> a*b+acc end)
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

end
