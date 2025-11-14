# Stage 1: Builder
FROM rust:1-slim as builder

# Install protoc
RUN apt-get update && apt-get install -y protobuf-compiler

WORKDIR /usr/src/app

# Copy contracts
COPY contracts/proto ./contracts/proto

# Copy ai service files
COPY ai/Cargo.toml ai/Cargo.lock ./ai/
COPY ai/src ./ai/src
COPY ai/build.rs ./ai/

# Build the application
WORKDIR /usr/src/app/ai
RUN cargo build --release

# Stage 2: Final image
FROM debian:stable-slim

# Copy the compiled binary from the builder stage
COPY --from=builder /usr/src/app/ai/target/release/ai /usr/local/bin/ai

EXPOSE 50051

CMD ["ai"]
