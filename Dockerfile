FROM alpine@sha256:5cc1526ee5c99c2982793abe22861e6047cfb5c8609cbe2d6bbe11d836263354 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:b09571a2710099c03a5bb8f2b18f6656b9af26cf63ea5b173b540c3e7b43eaab AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
