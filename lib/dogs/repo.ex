defmodule Dogs.Repo do
  use Ecto.Repo,
    otp_app: :dogs,
    adapter: Ecto.Adapters.Postgres
end
