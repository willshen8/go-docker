# Get the lastest golang base image
FROM golang:latest

LABEL maintainer="Will Shen"

RUN mkdir /app

ADD . /app

WORKDIR /app

# Build the Go app
RUN go build -o app/main .

CMD ["./app/main"]