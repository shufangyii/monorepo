# Monorepo Example: Vue.js + NestJS + Rust (gRPC)

This project is a monorepo example demonstrating a full-stack application using Vue.js for the frontend, NestJS for the backend, and Rust for a high-performance gRPC service.

## Technologies Used

- **Frontend**: [Vue.js 3](https://vuejs.org/)
- **Backend**: [NestJS](https://nestjs.com/)
- **gRPC Service**: [Rust](https://www.rust-lang.org/) with [Tonic](https://github.com/hyperium/tonic)
- **API Communication**: REST API (Vue to NestJS) and gRPC (NestJS to Rust)
- **Containerization**: [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

## Project Structure

The monorepo is organized into the following directories:

- `ai/`: The Rust-based gRPC service.
- `backend/`: The NestJS backend application.
- `web/`: The Vue.js 3 frontend application.
- `contracts/`: Contains the Protocol Buffers (`.proto`) definitions for gRPC.
- `infra/`: Contains Dockerfiles and other infrastructure-related configuration.

## Getting Started

### Prerequisites

Make sure you have the following installed on your local machine:

- [Node.js](https://nodejs.org/) (v20 or later)
- [pnpm](https://pnpm.io/)
- [Rust](https://www.rust-lang.org/tools/install)
- [Docker](https://www.docker.com/get-started)

### Local Development

To run the application locally, you need to start each service in a separate terminal.

**1. Start the Rust gRPC Service:**

```bash
cd ai
cargo run
```
The gRPC server will start on `localhost:50051`.

**2. Start the NestJS Backend:**

```bash
cd backend
pnpm install
pnpm run start:dev
```
The backend server will start on `http://localhost:3000`.

**3. Start the Vue.js Frontend:**

```bash
cd web
pnpm install
pnpm run start
```
The frontend development server will start on `http://localhost:5173` (or another port if 5173 is in use).

## Running with Docker

You can also build and run the entire application using Docker Compose.

```bash
docker-compose up --build
```

This will:
1. Build the Docker images for the `ai`, `backend`, and `web` services.
2. Start the containers.

The application will be available at `http://localhost:8080`.

## API

The NestJS backend exposes the following REST API endpoint:

- `GET /hello/:name`

This endpoint communicates with the Rust gRPC service to get a greeting. You can test it by visiting `http://localhost:3000/hello/world` (when running locally) or `http://localhost:8080/api/hello/world` (when running with Docker).
