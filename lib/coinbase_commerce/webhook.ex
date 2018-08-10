defmodule CoinbaseCommerce.Webhook do
  @moduledoc """
  Work with Coinbase Commerce Webhooks

  Coinbase Commerce API reference: https://commerce.coinbase.com/docs/api/#webhooks
  """

  def verify_signature(signature, body) do
    hash = :crypto.hmac(:sha256, shared_secret(), body) |> Base.encode16()
    signature = signature |> String.upcase()

    hash == signature
  end

  defp shared_secret() do
    case Application.get_env(:coinbase_commerce, :webhook_shared_secret) do
      nil -> raise "Webhook shared secret is not configured"
      value -> value
    end
  end
end
