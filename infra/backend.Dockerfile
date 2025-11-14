# Stage 1: Builder
FROM node:20-slim as builder

# Install protoc and pnpm
RUN apt-get update && apt-get install -y protobuf-compiler && npm install -g pnpm

WORKDIR /usr/src/app

# Copy dependency files and install all dependencies
COPY backend/package.json backend/pnpm-lock.yaml ./backend/
WORKDIR /usr/src/app/backend
RUN pnpm install --prod=false

# Copy source code
WORKDIR /usr/src/app
COPY backend ./backend
COPY contracts ./contracts

# Generate proto files and build
WORKDIR /usr/src/app/backend
RUN pnpm run proto:gen
RUN pnpm run build

# Stage 2: Production image
FROM node:20-slim

# Install pnpm
RUN npm install -g pnpm

WORKDIR /usr/src/app

# Copy dependency files and install only production dependencies
COPY --from=builder /usr/src/app/backend/package.json /usr/src/app/backend/pnpm-lock.yaml ./backend/
WORKDIR /usr/src/app/backend
RUN pnpm install --prod

# Copy built application and contracts
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/backend/dist ./backend/dist
COPY --from=builder /usr/src/app/contracts ./contracts

EXPOSE 3000

WORKDIR /usr/src/app/backend
CMD ["node", "dist/main"]