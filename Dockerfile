FROM mongo:3.2

RUN apt-get update \
 && apt-get -y install cron awscli \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV CRON_TIME="0 0 * * *" \
    TZ=Europe/Moscow \
    CRON_TZ=Europe/Moscow \
    INIT_BACKUP=true \
    MONGODB_HOST=mongo \
    MONGODB_PORT=27017

COPY *.sh /
RUN chmod +x *.sh

ENTRYPOINT ["./entry.sh"]