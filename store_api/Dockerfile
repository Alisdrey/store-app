FROM elixir:1.16.2

RUN apt-get update && apt-get install -y build-essential inotify-tools postgresql-client

WORKDIR /app

COPY . .

ARG SECRET_KEY_BASE
ARG GUARDIAN_SECRET_KEY

ENV SECRET_KEY_BASE=$SECRET_KEY_BASE
ENV GUARDIAN_SECRET_KEY=$GUARDIAN_SECRET_KEY

# Dá permissão ao start.sh do backend (que está no mesmo diretório)
RUN chmod +x ./start.sh

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

CMD ["sh", "./start.sh"]
