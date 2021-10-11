defmodule DogsWeb.Resolvers.Dogs do
  alias Dogs

  def list(_parent, args, _resolution) do
    {:ok, Dogs.list(args)}
  end
end
