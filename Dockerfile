FROM alpine@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:27813518e22cdbc883f287cf4e83ec989c9fb77ce04b592997717e5e7e4309af AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
