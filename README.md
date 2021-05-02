# Realtime Services for BikeSafe

## General configuration

Put your sensitive configuration in the `config/{environment}.secret.exs` file.

As an example:

```elixir
import Config

# Configure your database
config :realtime, Realtime.Repo,
  username: "username",
  password: "password",
  database: "realtime_dev",
  url:
    "postgresql://username:password@dbidentifier.123abc.us-east-1.rds.amazonaws.com/realtime_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  types: Realtime.PostgresTypes

```

## Using docker

### Docker images used

- [elixir:latest](https://hub.docker.com/_/elixir)

### Optional docker images

An image with a full instalation of `postgres` and it's extensions is available. To use it, it should be added to the `docker-compose.yml` file, and the `elixir` image should be made to depend on it. The `elixir` configuration should use the `hostname` property instead of `url`.

- [postgis/postgis:latest](https://hub.docker.com/r/postgis/postgis)

### Initialize containers

The running service requires port `localhost:4000`

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
  * Param 1: lat: number
  * Param 2: lng: number
  * Param 3: radius: number
  * Example: `http://localhost:4000/api/interest_point?lng=80.1&lat=80.1&radius=1000`
