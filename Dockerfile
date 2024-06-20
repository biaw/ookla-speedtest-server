FROM alpine@sha256:b2bf705cebbc5a03a0b58e49ec152261ea7da707f40f7d5db1c4f75ed72d43c1 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:d003dcc44b5041dd5bfc0c4a17d064786572d9fa9771d8df2e677a3cd2452094 AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
