defmodule CoinbaseCommerce.Request do
  @moduledoc """
  Base API requests
  """

  use HTTPoison.Base

  def process_url(url) do
    "https://api.commerce.coinbase.com" <> url
  end

  def process_request_body(body) do
    Poison.encode!(body)
  end

  def process_request_headers(headers) do
    auth_headers = [
      {"Content-Type", "application/json"},
      {"X-CC-Api-Key", get_default_api_key()},
      {"X-CC-Version", "2018-03-22"}
    ]

    headers ++ auth_headers
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> keys_to_atoms
  end

  defp get_default_api_key() do
    case Application.get_env(:coinbase_commerce, :api_key) do
      nil ->
        ""

      key ->
        key
    end
  end

  def keys_to_atoms(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), keys_to_atoms(val)}
  end
  def keys_to_atoms(string_key_map) when is_list(string_key_map) do
    for n <- string_key_map, do: keys_to_atoms(n)
  end
  def keys_to_atoms(string_key_map) do
    string_key_map
  end
end
