defmodule CoinbaseCommerce.Charge do
  @moduledoc """
  Work with Coinbase Commerce Charges

  Coinbase Commerce API reference: https://commerce.coinbase.com/docs/api/#charges
  """

  alias CoinbaseCommerce.Charge
  alias CoinbaseCommerce.Request

  defstruct [
    :id,
    :code,
    :name,
    :description,
    :logo_url,
    :hosted_url,
    :created_at,
    :expires_at,
    :confirmed_at,
    :checkout,
    :timeline,
    :metadata,
    :pricing_type,
    :pricing,
    :payments,
    :addresses
  ]

  def create(body) do
    %HTTPoison.Response{body: %{data: data}} =
      Request.post!("/charges", body)

    make_charge(data)
  end

  def list do
    %HTTPoison.Response{body: %{data: data, pagination: _pagination}} =
      Request.get!("/charges")

    for charge <- data, do: make_charge(charge)
  end

  def show(id) do
    %HTTPoison.Response{body: %{data: data}} =
      Request.get!("/charges/#{id}")

    make_charge(data)
  end

  defp make_charge(data) do
    struct(Charge, data)
  end
end
