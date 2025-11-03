
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .
ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL
EXPOSE 5000

CMD ["node", "server.js"]
