# Use the official Golang image with a specific version.
FROM golang:1.20.5-alpine

RUN mkdir /app

# Copy the entire application source code to /app in the container.
ADD . /app

# Set the working directory to /app.
WORKDIR /app

# Copy the contents of the /app directory to the /app directory in the container (not necessary as it duplicates files).
COPY . /app/

EXPOSE 8000

# List the contents of the /app directory.
RUN ls -l /app

# Build the Go application and name the output binary "main".
RUN go build -o main.exe

CMD [ "/app/main.exe" ]
