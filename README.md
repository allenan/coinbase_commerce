# Coinbase Commerce

An Elixir library for working with the [Coinbase Commerce](https://commerce.coinbase.com/) API ([Documentation](https://hexdocs.pm/coinbase_commerce))

[![Hex.pm](https://img.shields.io/hexpm/v/coinbase_commerce.svg?maxAge=2592000)](https://hex.pm/packages/coinbase_commerce)

## Installation

Install by adding `coinbase_commerce` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:coinbase_commerce, "~> 0.2.0"}
  ]
end
```

Configure your API key and webhook shared secret:

```elixir
config :coinbase_commerce,
  api_key: "YOUR-API-KEY",
  webhook_shared_secret: "YOUR-WEBHOOK-SHARED-SECRET" # optional unless using webhooks
```

## Usage
Full API documentation is available at [https://hexdocs.pm/coinbase_commerce](https://hexdocs.pm/coinbase_commerce). For details on the Coinbase Commerce API, see the [official documentation](https://commerce.coinbase.com/docs/api).

### Charges

```elixir
# Create a charge
{:ok, %CoinbaseCommerce.Charge{}} = CoinbaseCommerce.Charge.create(%{
  name: "The Sovereign Individual",
  description: "Mastering the Transition to the Information Age",
  local_price: {
    amount: "100.00",
    currency: "USD"
  },
  pricing_type: "fixed_price",
  metadata: {
    customer_id: "id_1005",
    customer_name: "Satoshi Nakamoto"
  }
})

# View a charge
{:ok, %CoinbaseCommerce.Charge{}} = CoinbaseCommerce.Charge.show("some-charge-id")

# List all charges
{:ok, charges} = CoinbaseCommerce.Charge.list()
```

### Checkouts

```elixir
# Create a checkout
{:ok, %CoinbaseCommerce.Checkout{}} = CoinbaseCommerce.Checkout.create(%{
  name: "The Sovereign Individual",
  description: "Mastering the Transition to the Information Age",
  local_price: {
    amount: "100.00",
    currency: "USD"
  },
  pricing_type: "fixed_price",
  requested_info: ["email"]
})

# View a checkout
{:ok, %CoinbaseCommerce.Checkout{}} = CoinbaseCommerce.Checkout.show("some-checkout-id")

# List all checkouts
{:ok, checkouts} = CoinbaseCommerce.Checkout.list()

# Update a checkout
{:ok, %CoinbaseCommerce.Checkout{}} = CoinbaseCommerce.Checkout.update(%{
  local_price: {
    amount: "200.00",
    currency: "USD"
  }
})

# Delete a checkout
:ok = CoinbaseCommerce.Checkout.delete("some-checkout-id")
```

### Events

```elixir
# List events
{:ok, events} = CoinbaseCommerce.Event.list()

# Show an event
{:ok, %CoinbaseCommerce.Event{}} = CoinbaseCommerce.Event.show("some-event-id")
```

### Webhooks

```elixir
# Verify an incoming webhook's signature
true = CoinbaseCommerce.Webook.verify_signature(signature, request_body)
```

## Contributing
Feedback, feature requests, and fixes are welcomed and encouraged. Please make appropriate use of [Issues](https://github.com/allenan/coinbase_commerce/issues) and [Pull Requests](https://github.com/allenan/coinbase_commerce/pulls).

## License
Please see [LICENSE](https://github.com/allenan/coinbase_commerce/blob/master/LICENSE) for details.
