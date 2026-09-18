FROM alpine@sha256:5b02b42e375f7426f8d65c3af331ca05d9878f9989230354504e0b9dfd431f60 AS downloader
RUN apk add --no-cache curl

WORKDIR /tmp
RUN curl -O http://install.speedtest.net/ooklaserver/ooklaserver.sh


FROM frolvlad/alpine-glibc@sha256:7180a9c58e09bddbbf4bf4d63737954dafef2c3f1059d56ef520290455dc1ae4 AS runner

WORKDIR /opt/ookla
COPY --from=downloader /tmp/ooklaserver.sh .
RUN chmod +x ooklaserver.sh && ./ooklaserver.sh install -f

ENTRYPOINT [ "/opt/ookla/OoklaServer" ]
CMD ["start"]
