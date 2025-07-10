
FROM node:20-slim

WORKDIR /app

# Copia o código-fonte
COPY . .

# Instala dependências
RUN npm install

# Expõe a porta padrão do Vite
EXPOSE 5173

# Roda o Vite em modo desenvolvimento acessível externamente
CMD ["npm", "run", "dev", "--", "--host"]
