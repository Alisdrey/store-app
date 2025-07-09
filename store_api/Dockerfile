FROM elixir:1.16.2

RUN apt-get update && apt-get install -y build-essential inotify-tools postgresql-client

WORKDIR /app

COPY . .

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

CMD ["sh", "-c", "mix ecto.setup && mix run priv/repo/seeds.exs && mix phx.server"]
