# Cloud Native Backup

## Introduction

This project shows how to back up some components of the BlueCompute application.

## Deploy BlueCompute application

```
./install_bluecompute_ce.sh eduardo CASE-Production <api-key>
```

## Back up

* Find the Backup container
```
export BCK_ID=`kubectl get po |grep backup|awk '{print $1}'`
```

* Run the following command to check the backup status

```
kubectl logs $BCK_ID
```

You should see an output like this:

```
[2017-06-21 04:02:40,819] [utilities : 151] [INFO] *****************Start logging to ./Backup.log
[2017-06-21 04:02:40,819] [backup : 39] [INFO] Starting backup:
[2017-06-21 04:02:40,819] [configureOS : 22] [INFO] Configuring duplicity with IBM Bluemix ObjectStorage.
[2017-06-21 04:02:40,820] [configureOS : 13] [INFO] Configuring swift client.
[2017-06-21 04:02:40,820] [backup : 51] [INFO] Configuration done!!!
[2017-06-21 04:02:40,820] [backup : 67] [INFO] Got all required input from config file!!
[2017-06-21 04:02:40,820] [backup : 71] [INFO] *************All exported used envs are:   {'INVENTORY_MYSQL_SERVICE_PORT': '3306', 'KUBERNETES_PORT_443_TCP_ADDR': '10.10.10.1', 'INVENTORY_MYSQL_PORT_3306_TCP': 'tcp://10.10.10.233:3306', 'OS_PROJECT_ID': '0f64bd4bd6da481b8c8da6aed68a894d', 'BACKUP_NAME': 'patrocinio-inventory-mysql', 'KUBERNETES_PORT_443_TCP': 'tcp://10.10.10.1:443', 'CATALOG_ELASTICSEARCH_PORT_9300_TCP_ADDR': '10.10.10.70', 'LESSOPEN': '| /usr/bin/lesspipe %s', 'BACKUP_TYPE': 'incremental', 'SWIFT_AUTHVERSION': '3', 'CATALOG_ELASTICSEARCH_PORT_9200_TCP_ADDR': '10.10.10.70', 'HOME': '/root', 'PATH': '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', 'CATALOG_ELASTICSEARCH_PORT_9300_TCP_PORT': '9300', 'CATALOG_ELASTICSEARCH_PORT_9300_TCP': 'tcp://10.10.10.70:9300', 'SWIFT_AUTHURL': 'https://identity.open.softlayer.com/v3', 'KUBERNETES_SERVICE_PORT': '443', 'SWIFT_REGIONNAME': 'dallas', 'TERM': 'xterm', 'CATALOG_ELASTICSEARCH_SERVICE_PORT': '9200', 'CATALOG_ELASTICSEARCH_PORT_9200_TCP_PORT': '9200', 'INVENTORY_MYSQL_SERVICE_PORT_MYSQL': '3306', 'SHLVL': '2', 'KUBERNETES_SERVICE_HOST': '10.10.10.1', 'OS_AUTH_URL': 'https://identity.open.softlayer.com/v3', 'SCHEDULE_TYPE': 'periodic', 'CATALOG_ELASTICSEARCH_PORT_9200_TCP': 'tcp://10.10.10.70:9200', 'OS_USER_ID': '266d2076dfa94512ab6133f1f2bebce5', 'BACKUP_DIRECTORY': '/var/lib/mysql', 'CATALOG_ELASTICSEARCH_PORT_9200_TCP_PROTO': 'tcp', 'OS_PASSWORD': 'M!KiQ3.Cp4r3WVdK', 'SWIFT_USERID': '266d2076dfa94512ab6133f1f2bebce5', 'CATALOG_ELASTICSEARCH_PORT_9300_TCP_PROTO': 'tcp', 'INVENTORY_MYSQL_PORT': 'tcp://10.10.10.233:3306', 'CATALOG_ELASTICSEARCH_SERVICE_HOST': '10.10.10.70', 'OS_AUTH_VERSION': '3', 'INVENTORY_MYSQL_PORT_3306_TCP_PORT': '3306', 'CATALOG_ELASTICSEARCH_PORT': 'tcp://10.10.10.70:9200', 'KUBERNETES_PORT': 'tcp://10.10.10.1:443', 'PASSWORD': 'M!KiQ3.Cp4r3WVdK', 'KUBERNETES_SERVICE_PORT_HTTPS': '443', '_': '/usr/bin/python', 'SWIFT_TENANTID': '0f64bd4bd6da481b8c8da6aed68a894d', 'INVENTORY_MYSQL_SERVICE_HOST': '10.10.10.233', 'CATALOG_ELASTICSEARCH_SERVICE_PORT_TRANSPORT': '9300', 'KUBERNETES_PORT_443_TCP_PROTO': 'tcp', 'RESTORE_DIRECTORY': '/var/lib/mysql', 'LESSCLOSE': '/usr/bin/lesspipe %s %s', 'INVENTORY_MYSQL_PORT_3306_TCP_PROTO': 'tcp', 'INVENTORY_MYSQL_PORT_3306_TCP_ADDR': '10.10.10.233', 'PROJECTID': '0f64bd4bd6da481b8c8da6aed68a894d', 'REGION': 'dallas', 'HOSTNAME': 'inventory-backup-185714126-3j61g', 'USERID': '266d2076dfa94512ab6133f1f2bebce5', 'SWIFT_PASSWORD': 'M!KiQ3.Cp4r3WVdK', 'PWD': '/backup_restore', 'CATALOG_ELASTICSEARCH_SERVICE_PORT_HTTP': '9200', 'KUBERNETES_PORT_443_TCP_PORT': '443', 'LS_COLORS': 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:', 'SWIFT_USERNAME': '266d2076dfa94512ab6133f1f2bebce5', 'SCHEDULE_INFO': 'daily'}
[2017-06-21 04:02:42,481] [backup : 76] [INFO] Creating backup in BM Object Storage
[2017-06-21 04:02:44,264] [backup : 84] [INFO] The backup 'patrocinio-inventory-mysql' was created successfully
[2017-06-21 04:02:45,808] [backup : 107] [WARNING] Incremental backup was not created
[2017-06-21 04:02:45,809] [backup : 108] [INFO] duplicity  --no-encryption incremental /var/lib/mysql swift://patrocinio-inventory-mysql command failed due to Fatal Error: Unable to start incremental backup.  Old signatures not found and incremental specified

[2017-06-21 04:02:45,809] [backup : 109] [INFO] A full backup is required before incremental backups can begin. Creating a one-time full backup and will run incremental backups for scheduled backups.
[2017-06-21 04:02:54,402] [backup : 117] [INFO] Full backup completed
[2017-06-21 04:02:54,404] [backup : 118] [INFO] Local and Remote metadata are synchronized, no sync needed.
Last full backup date: none
```

## Simulate a failure

Run the following steps to simulate a database corruption:

* Find the MySQL POD:

```
export MYSQL_ID=`kubectl get po |grep mysql|awk '{print $1}'`
```

* Open an SSH connection to the MySQL POD:

```
kubectl exec -it $MYSQL_ID -- /bin/bash
```

You should see your MySQL container prompt:
```
root@inventory-mysql-1346511112-235wj:/#
```

* Type the following command:
```
mysql --user dbuser inventorydb --password
```
then type password as the pasword

* In the MySQL prompt, type the following command to list the item IDs:

```
mysql> select id from items;
```

You will see the following result:
```
+-------+
| id    |
+-------+
| 13401 |
| 13402 |
| 13403 |
| 13404 |
| 13405 |
| 13406 |
| 13407 |
| 13408 |
| 13409 |
| 13410 |
| 13411 |
| 13412 |
+-------+
12 rows in set (0.00 sec)
```

* Now delete all the records except one:

```
mysql> delete from items where id != 13401;
```

You should see the following result:

```
Query OK, 11 rows affected (0.04 sec)
```

* Exit the MySQL prompt by typing `quit` then type `exit` to exit the container shell.

Now the database records are cached in ElasticSearch, so we need to destroy the ElasticSearch POD in order to refresh the data.

* Run the following command to obtain the ElasticSearch and Inventory PODs:

```
export ES_ID=`kubectl get po |grep elasticsearch|awk '{print $1}'`
export INV_ID=`kubectl get po |grep inventory-ce|awk '{print $1}'`
```

* Now destroy the ElasticSearch and Inventory PODs:

```
kubectl delete po $ES_ID $INV_ID
```

* After a few seconds, you'll see that Kubernetes starts another ElasticSearch POD automatically:

```
eduardos-mbp:refarch-cloudnative-kubernetes edu$ kubectl get po
eduardos-mbp:inventory-mysql edu$ kubectl get po
NAME                                            READY     STATUS             RESTARTS   AGE
bluecompute-auth-3701940813-6r3w8               1/1       Running            0          6m
bluecompute-customer-1247026218-kmsz8           1/1       Running            0          8m
bluecompute-customer-couchdb-1485455251-c29b0   1/1       Running            0          8m
bluecompute-web-deployment-1763171077-d7zq6     1/1       Running            0          5m
catalog-ce-2251916216-hgs74                     1/1       Running            0          5m
catalog-elasticsearch-1g8wm                     1/1       Terminating        0          8m
catalog-elasticsearch-mnq2w                     1/1       Running            0          19s
inventory-ce-614843698-0f8fz                    0/1       CrashLoopBackOff   5          6m
inventory-mysql-3976943720-ftfv4                2/2       Running            0          8m

```

After a few minutes, you'll see that the BlueCompute Web UI has now a single item in the catalog.

## Restore

Follow these instrutions to restore the backup. 

* Stop the MySQL container
```
kubectl scale --replicas=0 deploy/inventory-mysql
```

* Connect to the Backup container
```
kubectl exec -it $BCK_ID bash
```

* Run the following command:
```
./vrestore
```

You will see the following output:
```
root@inventory-mysql-3976943720-ftfv4:/backup_restore# ./vrestore
[2017-06-20 18:15:21,209] [utilities : 151] [INFO] *****************Start logging to ./Restore.log
[2017-06-20 18:15:21,209] [restore : 28] [INFO] Starting the restore process.
[2017-06-20 18:15:21,209] [configureOS : 22] [INFO] Configuring duplicity with IBM Bluemix ObjectStorage.
[2017-06-20 18:15:21,209] [configureOS : 13] [INFO] Configuring swift client.
[2017-06-20 18:15:21,210] [restore : 40] [INFO] Configuration is completed.
[2017-06-20 18:15:27,839] [restore : 70] [INFO] Restoring the backup that is named 'patrocinio-inventory-mysql' is completed. Local and Remote metadata are synchronized, no sync needed.
```

Exit the container by typing `exit`

* Restart the MySQL container:
```
kubectl scale --replicas=1 deploy/inventory-mysql
```

* Log on to the MySQL container:

```
export MYSQL_ID=`kubectl get po |grep mysql|awk '{print $1}'`
kubectl exec -it $MYSQL_ID -- /bin/bash
```

You should see your MySQL container prompt:
```
root@inventory-mysql-1346511112-235wj:/#
```

* Type the following command:
```
mysql --user dbuser inventorydb --password
```
then type password as the pasword

* In the MySQL prompt, type the following command to list the item IDs:

```
mysql> select id from items;
```

You will see the following result:
```
+-------+
| id    |
+-------+
| 13401 |
| 13402 |
| 13403 |
| 13404 |
| 13405 |
| 13406 |
| 13407 |
| 13408 |
| 13409 |
| 13410 |
| 13411 |
| 13412 |
+-------+
12 rows in set (0.00 sec)
```



