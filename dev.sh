#!/bin/zsh
setopt shwordsplit

# helper shell functions that can be used to make development
# a joy!

function help () {
  echo "the following commands are available:"
  echo
  echo "modes:"
  echo "  dev     - set dev mode"
  echo "  mode    - display the current mode"
  echo
  echo "container:"
  echo "  build   - build the containers"
  echo "  go      - start the app and attach a console"
  echo "  shell   - open a shell in app"
  echo "  down    - down the docker environment"
  echo "  console - open rails console in app"
}

function dev () {
  mode "development"
}

function prod () {
  mode "production"
}

function mode () {
  if [ "$1" = "production" ]; then
    export RUN_MODE=production
    export DOCKER_COMPOSE_OPTIONS="--file ./docker/docker-compose.prod.yml --project-name life-prod"
  elif [ "$1" = "development" ]; then
    export RUN_MODE=development
    export DOCKER_COMPOSE_OPTIONS="--file ./docker/docker-compose.dev.yml --project-name life-dev"
  fi

  echo RUN_MODE=$RUN_MODE
}

function build () {
  docker-compose $DOCKER_COMPOSE_OPTIONS build
}

function shell () {
  docker-compose $DOCKER_COMPOSE_OPTIONS run --rm app /bin/sh
}

function console () {
  docker-compose $DOCKER_COMPOSE_OPTIONS run --rm app rails console
}

# launch a life development environment
function go () {
  echo "[LIFE] starting hangar environment"
  echo

  # check for an interactive shell with job control
  docker-compose $DOCKER_COMPOSE_OPTIONS up --abort-on-container-exit
}

function down () {
  echo "[LIFE] resetting development environment"
  docker-compose $DOCKER_COMPOSE_OPTIONS down -v --rmi all
}

function debug () {
  docker attach life_app
}


# call mode unless the variable is already set
if [ -z "$RUN_MODE" ]; then
  dev
fi

# check if this was called with an argument, if so, run that function
if [ $# -gt 0 ]; then
    $1
fi
