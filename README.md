# kube-filebeat

![License BSD](https://img.shields.io/badge/license-BSD-red.svg?style=flat) [![](https://img.shields.io/docker/stars/kylemcc/kube-filebeat.svg?style=flat)](https://hub.docker.com/r/kylemcc/kube-filebeat 'DockerHub') [![](https://img.shields.io/docker/pulls/kylemcc/kube-filebeat.svg?style=flat)](https://hub.docker.com/r/kylemcc/kube-filebeat 'DockerHub')

`kube-filebeat` is a Docker container running [filebeat][1] and [kube-gen][2]. `kube-gen` watches for events on the Kubernetes API and generates filebeat configurations (based on Pod annotations) to harvest logs from applications running in Kubernetes and ship them to logstash.

**Note**: This project is mostly experimental. It relies on and exploits the mechanics of Docker's filesystem layer. The implementation here only works for Docker versions >= 1.10.0 and may break at any time.

## Usage

Due to the mechanics of how `kube-filebeat` operates, it needs to be running on any node from which you would like to collect logs. The recommended way to acheive this is to run `kube-filebeat` as a [Daemon Set][3]. [For example][4]:

```yaml
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: "kube-filebeat"
  annotations:
    description: "automated log shipper powered by annotations"
spec:
  template:
    spec:
      containers:
        -
          name: "kube-filebeat"
          image: "kylemcc/kube-filebeat:latest"
          env:
            -
              name: LOGSTASH_HOSTS
              value:  logstash.default.svc.cluster.local:5044
            -
              name: KUBERNETES_API_URL
              value: http://10.1.2.3:8080
          volumeMounts:
            - name: docker
              mountPath: /var/lib/docker
          imagePullPolicy: "Always"
      restartPolicy: "Always"
      volumes:
        - name: docker
          hostPath:
            path: /var/lib/docker
```

### Configuration

Annotations are used to inform `kube-fealbeat` of files that should be harvested. [For example][5]:

```yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kube_filebeat: >
      [
          {
              "log": "/var/log/example-app/output.log",
              "ignore_older": "24h",
              "close_older": "24h",
              "fields": {
                  "app": "example-app",
                  "version": "1.2.3"
              },
              "multiline": {
                  "pattern": "^(([[:alpha:]]{3} [0-9]{1,2}, [0-9]{4} [0-9]{1,2}:[0-9]{2}:[0-9]{2})|([0-9]{4}-[0-9]{2}-[0-9]{2}))",
                  "negate": true,
                  "match": "after"
              }
          },
          {
              "log": "/var/log/nginx/access.log",
              "exclude_lines": [".*Go-http-client/1\\.1.*"],
              "ignore_older": "24h",
              "close_older": "24h",
              "fields": {
                  "app": "example-app",
                  "version": "1.2.3",
                  "type": "access_log"
              }
          }
      ]
  name: example-app
spec:
  containers:
    - image: example-app:1.2.3
      name: example-app

```

[1]: https://github.com/elastic/beats/tree/master/filebeat
[2]: https://github.com/kylemcc/kube-gen
[3]: http://kubernetes.io/docs/admin/daemons/
[4]: https://github.com/kylemcc/kube-filebeat/blob/master/kube-filebeat-daemonset.yaml
[5]: https://github.com/kylemcc/kube-filebeat/blob/master/example-pod.yaml
