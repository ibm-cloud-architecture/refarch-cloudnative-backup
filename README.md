# Cloud Native Backup

## Introduction

This project shows how to back up some components of the BlueCompute application.

## Back up

Follow these instructions to add a scheduled backup to BlueCompute database

``` TBD, but when it's done, it will be awesome ```

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

* Exit the MySQL prompt by typing `quit` then type ^D to exit the container shell.

Now the database records are cached in ElasticSearch, so we need to destroy the ElasticSearch POD in order to refresh the data.

* Run the following command to obtain the ElasticSearch POD:

```
export ES_ID=`kubectl get po |grep elasticsearch|awk '{print $1}'`
```

* Now destroy the ElasticSearch POD:

```
kubectl delete po $ES_ID
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

Follow these instrutions to restore the backup. This step assumes you ran the "Simulate a failure" section.

* Connect to the Backup container
```
kubectl exec -it $MYSQL_ID -c inventory-backup-container bash
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
* Let's validate that the database now has 12 items. Log on to the MySQL container:

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



