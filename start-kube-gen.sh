#!/bin/bash

set -e
sleep 1
kube-gen -watch -type pods -wait 2s:10s -post-cmd 'pkill filebeat' /app/filebeat.yml.tmpl /app/filebeat.yml
