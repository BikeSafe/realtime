# Realtime Services for BikeSafe

## Using docker

### Docker images used

- [elixir:latest](https://hub.docker.com/_/elixir)
- [postgis/postgis:latest](https://hub.docker.com/r/postgis/postgis)

### Initialize containers

The running service requires ports `localhost:4000` and `localhost:5432`

```sh
> cd path/to/realtime
> docker-compose up
```

## Running localy

### Dependencies

- Elixir
- PostgreSQL
- PostGIS extensions

### To start your Phoenix server:

  * Change the `hostname` prop at `realtime/config/dev.ex` to be `localhost`
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now send API requests at `localhost:4000/api/interest_point` regardless of the method used

- Endpoint 1:
  * Method: `POST`
  * Param 1: type: integer
  * Param 2: lng: number
  * Param 3: lat: number
  * Example: `http://localhost:4000/api/interest_point?type=1&lng=80.1&lat=80.1`

- Endpoint 2:
  * Method: `GET`
  * Param 1: id: integer
  * Param 2: radius: number
  * Example: `http://localhost:4000/api/interest_point?id=10&radius=1000`
