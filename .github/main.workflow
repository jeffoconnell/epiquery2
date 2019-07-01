workflow "push our thing to ACR" {
  on = "push"
  resolves = ["push"]
}

action "only on interconnect-testing" {
  uses = "actions/bin/filter@master"
  args = "branch interconnect-testing"
}

action "Docker Login" {
  needs = "only on interconnect-testing"
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  env = {
    DOCKER_REGISTRY_URL = "interconnectregistry.azurecr.io"
  }
}

action "build" {
  needs = "Docker Login"
  uses = "actions/docker/cli@master"
  args = "build -t glg/epiquery2:latest ."
}

action "push" {
  needs = "build"
  uses = "actions/docker/cli@master"
  args = "push glg/epiquery2:latest"
}
