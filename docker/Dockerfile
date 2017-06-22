FROM registry.ng.bluemix.net/ibm-backup-restore


RUN apt-get update \
 && apt-get -y install jq

ADD backup.py.diff /backup_restore
RUN cd /backup_restore \
 && patch backup.py backup.py.diff \
 && rm -f backup.py.diff

ADD scripts /scripts
RUN chmod a+x /scripts/*

ENTRYPOINT [ "/scripts/docker-entrypoint.sh" ]
CMD ["/bin/sh", "-c", "python run.py"]
