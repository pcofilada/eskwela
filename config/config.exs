# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eskwela,
  ecto_repos: [Eskwela.Repo]

# Configures the endpoint
config :eskwela, Eskwela.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yQqqBgK4NFakSd9nlzO+SWtGp9FQn3okqzi9qzFPWsEg9RZ3WlwYjQ5PWufVDuyE",
  render_errors: [view: Eskwela.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Eskwela.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configures Template Engines
config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine
