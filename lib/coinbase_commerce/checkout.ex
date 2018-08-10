defmodule CoinbaseCommerce.Checkout do
  @moduledoc """
  Work with Coinbase Commerce Checkouts

  Coinbase Commerce API reference: https://commerce.coinbase.com/docs/api/#checkouts
  """

  alias CoinbaseCommerce.Checkout
  alias CoinbaseCommerce.Request

  defstruct [
    :id,
    :name,
    :description,
    :logo_url,
    :requested_info,
    :pricing_type,
    :local_price
  ]

  def list do
    %HTTPoison.Response{body: %{data: data, pagination: _pagination}} =
      Request.get!("/checkouts")

    checkouts = for checkout <- data, do: make_struct(checkout)
    {:ok, checkouts}
  end

  def show(id) do
    %HTTPoison.Response{body: %{data: data}} =
      Request.get!("/checkouts/#{id}")

    {:ok, make_struct(data)}
  end

  def create(params) do
    %HTTPoison.Response{body: %{data: data}} =
      Request.post!("/checkouts", params)

    {:ok, make_struct(data)}
  end

  def update(id, params) do
    %HTTPoison.Response{body: %{data: data}} =
      Request.put!("/checkouts/#{id}", params)

    {:ok, make_struct(data)}
  end

  def delete(id) do
    %HTTPoison.Response{} = Request.delete!("/checkouts/#{id}")
    :ok
  end

  defp make_struct(data) do
    struct(Checkout, data)
  end
end
