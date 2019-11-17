defmodule EonetEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :eonet_ex,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      version: "0.1.0",
      elixir: "~> 1.9",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
      Elixir client for NASA's EONET service
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Christian Fuertes"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/crisefd/eonet_ex"}
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
     {:poison, "~> 4.0"},
     {:json, "~> 1.3"},
     {:httpoison, "~> 1.6"},
     {:tesla, "~> 1.3"},
     {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
