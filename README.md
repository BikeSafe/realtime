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
