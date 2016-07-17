# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :issues,
  ecto_repos: [Issues.Repo]

# Configures the endpoint
config :issues, Issues.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I+35l8v2AULH2VvxUpeT0SqE7MQ0QkidhbKXWI5mPoinUuBCISaoJGX5Y/Fldf/r",
  render_errors: [view: Issues.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Issues.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
