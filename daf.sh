#!/bin/zsh
setopt shwordsplit

# helper shell functions that can be used to make development
# a joy!

function help () {
  echo "the following commands are available:"
  echo
  echo "modes:"
  echo "  dev     - set dev mode"
  echo "  stage   - set stage mode"
  echo "  mode    - display the current mode"
  echo
  echo "container:"
  echo "  build   - build the containers"
  echo "  go      - start the app and attach a console"
  echo "  console - open rails console in app"
  echo "  shell   - open a shell in app"
  echo "  down    - down the docker environment"
  echo "  redo    - redo the whole dang thing"
  echo
  echo "db:"
  echo "  sync        - pull the prod database"
  echo "  import      - import a local prod database"
  echo "  export_sql  - export a tar version of the current database"
  echo "  import_sql  - import a tar version of the current database"
  echo "  ci          - run through CI with a local staging environment (stage mode only)"
  echo "  knox        - CI security step (stage mode only)"
}

function dev () {
  mode "development"
}

function staging () {
  mode "staging"
}

function mode () {
  if [ "$1" = "staging" ]; then
    export DAF_MODE=staging
    export DAF_COMPOSE_OPTIONS="--file ./docker/docker-compose.staging.yml --project-name staging"
  elif [ "$1" = "development" ]; then
    export DAF_MODE=development
    export DAF_COMPOSE_OPTIONS="--file ./docker/docker-compose.dev.yml --project-name development"
  fi
  echo DAF_MODE=$DAF_MODE
}

function build () {
  docker-compose $DAF_COMPOSE_OPTIONS build
}

function console () {
  docker-compose $DAF_COMPOSE_OPTIONS run --rm app rails console
}

function shell () {
  docker-compose $DAF_COMPOSE_OPTIONS run --rm app /bin/bash
}

# launch a dispatch development environment
function go () {
  echo "[DAF] checking for prereqs"

  if [ "$DAF_MODE" = "development" ]; then
    KEY_FILE=config/credentials/development.key
  elif [ "$DAF_MODE" = "staging" ]; then
    KEY_FILE=config/credentials/staging.key
  fi

  if [ ! -f $KEY_FILE ]; then
    echo "ERROR: missing $KEY_FILE file"
    exit 1
  fi

  echo "[DAF] starting hangar environment"
  echo

  echo '
  _____   ____    _____ _______   ______ ____  _____     _____          _   _          _____          _
 |  __ \ / __ \  |_   _|__   __| |  ____/ __ \|  __ \   / ____|   /\   | \ | |   /\   |  __ \   /\   | |
 | |  | | |  | |   | |    | |    | |__ | |  | | |__) | | |       /  \  |  \| |  /  \  | |  | | /  \  | |
 | |  | | |  | |   | |    | |    |  __|| |  | |  _  /  | |      / /\ \ | . ` | / /\ \ | |  | |/ /\ \ | |
 | |__| | |__| |  _| |_   | |    | |   | |__| | | \ \  | |____ / ____ \| |\  |/ ____ \| |__| / ____ \|_|
 |_____/ \____/  |_____|  |_|    |_|    \____/|_|  \_\  \_____/_/    \_\_| \_/_/    \_\_____/_/    \_(_)


⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣄⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣴⣿⡄⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠰⣶⣾⣿⣿⣿⣿⣿⡇⠀⢠⣷⣤⣶⣿⡇⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣀⣿⣿⣿⣿⣿⣧⣀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⣷⣦⣀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⢲⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠚⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠂⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⢻⣿⣿⡿⠛⠉⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠋⠁⠀⠀⠀⠸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  '


  # check for an interactive shell with job control
  if [[ -o interactive ]]; then
      docker-compose $DAF_COMPOSE_OPTIONS up --abort-on-container-exit &
      _job=$!

    # docker_app is up, let's attach for debug!
    ./term.oascript `pwd`

    # fg the dev process
    fg
  else
    docker-compose $DAF_COMPOSE_OPTIONS up --abort-on-container-exit
  fi
}

# sync the production database locally
function sync () {
  docker-compose $DAF_COMPOSE_OPTIONS run --rm app rails prod:sync
}

# import the production database locally
function import () {
  docker-compose $DAF_COMPOSE_OPTIONS run --rm app rails prod:import
}

function down () {
  echo "[DAF] resetting development environment"
  docker-compose $DAF_COMPOSE_OPTIONS down -v --rmi all
}

function redo () {
  echo "[DAF] resetting all environments"
  dev
  docker-compose $DAF_COMPOSE_OPTIONS down -v --rmi all

  staging
  docker-compose $DAF_COMPOSE_OPTIONS down -v --rmi all

  # clean-up the docker image itself from CI builds
  # docker run --rm -it --privileged --pid=host alpine nsenter -t 1 -m -u -n -i sh -c "rm -rf /containers/services/docker/rootfs/var/cache/*"
  docker run --rm -it --privileged --pid=host alpine sh -c "rm -rf /containers/services/docker/rootfs/var/cache/*"

  dev
}

function check_and_install_drone() {
  if [ ! -f drone ]; then
    echo "[DAF] installing drone"
    curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_darwin_amd64.tar.gz | tar zx
  fi
}

function knox () {
  echo "[DAF] forcing mode to staging"
  staging

  # capture the start time
  start=`date +%s`

  # make sure we have drone
  check_and_install_drone

  # run the CI pipeline
  ./drone exec --trusted .drone.security.yml
  if [ $? -ne 0 ]; then
    echo "[DAF] Error: failed to run pipeline, refusing to continue"
    return 1
  fi

  # capture the runtime
  end=`date +%s`
  runtime=$((end-start))
  minutes=$((runtime / 60))

  echo "[DAF] completed in $minutes minutes"
}

# run the drone ci pipeline
function ci () {
  # force mode to staging, ci is only available in the staging environment
  echo "[DAF] forcing mode to staging"
  staging

  # capture the start time
  start=`date +%s`

  # make sure we have drone
  check_and_install_drone

  # check if we have a registry and start it before running drone
  if docker ps | grep -q registry; then
    echo "[DAF] found a registry running, doing nothing"
  elif docker ps -a | grep -q registry; then
    echo "[DAF] found a registry but need to start it"
    docker start registry
  else
    echo "[DAF] didn't find a registry, starting one"
    docker run -d -p 5000:5000 --name registry registry:2
  fi

  # run the CI pipeline
  ./drone exec --trusted .drone.staging.yml
  if [ $? -ne 0 ]; then
    echo "[DAF] Error: failed to run pipeline, refusing to continue"
    return 1
  fi

  # pull the resulting image back to the local docker
  docker pull localhost:5000/dispatch:slim

  # toast the registry
  docker stop registry

  # capture the runtime
  end=`date +%s`
  runtime=$((end-start))
  minutes=$((runtime / 60))

  echo "[DAF] completed in $minutes minutes"
}

# export the current (based on DAF_MODE) database volume as a tar file which can then
# be shared with others <3
function export_sql () {
  docker-compose $DAF_COMPOSE_OPTIONS run --detach --rm --name db_export_sql db

  # trash
  echo "waiting for db to start ..."
  sleep 20

  docker exec -it db_export_sql /bin/bash -c "pg_dump --clean --if-exists --create --username postgres lift_development" > db/export/lift_development.dump

  docker stop db_export_sql
  docker rm --force db_export_sql

  echo "db/export/lift_development.dump"
}

function import_sql () {
  if [ ! -f $(pwd)/db/export/lift_development.dump ]; then
    echo "[DAF] missing backup to import at: "$(pwd)"/db/export/lift_development.dump"
    return 1
  fi

  docker-compose $DAF_COMPOSE_OPTIONS run --detach --rm --name db_export_sql db

  # trash
  echo "waiting for db to start ..."
  sleep 20

  docker exec -i db_export_sql /bin/bash -c "psql --username postgres lift_development" < db/export/lift_development.dump
  # docker exec -i db_export_sql pg_restore -U postgres -v -d lift_development -C --clean --no-acl --no-owner < db/export/lift_development.dump
  sleep 5

  docker stop db_export_sql
  docker rm --force db_export_sql
}

# clone the development database to staging
function clone () {
  source=development_postgres_data
  destination=staging_postgres_data

  #Check if the source volume name does exist
  docker volume inspect $source > /dev/null 2>&1
  if [ "$?" != "0" ]; then
    echo "The source volume \"$source\" does not exist"
    return
  fi

  # Now check if the destinatin volume name does not yet exist
  docker volume inspect $destination > /dev/null 2>&1

  if [ "$?" != "0" ]; then
    echo "[DAF] creating destination volume \"$destination\"..."
    docker volume create --name $destination
    # echo "[DAF] The destination volume \"$destination\" already exists, removing it"
    # docker volume remove $destination
    return
  fi

  echo "[DAF] copying data from source volume \"$source\" to destination volume \"$destination\"..."
  docker run --rm \
            -i \
            -t \
            -v $source:/from \
            -v $destination:/to \
            alpine ash -c "cd /from ; cp -av . /to"
}

# call mode unless the variable is already set
if [ -z "$DAF_MODE" ]; then
  dev
fi

# check if this was called with an argument, if so, run that function
if [ $# -gt 0 ]; then
    $1
fi
