# ------------------------------------------------------------------------------
#  Build stage
# ------------------------------------------------------------------------------
FROM arm32v6/alpine:3.9 as builder

ENV VERSION=0.17.0
ENV SYSTEM=linux
ENV ARCH=armv7

WORKDIR /tmp
RUN apk add --no-cache curl
RUN curl --location --output node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.${SYSTEM}-${ARCH}.tar.gz;
RUN tar xf node_exporter.tar.gz --strip 1

# ------------------------------------------------------------------------------
# Package stage
# ------------------------------------------------------------------------------
FROM arm32v6/alpine:3.9

COPY --from=builder /tmp/node_exporter /bin/node_exporter

EXPOSE      9100
USER        nobody
ENTRYPOINT [ "/bin/node_exporter" ]