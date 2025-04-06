FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install http-server globally
RUN npm install -g http-server
# Copy 80
COPY build ./build

# Expose the port
EXPOSE 3000

# Start the server
CMD ["http-server", "build", "-p", "3000"]
