FROM node:lts-alpine as builder

WORKDIR /app

COPY ./package.json ./

RUN npm install

COPY ./public ./public
COPY ./src ./src

COPY ./README.md ./
COPY ./.env ./

RUN npm run build

# All the files we need are in /app/build
FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/build  /usr/share/nginx/html


