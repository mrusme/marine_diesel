defmodule MarineDiesel.Mixfile do
    use Mix.Project

    @description """
    Elixir client library for the Docker API.
    """

    def project do
        [app: :marine_diesel,
         version: "0.1.0",
         elixir: "~> 1.4",
         build_embedded: Mix.env == :prod,
         start_permanent: Mix.env == :prod,
         deps: deps()]
    end

    def application do
        [
            applications: [:poison, :httpoison],
            extra_applications: [:logger]
        ]
    end

    defp deps do
        [
            {:poison, "~> 3.1"},
            {:httpoison, "~> 0.11.1"},
            {:ex_doc, "~> 0.13.0", only: :dev}
        ]
    end

    defp package do
        [
            name: :marine_diesel,
            maintainers: ["Marius <marius@twostairs.com>"],
            licenses: ["MIT"],
            links: %{"GitHub" => "https://github.com/twostairs/marine_diesel"}
        ]
    end
end
