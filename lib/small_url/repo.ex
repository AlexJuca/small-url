defmodule SmallUrl.Repo do
  use Ecto.Repo,
    otp_app: :small_url,
    adapter: Ecto.Adapters.Postgres
end
