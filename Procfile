filebeat -e -c /app/filebeat.yml
kubeproxy: kubectl --server="$KUBERNETES_API_URL" proxy
kubegen: sleep 1; kube-gen -watch -type pods -wait 2s:10s -post-cmd 'pkill filebeat' /app/filebeat.yml.tmpl /app/filebeat.yml
