FROM mantisbase:latest

# Change the working directory to /mb
WORKDIR /mb

# Copy database files to the container
COPY ./mb /mb
