# Build stage
FROM alpine as builder
ENV MATCHBOX=http://matchbox.ngrok.io.ngrok.io
RUN apk add --no-cache cdrkit bash syslinux mtools gcc git make perl musl-dev xz-dev python3  \
 && rm -rf /var/cache/apk/* && pip3 install envtpl
RUN cd /; git clone https://github.com/ipxe/ipxe.git
COPY ipxe/matchbox.ipxe.tpl /ipxe/matchbox.ipxe.tpl
RUN envtpl /ipxe/matchbox.ipxe.tpl
WORKDIR /ipxe/src
RUN make bin/ipxe.iso EMBED=/ipxe/matchbox.ipxe

# Production image
FROM nginx:alpine
EXPOSE 80
RUN apk add --update --no-cache tzdata ca-certificates && update-ca-certificates
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY --from=builder /ipxe/src/bin/ipxe.iso /usr/share/nginx/html/matchbox.iso
# nginx drops privileges from here with the default entrypoint