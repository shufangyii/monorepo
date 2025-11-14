# Stage 1: Build
FROM node:20-slim as builder

# Install pnpm
RUN npm install -g pnpm

WORKDIR /usr/src/app

# Copy dependency management files
COPY web/package.json web/pnpm-lock.yaml ./web/
WORKDIR /usr/src/app/web
RUN pnpm install --prod=false

# Copy source code and build
WORKDIR /usr/src/app
COPY web ./web
WORKDIR /usr/src/app/web
RUN pnpm run build

# Stage 2: Serve
FROM nginx:stable-alpine

# Copy built files
COPY --from=builder /usr/src/app/web/dist /usr/share/nginx/html

# Copy nginx configuration
COPY infra/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]