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

  def list do
    case Request.get!("/charges") do
      %HTTPoison.Response{body: %{data: data, pagination: _pagination}, status_code: 200} ->
        charges = for charge <- data, do: make_struct(charge)
        {:ok, charges}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  def show(id) do
    case Request.get!("/charges/#{id}") do
      %HTTPoison.Response{body: %{data: data}} ->
        {:ok, make_struct(data)}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  def create(params) do
    case Request.post("/charges", params) do
      %HTTPoison.Response{body: %{data: data}, status_code: 200} ->
        {:ok, make_struct(data)}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  defp make_struct(data) do
    struct(Charge, data)
  end
end
