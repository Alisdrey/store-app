#!/bin/sh

echo "⏳ Aguardando banco de dados estar disponível..."
while ! pg_isready -h "$DB_HOST" -p 5432 -U "$DB_USER" > /dev/null 2>&1; do
  sleep 1
done

echo "✅ Banco de dados está disponível!"

# Executa setup apenas se o banco não estiver criado (evita sobrescrever dados)
if mix ecto.migrate --quiet; then
  echo "✅ Migração executada com sucesso."
else
  echo "⚠️ Falha na migração. Tentando criar o banco..."
  mix ecto.create && mix ecto.migrate
fi

# Executa seeds apenas se for o primeiro start
if [ -f "priv/repo/seeds.exs" ]; then
  echo "🌱 Rodando seeds..."
  mix run priv/repo/seeds.exs
fi

# Inicia o servidor
mix phx.server
