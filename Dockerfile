FROM alpine@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:db5089dcc4f11002d40e564bd46dba6937a27023e21d7b0b73fa1a89a5c1ed9f AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
