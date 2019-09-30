FROM python:3.7.4-stretch
MAINTAINER Chris Conner chrism.conner@gmail.com

#Install supervisor
RUN apt-get update && apt-get install -y supervisor

#Make log dir for supervisor
RUN mkdir -p /var/log/supervisor

#Copy supervisor conf and app
COPY app-updater-supervisord.conf /etc/supervisor/conf.d/app-updater-supervisord.conf
COPY app_updater.sh /app_updater.sh

# volumes
VOLUME /app_update
VOLUME /dest_update
VOLUME /backups

#Environment variables
ENV APP_UPDATE_DIR /app_update
ENV DEST_UPDATE_DIR /dest_update
ENV BACKUP_DIR /backups
ENV RESTART_SERVICE NONE

CMD ["/usr/bin/supervisord"]
