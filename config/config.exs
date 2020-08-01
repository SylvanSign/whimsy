# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configures the endpoint
config :whimsy, WhimsyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bD1Doj6lwNPTr4zsPZC06biUbgHncm4PCgMN8FsNNurz6gIfUpC2Ki88N+EnbI0N",
  render_errors: [view: WhimsyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Whimsy.PubSub,
  live_view: [signing_salt: "HvjbdphZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
