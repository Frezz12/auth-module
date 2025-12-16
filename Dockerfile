# Multi-stage Dockerfile for auth-module using bun
FROM oven/bun:latest-alpine AS base
WORKDIR /app

# Frontend build stage
FROM base AS frontend-builder
# Copy frontend package files
COPY frontend/package.json frontend/bun.lock frontend/pnpm-workspace.yaml ./frontend/
# Install frontend dependencies
WORKDIR /app/frontend
RUN bun install --frozen-lockfile
# Copy frontend source code and build
COPY frontend/ .
RUN bun run postinstall && bun run build

# Backend build stage
FROM golang:1.25-alpine AS backend-builder
WORKDIR /app/backend
COPY backend/ .
RUN CGO_ENABLED=0 GOOS=linux go build -o pocketbase .

# Production stage
FROM oven/bun:latest-alpine AS production
RUN apk --no-cache add ca-certificates
WORKDIR /app

# Copy backend
COPY --from=backend-builder /app/backend/pocketbase ./pocketbase
COPY backend/pb_data ./pb_data

# Copy frontend build
COPY --from=frontend-builder /app/frontend/.output ./frontend/.output

# Expose ports for backend (8090) and frontend (3001)
EXPOSE 8090 3001

# Start both backend and frontend
CMD sh -c "./pocketbase serve --http=0.0.0.0:8090 & cd frontend/.output && bun server/index.mjs --port=3001"