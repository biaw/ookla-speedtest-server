FROM alpine@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:fffd7f5dbd5e8d12f11925e49122943a2e5029a340e582b5c99597a9e16d1bd5 AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
