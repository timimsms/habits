defmodule HabitsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :habits

  socket "/socket", HabitsWeb.UserSocket, websocket: true

  # For wallaby
  if Application.get_env(:habits, :sql_sandbox) do
    plug Phoenix.Ecto.SQL.Sandbox
  end

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :habits,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  # github.com/stevegrossi/habits/issues/3
  plug PlugXForwardedFor

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_habits_key",
    max_age: 60 * 60 * 24 * 30,
    signing_salt: "ejQglpzc",
    encryption_salt: System.get_env("SECRET_KEY_BASE")

  plug HabitsWeb.Router
end
