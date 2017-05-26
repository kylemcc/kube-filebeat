FROM debian:jessie

# install forego, kube-gen, kubectl, and filebeat
ENV KUBE_GEN_VERSION 0.2.0
ENV FILEBEAT_VERSION 5.4.0
ADD https://storage.googleapis.com/kubernetes-release/release/v1.3.4/bin/linux/amd64/kubectl /usr/local/bin/
ADD https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz /tmp
ADD https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$FILEBEAT_VERSION-linux-x86_64.tar.gz /tmp
ADD https://github.com/kylemcc/kube-gen/releases/download/$KUBE_GEN_VERSION/kube-gen-linux-amd64-$KUBE_GEN_VERSION.tar.gz /tmp
RUN tar -C /usr/local/bin -xzvf /tmp/forego-stable-linux-amd64.tgz \
  && rm /tmp/forego-stable-linux-amd64.tgz \
  && tar -C /tmp -xvzf /tmp/filebeat-$FILEBEAT_VERSION-linux-x86_64.tar.gz \
  && mv /tmp/filebeat-$FILEBEAT_VERSION-linux-x86_64/filebeat /usr/local/bin \
  && rm -r /tmp/filebeat-$FILEBEAT_VERSION-linux-x86_64 /tmp/filebeat-$FILEBEAT_VERSION-linux-x86_64.tar.gz \
  && tar -C /usr/local/bin -xvzf /tmp/kube-gen-linux-amd64-$KUBE_GEN_VERSION.tar.gz \
  && rm /tmp/kube-gen-linux-amd64-$KUBE_GEN_VERSION.tar.gz \
  && chmod +x /usr/local/bin/forego \
  && chmod +x /usr/local/bin/filebeat \
  && chmod +x /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kube-gen

COPY . /app/
WORKDIR /app/

ENTRYPOINT ["forego", "start", "-r"]
