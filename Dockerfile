# BASE CONTAINER FOR PREPARE LIB
FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./
ARG NODE_ENV=production
RUN if [ "$NODE_ENV" = "development" ] || [ "$NODE_ENV" = "test" ]; then \
      npm ci; \
    else \
      npm ci --only=production; \
    fi


FROM base AS development
ENV NODE_ENV=development
COPY . .
CMD ["node", "index.js"]


FROM base AS test
ENV NODE_ENV=test
COPY . .
RUN npm test
CMD ["node", "index.js"]

# reduce space and harden sucurity on runtime with user-nonroot
FROM node:18-alpine AS production
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force
COPY --chown=nodejs:nodejs . .
USER nodejs
ENV NODE_ENV=production
CMD ["node", "index.js"]

