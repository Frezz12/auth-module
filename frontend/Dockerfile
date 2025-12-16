FROM oven/bun:1.1-alpine AS base
WORKDIR /app

FROM base AS frontend-builder
COPY frontend/package.json frontend/bun.lock frontend/pnpm-workspace.yaml ./frontend/
WORKDIR /app/frontend
RUN bun install
COPY frontend/ .
RUN bun run postinstall && bun run build

FROM oven/bun:1.1-alpine AS production
RUN apk --no-cache add ca-certificates
WORKDIR /app

COPY --from=frontend-builder /app/frontend/.output ./frontend/.output

EXPOSE 8090 3001

CMD sh -c "cd frontend/.output && bun server/index.mjs --port=3002"