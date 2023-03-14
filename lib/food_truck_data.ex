defmodule FoodTruckData do
  @moduledoc """
  Module to consume food truck data from public API.
  """
  require Logger

  @source "https://data.sfgov.org/resource/rqzj-sfat.json"

  @doc """
  Gets and returns food truck data as a list of maps from `source`.

  If no `source` is passed in, it will default to
  @source
  set in this module.

  ## Examples

    iex> FoodTruckData.get_food_truck_data()
    {:ok, [%{}, ...]}

    iex> FoodTruckData.get_food_truck_data("bad source")
    {:error}

  """
  def get_food_truck_data(source \\ @source) do
    try do
      %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!(source)
      {:ok, Jason.decode!(body)}
    rescue
      e ->
        Logger.error(Exception.format(:error, e, __STACKTRACE__))
        {:error, %{source: source}}
    end
  end
end
