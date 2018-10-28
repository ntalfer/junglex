# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :junglex,
  ecto_repos: [Junglex.Repo]

# Configures the endpoint
config :junglex, JunglexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9ceyFA4Y7mVtpvZBnuPWLbhkqwpvOkSLL9PxzC0mQBQQ7DrUcxEJuNLADBxKDCIz",
  render_errors: [view: JunglexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Junglex.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]
  
config :junglex, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: JunglexWeb.Router,     # phoenix routes will be converted to swagger paths
      endpoint: JunglexWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
    ]
  }
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
