defmodule CoinbaseCommerce.MixProject do
  use Mix.Project

  def project do
    [
      app: :coinbase_commerce,
      name: "coinbase_commerce",
      description: "Simple Elixir wrapper for the Coinbase Commerce API",
      source_url: "https://github.com/allenan/coinbase_commerce",
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub Repo" => "https://github.com/allenan/coinbase_commerce",
        "Official Docs" => "https://commerce.coinbase.com/docs/"
      },
    ]
  end
end
