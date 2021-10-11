defmodule Dogs do
  alias Dogs.Repo
  alias Dogs.Dog
  import Ecto.Query

  def get(id) do
    Repo.get(Dog, id)
  end

  def list(args) do
    query = "%" <> args.query <> "%"

    Dog
    |> where([d], ilike(d.breed, ^query))
    |> Repo.all()
  end
end
