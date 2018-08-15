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
    case Request.get!("/checkouts") do
      %HTTPoison.Response{body: %{data: data, pagination: _pagination}, status_code: 200} ->
        checkouts = for checkout <- data, do: make_struct(checkout)
        {:ok, checkouts}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  def show(id) do
    case Request.get!("/checkouts/#{id}") do
      %HTTPoison.Response{body: %{data: data}} ->
        {:ok, make_struct(data)}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  def create(params) do
    case Request.post("/checkouts", params) do
      %HTTPoison.Response{body: %{data: data}, status_code: 200} ->
        {:ok, make_struct(data)}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  def update(id, params) do
    case Request.put!("/checkouts/#{id}", params) do
      %HTTPoison.Response{body: %{data: data}, status_code: 200} ->
        {:ok, make_struct(data)}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  def delete(id) do
    case Request.delete!("/checkouts/#{id}") do
      %HTTPoison.Response{status_code: 200} ->
        :ok
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  defp make_struct(data) do
    struct(Checkout, data)
  end
end
