# Use Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy only package manager files first (for Docker cache efficiency)
COPY package.json pnpm-lock.yaml ./

# Install pnpm and dependencies
RUN npm install -g pnpm \
    && pnpm install

# Copy the rest of the app
COPY . .

# Ensure firebase-admin is installed (even if missing from main package.json)
RUN pnpm add firebase-admin

# Build n8n
RUN pnpm run build

# Expose port
EXPOSE 5678

# Start n8n
CMD ["pnpm", "start"]
