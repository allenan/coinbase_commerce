defmodule CoinbaseCommerce.Error do
  @moduledoc """
  Represents a Coinbase Commerce error
  """

  alias CoinbaseCommerce.Error

  defstruct [
    :code,
    :type,
    :message
  ]

  def make_error(%HTTPoison.Response{body: %{error: error}}) do
    struct(Error, error)
  end
end
