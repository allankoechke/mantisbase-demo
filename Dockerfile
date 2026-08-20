# Stage 1: build the admin UI (static export → out/)
FROM node:20-alpine AS ui-builder
WORKDIR /app

COPY mb/package.json mb/package-lock.json ./
RUN npm ci

COPY mb/ ./
COPY next.config.demo.mjs ./next.config.mjs
COPY .env-prod .env
RUN rm -rf /app/out
RUN npm run build

# Stage 2: mantisbase image + built UI in /mb/public + default DB in /mb/data-default
FROM allankoech/mantisbase:beta
WORKDIR /mb

ENV NEXT_PUBLIC_BASE_PATH=""
ENV NEXT_PUBLIC_MB_IS_DEMO_MODE="true"
ENV NODE_ENV=production

COPY --from=ui-builder /app/out/ ./public/
COPY db/data ./data-default/
COPY scripts/docker-entrypoint.sh /entrypoint.sh

# Inject analytics script
COPY inject-analytics.sh /inject-analytics.sh
RUN chmod +x /inject-analytics.sh
RUN /inject-analytics.sh /mb/public

EXPOSE 80
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
