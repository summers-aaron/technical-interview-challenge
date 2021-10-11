defmodule DogsWeb.Schema do
  use Absinthe.Schema
  import_types(DogsWeb.Schema.Types)

  alias DogsWeb.Resolvers

  query do
    @desc "Get all dogs"
    field :dogs, list_of(:dog) do
      arg(:query, :string)
      resolve(&Resolvers.Dogs.list/3)
    end
  end
end
