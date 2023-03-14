defmodule FoodTruckFunWithJsonTest do
  use ExUnit.Case

  @food_trucks [
    %{
      "facilitytype" => "Truck",
      "fooditems" => "Tacos: Burritos: Quesadillas: Tortas: Nachos: Hot Dogs:Soda: Water: Fruit Drinks",
      "latitude" => "37.81019301997575",
      "longitude" => "-122.5552219061259",
      "status" => "APPROVED"
    },
    %{
      "facilitytype" => "Truck",
      "fooditems" => "Hard tacos",
      "latitude" => "38.71019301997575",
      "longitude" => "-123.4552219061259",
      "status" => "APPROVED"
    },
    %{
      "facilitytype" => "Truck",
      "fooditems" => "Soft tacos",
      "latitude" => "38.81019301997575",
      "longitude" => "-123.5552219061259",
      "status" => "APPROVED"
    },
    %{
      "facilitytype" => "Cart",
      "fooditems" => "Soft tacos",
      "latitude" => "38.91019301997575",
      "longitude" => "-123.6552219061259",
      "status" => "APPROVED"
    },
    %{
      "facilitytype" => "Truck",
      "fooditems" => "Soft tacos",
      "latitude" => "39.71019301997575",
      "longitude" => "-124.4552219061259",
      "status" => "EXPIRED"
    },
    %{
      "facilitytype" => "Truck",
      "fooditems" => "Pizza by the slice",
      "latitude" => "39.91019301997575",
      "longitude" => "-124.4552219061259",
      "status" => "APPROVED"
    }
  ]

  test "find_food_trucks_serving/3 only returns APPROVED by default" do
    assert FoodTruckFunWithJson.find_food_trucks_serving(@food_trucks, "tacos") |> length == 3
  end

  test "find_food_trucks_serving/3 with status APPROVED only returns APPROVED" do
    assert FoodTruckFunWithJson.find_food_trucks_serving(@food_trucks, "tacos", "APPROVED") |> length == 3
  end

  test "find_food_trucks_serving/3 with status EXPIRED only returns EXPIRED" do
    assert FoodTruckFunWithJson.find_food_trucks_serving(@food_trucks, "tacos", "EXPIRED") |> length == 1
  end

  test "find_food_trucks_serving/3 only returns trucks" do
    assert FoodTruckFunWithJson.find_food_trucks_serving(@food_trucks, "tacos") |> length == 3
  end

  test "find_food_trucks_serving/3 only returns trucks serving pizza" do
    assert FoodTruckFunWithJson.find_food_trucks_serving(@food_trucks, "pizza") |> length == 1
  end

  test "find_nearest/3 returns the nearest food truck" do
    nearest_foodtruck = FoodTruckFunWithJson.find_nearest(@food_trucks, 37.71019301997575, -122.4552219061259)
    assert nearest_foodtruck == %{
      "facilitytype" => "Truck",
      "fooditems" => "Tacos: Burritos: Quesadillas: Tortas: Nachos: Hot Dogs:Soda: Water: Fruit Drinks",
      "latitude" => "37.81019301997575",
      "longitude" => "-122.5552219061259",
      "status" => "APPROVED"
    }
  end
end
