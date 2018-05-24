FROM redis:4.0

RUN apt-get update && apt-get upgrade -y && apt-get install -y cron lsb-invalid-mta supervisor
COPY supervisor_cron.conf /etc/supervisor/conf.d/cron.conf
COPY supervisor_redis.conf /etc/supervisor/conf.d/redis.conf
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
