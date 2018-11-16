# Message Server

A http server returning whatever message was set on any request.

Built for a special case study.

## Usage

```txt
Usage of ./message-server:
  -host string
      Host to bind to, e.g. localhost or 127.0.0.1 (default "localhost")
  -msg string
      Message to return for every request (default "Hello, World!")
  -port string
      Port to bind to (default "8081")
```

In Docker

```sh
docker run -it -p 8888:80 hendrikmaus/message-server:latest message-server -host=0.0.0.0 -port=80 -msg=Hello

curl localhost:8888
# Hello
```