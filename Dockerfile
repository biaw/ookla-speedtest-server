FROM alpine@sha256:69e0a8b6d2048be90290c992957a3cde2e87e955e5bb9c27d228c78c46c7840f AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:c3902fab3c21c33edb998d1f782088952243ba92893b357e2fea7125f34fe9ad AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
