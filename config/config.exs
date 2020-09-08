# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :genchat,
  ecto_repos: [Genchat.Repo]

# Configures the endpoint
config :genchat, GenchatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Tztd5TrAapWdct7z0SicxyYQ1AWQmXAVeodiAWkv4gtQNgDLpoVbsOsfHGC6yTSw",
  render_errors: [view: GenchatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Genchat.PubSub,
  live_view: [signing_salt: "2J1LmwkJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

# Parse any environment vars in .env; set them in the app context
try do
  File.stream!("./.env")
  |> Stream.map(&String.trim_trailing/1)
  |> Enum.each(fn line ->
    line
    |> String.split("=", parts: 2)
    |> Enum.reduce(fn value, key ->
      System.put_env(key, value)
    end)
  end)
rescue
  _ -> IO.puts("no .env file found!")
end

config :genchat, Encryption.AES,
  keys:
    System.get_env("ENCRYPTION_KEYS")
    |> String.replace("'", "")
    |> String.split(",")
    |> Enum.map(fn key -> :base64.decode(key) end)

import_config "#{Mix.env()}.exs"
