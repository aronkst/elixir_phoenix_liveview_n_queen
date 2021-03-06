# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :elixir_phoenix_liveview_n_queen, ElixirPhoenixLiveviewNQueenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sGfoK39RXsCXT210QU63P4jA64QJA8fYyRwM49kG7ZbtkUqpa4aEdKMnKqRuIT67",
  render_errors: [view: ElixirPhoenixLiveviewNQueenWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirPhoenixLiveviewNQueen.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "f5uHdeEc"],
  live_view: [signing_salt: "2I9oJW/b4uQPSJaH9Vv5EkhBHQ4SaJiX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
