# -----------------------------------------
# Build stage
# -----------------------------------------
FROM node:lts-alpine AS build

WORKDIR '/app'

COPY package*.json .
RUN npm install

# Copy only the src and public folders
COPY src/ ./src/
COPY public/ ./public/

RUN npm run build

# -----------------------------------------
# Production stage (serve with nginx)
# -----------------------------------------
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]