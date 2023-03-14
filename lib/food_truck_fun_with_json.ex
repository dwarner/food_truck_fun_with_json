defmodule FoodTruckFunWithJson do
  @moduledoc """
  Documentation for `FoodTruckFunWithJson`.
  """

  @doc """
  Takes a string `food_type` and lat and long to search for nearest food truck.

  Returns the closest, APPROVED food truck with that food.

  ## Examples

      iex> FoodTruckFunWithJson.find_nearest_with_food("hot dogs", 37.788353479836715, -122.40682576358824)
      %{":@computed_region_bh8s_q3mv" => "28861"}

      iex> FoodTruckFunWithJson.find_nearest_with_food("hot dogs", 37.788353479836715, -122.40682576358824)
      {:error, %{source: "http://asdfasdf"}}

     iex> FoodTruckFunWithJson.find_nearest_with_food("no approved food truck with food", 37.788353479836715, -122.40682576358824)
      ** (Enum.EmptyError) empty error

  """
  def find_nearest_with_food(food_type, lat, long) do
    with {:ok, food_truck_data} <- FoodTruckData.get_food_truck_data() do
      food_truck_data
      |> find_food_trucks_serving(food_type)
      |> find_nearest(lat, long)
    end
  end

  @doc """
  Takes a list of food trucks in map format along with the lat and long to
  search for the nearest food truck.

  Returns the closest, APPROVED food truck to the lat and long passed in.

  ## Examples

      iex> FoodTruckFunWithJson.find_nearest([%{}], 37.788353479836715, -122.40682576358824)
      %{":@computed_region_bh8s_q3mv" => "28861"}

  """
  def find_nearest(food_trucks, lat, long) do
    Enum.min_by(food_trucks, fn x ->
      {latitude, _} = Float.parse(x["longitude"])
      {longitude, _} = Float.parse(x["latitude"])
      Distance.GreatCircle.distance({latitude, longitude}, {lat, long})
    end)
  end

  @doc """
  Takes a list of food trucks in map format along with the `food_type`
  and the `status` and reduces the list to those food trucks that match.

  Defaults to "APPROVED" food trucks.

  Returns a list of food trucks in map format.

  ## Examples

      iex> FoodTruckFunWithJson.find_food_trucks_serving([%{}], "hot dogs")
      [%{":@computed_region_bh8s_q3mv" => "28861"}]

  """
  def find_food_trucks_serving(food_trucks, food_type, status \\ "APPROVED") do
    approved_trucks_with_food_type =
      Enum.reduce(food_trucks, [], fn e, acc ->
        try do
          %{
            "status" => ^status,
            "facilitytype" => "Truck",
            "fooditems" => food_items,
            "latitude" => _latitude,
            "longitude" => _longitude
          } = e

          if String.match?(food_items, ~r{#{food_type}}i), do: [e | acc], else: acc
        rescue
          MatchError -> acc
        end
      end)

    approved_trucks_with_food_type
  end
end
