workflow "Build and Publish Docker Image" {
  on = "push"
  resolves = ["Push Image"]
}

action "Master branch or tag" {
  uses = "actions/bin/filter@ec328c7554cbb19d9277fc671cf01ec7c661cd9a"
  args = "branch master || tag"
}

action "Docker Login" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = ["Master branch or tag"]
}

action "Build Image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "build -t kube-filebeat ."
  needs = ["Docker Login"]
}

action "Tag Image" {
  uses = "actions/docker/tag@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "--env kube-filebeat kylemcc/kube-filebeat"
  needs = ["Build Image"]
}

action "Push Image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Tag Image"]
  args = "push kylemcc/kube-filebeat"
}
