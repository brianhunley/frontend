# Build stage
FROM node:lts-alpine AS base

WORKDIR '/app'

COPY package*.json .
RUN npm install

COPY ./src /app/src

FROM base AS build
RUN npm run build

# Production stage (serve with nginx)
FROM nginx:alpine AS prod
COPY --from=build /app/build /usr/share/nginx/html
