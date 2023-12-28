# Base image
FROM python:3.11-alpine

# Set the working directory
WORKDIR /app

RUN apk add --no-cache mariadb-connector-c-dev build-base

# Copy the requirements file
COPY ./requirements.txt requirements.txt

# Install dependencies
RUN pip3 install -r requirements.txt

# Copy the application code
COPY . .

# Expose the port
EXPOSE 8001

# Start the application
CMD ["python3", "app_auth.py"]
