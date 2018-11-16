FROM golang:alpine as builder

COPY . /go/src/github.com/hendrikmaus/message-server
RUN apk update && \
    apk add make

WORKDIR /go/src/github.com/hendrikmaus/message-server
RUN make build

##################################################################

FROM alpine

COPY --from=builder /go/src/github.com/hendrikmaus/message-server/message-server /usr/local/bin
