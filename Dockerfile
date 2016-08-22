FROM busybox:1.25.0-glibc

ENV FILEBEAT_VERSION 1.2.3

# install forego, kube-gen, kubectl, and filebeat
ENV KUBE_GEN_VERSION 0.1.0
ADD https://storage.googleapis.com/kubernetes-release/release/v1.3.4/bin/linux/amd64/kubectl /usr/local/bin
RUN wget https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz \
  && tar -C /usr/local/bin -xzvf forego-stable-linux-amd64.tgz \
  && rm forego-stable-linux-amd64.tgz \
  && wget https://download.elastic.co/beats/filebeat/filebeat-$FILEBEAT_VERSION-x86_64.tar.gz \
  && tar -xvzf filebeat-$FILEBEAT_VERSION-x86_64.tar.gz \
  && mv filebeat-$FILEBEAT_VERSION-x86_64/filebeat /usr/local/bin \
  && rm -r filebeat-$FILEBEAT_VERSION-x86_64 filebeat-$FILEBEAT_VERSION-x86.tar.gz \
  && wget https://github.com/kylemcc/kube-gen/releases/download/$KUBE_GEN_VERSION/kube-gen-linux-amd64-$KUBE_GEN_VERSION.1.0.tar.gz \
  && tar -C /usr/local/bin -xvzf kube-gen-linux-amd64-$KUBE_GEN_VERSION.tar.gz \
  && rm /kube-gen-linux-amd64-$KUBE_GEN_VERSION \
  && chmod +x /usr/local/bin/forego \
  && chmod +x /usr/local/bin/filebeat \
  && chmod +x /usr/local/bin/kubectl
  && chmod +x /usr/local/bin/kube-gen

COPY . /app/
WORKDIR /app/

ENTRYPOINT ["forego", "start", "-r"]
