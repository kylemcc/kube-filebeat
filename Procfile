kubeproxy: kubectl --server="$KUBERNETES_API_URL" proxy
kubegen: sleep 1; kube-gen -watch -type pods -wait 2s:10s -post-cmd 'pkill filebeat' /app/filebeat.yml.tmpl /app/filebeat.yml
filebeat: /app/start-filebeat.sh
