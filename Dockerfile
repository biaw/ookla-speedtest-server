FROM alpine@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:a902915147ff74d2a093fe73fd2e5656468a32d0fa749ea26939c7a1823455bc AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
