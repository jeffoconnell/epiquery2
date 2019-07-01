action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "build" {
  uses = "actions/docker/cli@master"
  args = "build -t glg/epiquery2:latest ."
}

action "push" {
  uses = "actions/docker/cli@master"
  args = "push glg/epiquery2:latest"
}
