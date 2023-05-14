# buildkit跨架构编译缓慢，若未使用CGO，可统一使用本机架构：BUILDPLATFORM，进行交叉编译
FROM image.ccos.io/ccos-ceake/golang:1.19
ENV GOOS=linux
ENV CGO_ENABLED=0
ENV TZ=Asia/Shanghai
COPY . /caddy
WORKDIR /caddy
RUN go build -mod vendor -o /usr/bin/caddy cmd/caddy/main.go
RUN mkdir -p /etc/caddy /usr/share/caddy && cp /caddy/others/Caddyfile /etc/caddy/Caddyfile && cp /caddy/others/index.html /usr/share/caddy/index.html
CMD ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
