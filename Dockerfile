# ---- Build Stage ----
FROM rust:1.86-slim AS builder

# Install WASM target
RUN rustup target add wasm32-wasip1

# Create app directory
WORKDIR /app

# Cache dependencies
COPY Cargo.toml .
RUN mkdir src && echo 'fn main() {}' > src/lib.rs && cargo build --target wasm32-wasip1 --release
RUN rm -rf src

# Copy actual source
COPY . .

# Build the WASM module
RUN cargo build --target wasm32-wasip1 --release

# ---- Final Stage ----
FROM scratch

# Copy WASM binary and manifest
COPY --from=builder /app/target/wasm32-wasip1/release/hello_spin.wasm /hello_spin.wasm
COPY --from=builder /app/spin.toml /spin.toml
