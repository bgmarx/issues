defmodule Issues.Mixfile do
  use Mix.Project

  def project do
    [app: :issues,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
      preferred_cli_env: [
        vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
      ],
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Issues, []},
     applications: [:cowboy,
                    :gettext,
                    :httpoison,
                    :logger,
                    :phoenix,
                    :phoenix_ecto,
                    :phoenix_html,
                    :phoenix_pubsub,
                    :postgrex]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:cowboy, "~> 1.0"},
     {:credo, "~> 0.4", only: [:dev, :test]},
     {:exvcr, "~> 0.7", only: :test},
     {:gettext, "~> 0.11"},
     {:httpoison, "~> 0.9.0"},
     {:phoenix, "~> 1.2.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:phoenix_pubsub, "~> 1.0"},
     {:postgrex, ">= 0.0.0"}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
