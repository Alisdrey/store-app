FROM elixir:1.16.2

RUN apt-get update && apt-get install -y build-essential inotify-tools postgresql-client

WORKDIR /app

# Copia o mix e lock primeiro para cache do deps
COPY mix.exs mix.lock ./
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

# Agora copia o restante da aplicação
COPY . .

# Torna o script executável
RUN chmod +x ./start.sh

# Usa o start.sh como ponto de entrada
CMD ["./start.sh"]
