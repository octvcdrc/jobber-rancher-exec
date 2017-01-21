#!/bin/sh

# Some basic checks to make sure we use this command correctly
USAGE="Usage: rancher-exec StackName_ServiceName \"command to execute\""
if [ $# -eq 0 ]; then
	echo "No arguments supplied"
	echo $USAGE
	exit 1
fi

if [ $# -eq 1 ]; then
	echo "No command supplied"
	echo $USAGE
	exit 1
fi

if [ $# -gt 2 ]; then
	echo "Too many arguments. Please make sure to use quotes"
	echo $USAGE
	exit 1
fi

# The real deal. Based on https://github.com/sammarks/docker-rancher-backup/blob/master/backup.sh
for i in $(docker ps --format="{{ .ID }}"); do

        CONTAINER=$(docker inspect --format="{{ json .Config.Labels }}" $i | jq ".[\"io.rancher.project_service.name\"]" | sed -e 's/^"//'  -e 's/"$//' -e 's/\//_/' )

	if [ "$CONTAINER" = "$1" ]; then
		COMMAND="docker exec $i /bin/sh -c \"$2\""
		eval $COMMAND
	fi
done
exit 0
