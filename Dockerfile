# Build stage
FROM node:lts-alpine AS base

WORKDIR '/app'

COPY package*.json .
RUN npm install

# Copy only the src and public folders
COPY src/ ./src/
COPY public/ ./public/

FROM base AS build
RUN npm run build

# Production stage (serve with nginx)
FROM nginx:alpine AS prod
COPY --from=build /app/build /usr/share/nginx/html
