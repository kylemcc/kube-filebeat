#!/bin/bash

pkill filebeat
exec filebeat -e -c /app/filebeat.yml
