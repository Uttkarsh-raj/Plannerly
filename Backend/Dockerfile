# Use the official Golang image with a specific version.
FROM golang:1.20.5-alpine

RUN mkdir /app

ADD . /app

WORKDIR /app

COPY . /app/

EXPOSE 8000

RUN go build -o main .

CMD [ "/app/main" ]