FROM alpine@sha256:0695fb1256c60a18a975f6246ee757cbf7f9b679d88e8eb9560c0e0a5c4324f7 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:d003dcc44b5041dd5bfc0c4a17d064786572d9fa9771d8df2e677a3cd2452094 AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
