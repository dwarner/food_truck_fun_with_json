# FoodTruckFunWithJson

Using the data available at https://data.sfgov.org/resource/rqzj-sfat.json, we can use FoodTruckFunWithJson 
to find out which open (i.e. status = APPROVED) food truck is the closest to Union Square in San Fransico, CA.

## Notes

3. Food Stand
Using the data available at https://data.sfgov.org/resource/rqzj-sfat.json find out which opened japanese food truck is the closest to union square.

With the current json payload from sfgov.org, there is no "japanese" food truck that has a status of "APPROVED." 

We do not want to return to our users a food truck that has a expired food permit and therefore would not be on the street waiting to serve them!!!

**Feel free to search for other food item (e.g. tacos).**


## Cororidnates for Union Square

### Latitude
`37.788353479836715`

### Longitude
`-122.40682576358824`


## Running
```bash
$ iex -S mix
```

```elixir
iex> FoodTruckFunWithJson.find_nearest_with_food("hot dogs", 37.788353479836715, -122.40682576358824)
```

## Testing
```bash
$ mix test
```

## Roadmap

* Mock HTTPoison with Mox
* Fix doctest
