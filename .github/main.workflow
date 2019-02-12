workflow "New workflow" {
  on = "push"
  resolves = ["Push Image"]
}

action "Master Branch Filter" {
  uses = "actions/bin/filter@ec328c7554cbb19d9277fc671cf01ec7c661cd9a"
  args = "branch master"
}

action "Docker Registry" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Master Branch Filter"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Build Image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Docker Registry"]
  args = "build -t kylemcc/kube-filebeat:latest ."
}

action "Push Image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Build Image"]
  args = "push kylemcc/kube-filebeat:latest"
}
