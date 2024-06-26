FROM golang:latest as builder
WORKDIR /app
COPY . .
RUN rm -rf .git*
RUN GOOS=linux CGO_ENABLED=0 go build -ldflags="-w -s -X main.version=1.0.0" -o server .

FROM scratch
COPY --from=builder /app/server .
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

CMD ["./server"]