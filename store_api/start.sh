#!/bin/sh

echo "⏳ Aguardando banco de dados estar disponível..."
while ! pg_isready -h $DB_HOST -p 5432 -U $DB_USER > /dev/null 2>&1; do
  sleep 1
done

echo "✅ Banco de dados está disponível!"

mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server