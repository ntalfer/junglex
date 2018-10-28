use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :junglex, JunglexWeb.Endpoint,
  secret_key_base: "9e0Z6ihLGn7OY+WAp1B0//xmzxmDojG65/kEYaIdQtaOACaR1HaW3ugfv/GuDJWp"

# Configure your database
config :junglex, Junglex.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "junglex_prod",
  pool_size: 15
