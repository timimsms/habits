defmodule HabitsWeb.UserSocket do
  use Phoenix.Socket

  alias Habits.Auth

  ## Channels
  channel "notifications", HabitsWeb.NotificationChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  # def connect(%{"user" => user}, socket) do
  def connect(%{"token" => token}, socket) do
    case Auth.get_account_id_from_token(token) do
      {:error, _reason} ->
        :error

      {:ok, account_id} ->
        {:ok, assign(socket, :account_id, account_id)}
    end
  end

  # Socket ids are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     HabitsWeb.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end