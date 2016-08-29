#!/bin/bash

sleep 1
exec kube-gen -watch -type pods -wait 2s:10s -post-cmd '/app/restart-filebeat.sh' /app/filebeat.yml.tmpl /app/filebeat.yml
