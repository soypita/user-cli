FROM golang:1.14.0 as builder

RUN mkdir /app
WORKDIR /app

COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o user-cli


FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/user-cli .

CMD ["./user-cli"]