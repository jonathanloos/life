#! /bin/sh
echo "Starting webpacker"

if [ "$RAILS_ENV" != "development" ]; then
  echo "[LIFE] Only run webpacker in development"
  exit 1
fi

# check for environment variables
env | grep RAILS

# exit in the event there is any error
set -e

# install gems
echo "[LIFE] Installing ruby gems"
bundle check || bundle install

# install node packages
echo "[LIFE] Installing node packages"
yarn install --check-files

echo "[LIFE] Booting webpacker-dev-server"
./bin/webpack-dev-server