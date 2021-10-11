defmodule Repo.Migrations.CreateDogsTable do
  use Ecto.Migration

  def up do
    create table("dogs") do
      add(:breed, :string, null: false)
      add(:image, :string)

      timestamps()
    end
  end

  def down do
    drop(table("dogs"))
  end
end
