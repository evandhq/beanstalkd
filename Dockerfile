FROM alpine:3.6

ENV TZ=Asia/Tehran

RUN apk update && \
    # Set the timezone
    apk add bash curl tzdata beanstalkd && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    # Clean up packages
    apk del tzdata && \
    rm -rf /var/cache/apk/*

EXPOSE 11300
CMD beanstalkd -p 11300 -z 524280 -b /var/lib/beanstalkd
