# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :server,
       port: 8881,
       api_key: System.get_env("api_key") || "",
       token: System.get_env("token") || ""
