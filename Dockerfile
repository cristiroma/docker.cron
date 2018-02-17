FROM debian:stretch-slim

RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends cron

RUN mkfifo -m 0666 /var/log/cron.log

RUN apt-get purge -y --auto-remove;

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
