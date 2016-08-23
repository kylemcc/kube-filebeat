#!/bin/bash

set -e

while [ ! -f "/app/filebeat.yml" ];
do
	sleep 1
done

filebeat -e -c /app/filebeat.yml
