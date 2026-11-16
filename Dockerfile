FROM alpine@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:8df44680f856faee3345dea943a8d4bdc5d77b058a58008882bd0c2af107a6db AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
