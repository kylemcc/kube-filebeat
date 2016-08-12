# kube-filebeat

![nginx 1.9.15](https://img.shields.io/badge/nginx-1.9.15-brightgreen.svg?style=flat) ![License BSD](https://img.shields.io/badge/license-BSD-red.svg?style=flat) [![](https://img.shields.io/docker/stars/kylemcc/kube-filebeat.svg?style=flat)](https://hub.docker.com/r/kylemcc/kube-filebeat 'DockerHub') [![](https://img.shields.io/docker/pulls/kylemcc/kube-filebeat.svg?style=flat)](https://hub.docker.com/r/kylemcc/kube-filebeat 'DockerHub')

`kube-filebeat` is a Docker container running [filebeat][1] and [kube-gen][2]. `kube-gen` watches for events on the Kubernetes API and generates filebeat configurations (based on Pod annotations) to harvest logs from applications running in Kubernetes and ship them to logstash.

## Usage

TODO: fill me in

[1]: https://github.com/elastic/beats/tree/master/filebeat
[2]: https://github.com/kylemcc/kube-gen
