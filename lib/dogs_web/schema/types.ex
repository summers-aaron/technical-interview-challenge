defmodule DogsWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :dog do
    field(:id, non_null(:id))
    field(:breed, non_null(:string))
    field(:image, :string)
  end
end
