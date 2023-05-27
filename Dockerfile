FROM golang:1.18

WORKDIR /app

COPY ./ .

COPY go.mod go.sum ./

RUN go mod download

CMD go run main.go