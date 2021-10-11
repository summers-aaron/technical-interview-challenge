defmodule Dogs.Dog do
  use Ecto.Schema
  alias Ecto.Changeset

  schema "dogs" do
    field(:breed, :string)
    field(:image, :string)

    timestamps()
  end

  def changeset(dog, changes) do
    dog
    |> Changeset.cast(changes, [
      :breed,
      :image
    ])
    |> validate_required()
  end

  defp validate_required(changes) do
    Changeset.validate_required(changes, [
      :breed
    ])
  end
end
