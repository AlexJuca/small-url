defmodule SmallUrlWeb.LinkHelpers do
  def generate_key(), do: Ksuid.generate() |> String.slice(4, 7)

  def generate_expiration_date(), do: DateTime.utc_now() |> DateTime.add(2_592_000, :seconds)
end
