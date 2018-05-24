FROM redis:4.0

RUN apt-get update && apt-get upgrade -y && apt-get install -y cron lsb-invalid-mta supervisor
COPY supervisor_cron.conf /etc/supervisor/conf.d/cron.conf
COPY boot.sh /usr/local/bin/boot
CMD ["/usr/local/bin/boot"]
