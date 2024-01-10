# Base image
FROM node:21-alpine

# Set the working directory
WORKDIR /app
# Copy the package.json and package-lock.json files

COPY ./package*.json ./

# Install dependencies
RUN npm install

# Install vue cli
RUN npm install -g @vue/cli

# Copy the application code

COPY . .

# Build the application
RUN npm run build

CMD ["npm", "build"]

# Expose the port
EXPOSE 8080

# Start the application
CMD ["npm", "run", "serve"]