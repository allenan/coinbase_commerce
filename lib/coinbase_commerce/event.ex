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
    %HTTPoison.Response{body: %{data: data, pagination: _pagination}} =
      Request.get!("/events")

    events = for event <- data, do: make_struct(event)
    {:ok, events}
  end

  def show(id) do
    %HTTPoison.Response{body: %{data: data}} =
      Request.get!("/events/#{id}")

    {:ok, make_struct(data)}
  end

  defp make_struct(data) do
    struct(Event, data)
  end
end
