#!/bin/bash

sleep 1
exec kube-gen -watch -type pods -wait 2s:10s -post-cmd '/app/kill-filebeat.sh' -host http://localhost:8001 /app/filebeat.yml.tmpl /app/filebeat.yml
