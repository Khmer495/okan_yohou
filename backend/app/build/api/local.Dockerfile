FROM golang:1.16.5-buster

WORKDIR /go/src/app

COPY . .
RUN go mod download \
    && go get -u github.com/cosmtrek/air

ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64

CMD ["air", "-c", ".air.toml"]
