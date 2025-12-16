# Use the official Bun image
FROM oven/bun:1.2-alpine AS base

# Install dependencies only when needed
FROM base AS deps
WORKDIR /app

# Copy package files
COPY package.json bun.lock* ./

# Install dependencies
RUN bun install --frozen-lockfile

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Set environment variables for build
ENV NODE_ENV=production
ENV NITRO_HOST=0.0.0.0

# Build the application
RUN bun run build

# Production image, copy all the files and run bun
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NITRO_HOST=0.0.0.0
ENV PORT=3000

# Create a non-root user
RUN addgroup --system --gid 1001 bunjs
RUN adduser --system --uid 1001 bunjs

# Copy built output
COPY --from=builder /app/.output ./.output

# Set ownership of the app directory
RUN chown -R bunjs:bunjs /app

# Switch to non-root user
USER bunjs

# Expose port
EXPOSE 3000

# Start the application
CMD ["bun", ".output/server/index.mjs"]