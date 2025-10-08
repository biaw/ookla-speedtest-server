FROM alpine@sha256:56b31e2dadc083b6b067d6cd4e97a9c6e5a953e6595830c60d9197589ff88ad4 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:af49d5b571c748f71c58e23884fcdd5a3c4652f04a8842724c7b4d4a1248e51f AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
