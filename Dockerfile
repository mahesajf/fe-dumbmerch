# Set the base image to Node 16 (distroless)
FROM node:16-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the current directory to the working directory in the container
COPY . .

# Install dependencies
RUN npm install

# Expose the port that the app will listen on
EXPOSE 3000

# Start the application
CMD ["yarn", "start"]
