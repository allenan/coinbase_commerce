defmodule CoinbaseCommerce.Event do
  @moduledoc """
  Work with Coinbase Commerce Events

  Coinbase Commerce API reference: https://commerce.coinbase.com/docs/api/#events
  """

  alias CoinbaseCommerce.Event
  alias CoinbaseCommerce.Request

  defstruct [
    :id,
    :type,
    :created_at,
    :api_version,
    :data
  ]

  def list do
    case Request.get!("/events") do
      %HTTPoison.Response{body: %{data: data, pagination: _pagination}, status_code: 200} ->
        events = for event <- data, do: make_struct(event)
        {:ok, events}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  def show(id) do
    case Request.get!("/events/#{id}") do
      %HTTPoison.Response{body: %{data: data}} ->
        {:ok, make_struct(data)}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
      %HTTPoison.Response{} = response ->
        {:error, CoinbaseCommerce.Error.make_error(response)}
    end
  end

  defp make_struct(data) do
    struct(Event, data)
  end
end
