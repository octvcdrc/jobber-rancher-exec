Based on https://github.com/blacklabelops/jobber-cron

# How to use

Spin up a service in rancher and use these volumes :

* /var/run/docker.sock:/var/run/docker.sock 
* /var/lib/docker:/var/lib/docker:ro
* /etc/localtime:/etc/localtime:ro 

# Environment variables

Please see the [jobber-cron readme](https://github.com/blacklabelops/jobber-cron/blob/master/README.md).

# Execute commands based on the rancher service name

~~~
rancher-exec StackName_ServiceName 'command to execute > output_to_some_file'
~~~

So basically if you have a MariaDB container in a Databases stack and you want to back up the DB every day at 2am :
(replace * with a number)

* JOB_NAME*=Some backup of my DB
* JOB_COMMAND*=rancher-exec Databases_MariaDB 'mysqldump --all-databases > /backup/backup.sql'
* JOB_TIME*=0 0 2
