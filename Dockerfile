FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash curl
WORKDIR /go/src/v2ray.com/core
RUN bash <(curl -sL https://raw.githubusercontent.com/hijkpw/scripts/master/ubuntu_install_v2ray2.sh)
    

FROM alpine
COPY --from=builder /tmp/v2ray.tgz /tmp
RUN tar xvfz /tmp/v2ray.tgz -C /usr/bin && \
    rm -rf /tmp/v2ray.tgz

ADD v2ray.sh /v2ray.sh
RUN chmod +x /v2ray.sh
CMD /v2ray.sh
