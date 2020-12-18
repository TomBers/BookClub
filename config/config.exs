# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bkclb,
  ecto_repos: [Bkclb.Repo]

# Configures the endpoint
config :bkclb, BkclbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lVJO1X81/zVQkpoWRYxO13qWxC94g3eV6yd9up0rYOcOXRIQbX66+MC7CvXBl0RF",
  render_errors: [view: BkclbWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bkclb.PubSub,
  live_view: [signing_salt: "839xE9HZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
