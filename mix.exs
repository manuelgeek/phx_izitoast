defmodule PhxIzitoast.MixProject do
  use Mix.Project

  def project do
    [
      app: :phx_izitoast,
      version: "0.1.2",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description:
        "This is a Phoenix Elixir IziToast Notification wrapper. https://izitoast.marcelodolza.com,  A JavaScript Notifications Toast Library",
      package: package(),
      # Docs
      name: "PhxIzitoast",
      source_url: "https://github.com/manuelgeek/phx_izitoast.git",
      homepage_url: "https://hexdocs.pm/mpesa/PhxIzitoast.html",
      docs: [
        # The main page in the docs
        main: "PhxIzitoast",
        extras: ["README.md"]
      ]
    ]
  end

  defp package do
    [
      maintainers: [" ManuEl Magak "],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/manuelgeek/phx_izitoast.git",
        "README" => "https://hexdocs.pm/mpesa/readme.html"
      }
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
      {:phoenix_html, "~> 3.0"},
      {:phoenix, "~> 1.6.2"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
