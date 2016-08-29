#!/bin/bash

cnt=0
while pgrep filebeat
do
	if [ $cnt -gt "0" ]; then
		sleep 1
	fi
	
	if [ $cnt -lt "3" ]; then
		kill $(pgrep filebeat)
	else
		kill -9 $(pgrep filebeat)
	fi
	cnt=$((cnt+1))
done
