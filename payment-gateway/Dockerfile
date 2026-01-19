FROM node:20

WORKDIR /app

# Copia package.json e lock ANTES para cache do docker
COPY package*.json ./

# Instala dependências do projeto
RUN npm install

# Instala o Nest CLI global (opcional)
RUN npm install -g @nestjs/cli

# Adiciona binários locais e globais no PATH
ENV PATH="/app/node_modules/.bin:/usr/local/lib/node_modules/.bin:${PATH}"

# Copia código da aplicação
COPY . .

EXPOSE 3000

CMD ["npm", "run", "start:dev"]
