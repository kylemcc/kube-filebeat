#!/bin/bash

cnt=0
pid=$(pgrep -x filebeat)
while kill -0 $pid > /dev/null 2>&1
do
	if [ $cnt -gt "0" ]; then
		sleep $((2**$cnt))
	fi
	
	if [ $cnt -lt "3" ]; then
		echo "Killing filebeat pid:$pid"
		kill $pid > /dev/null 2>&1
	else
		echo "Force-killing filebeat pid:$pid"
		kill -9 $pid > /dev/null 2>&1
	fi
	cnt=$((cnt+1))
done
