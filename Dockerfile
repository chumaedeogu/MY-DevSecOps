# ---- Build Stage ----
FROM node:18-alpine AS base

# Set working directory
WORKDIR /app

# Copy dependency files first (better caching)
COPY package.json yarn.lock ./

# Install dependencies with frozen lockfile for reproducibility
RUN yarn install --frozen-lockfile

# Copy application source
COPY . .

# Build-time argument for API key
ARG TMDB_V3_API_KEY
# Environment variables (baked into the build by Vite)
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"

# Build the app
RUN yarn build

# ---- Runtime Stage ----
FROM nginx:stable-alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy built assets from builder
COPY --from=base /app/dist ./

# Copy custom nginx config for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Run nginx in foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
