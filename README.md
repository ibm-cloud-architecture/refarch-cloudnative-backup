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
NAME                                            READY     STATUS             RESTARTS   AGE
bluecompute-auth-3701940813-jr4cq               1/1       Running            0          26m
bluecompute-customer-1247026218-wm166           1/1       Running            0          27m
bluecompute-customer-couchdb-1485455251-08mg8   1/1       Running            0          27m
bluecompute-web-deployment-1763171077-wc74h     1/1       Running            0          25m
catalog-ce-2251916216-6tghv                     1/1       Running            0          25m
catalog-elasticsearch-8g6h7                     1/1       Running            0          8s
catalog-elasticsearch-qx4ck                     1/1       Terminating        0          17m
inventory-ce-614843698-5qs5q                    0/1       CrashLoopBackOff   9          25m
inventory-mysql-1346511112-235wj                1/1       Running            0          27m
```

After a few minutes, you'll see that the BlueCompute Web UI has now a single item in the catalog.

## Restore

Follow these instrutions to restore the backup

````TBD, but when it's done, it will be awesome````
