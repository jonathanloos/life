#! /bin/sh
echo "Starting app"

# check for environment variables
env | grep RAILS

# exit in the event there is any error
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# If database exists, migrate. Otherwise, fail.
if [ "$RAILS_ENV" = "production" ]; then
  bundle exec rails db:migrate

  # start puma
  bundle exec puma -C config/puma-production.rb
else
  # install gems
  echo "[LIFE] Installing ruby gems"
  bundle check || (bundle config set --local without 'test production' && bundle install)

  # install node packages
  echo "[LIFE] Installing node packages"
  yarn install --check-files

  # If database exists, migrate. Otherwise setup (restore from prod)
  echo "[LIFE] Migrating the database"
  bundle exec rails db:migrate 2>/dev/null

  # Always running in dev mode!
  echo "[LIFE] forcing mode to development"
  bundle exec rails db:environment:set RAILS_ENV=development

  # Let's get the party started
  echo "[LIFE] Booting the server"
  if [ -n "$VSCODE_MODE" ]; then
    # https://github.com/Microsoft/vscode-recipes/tree/master/debugging-Ruby-on-Rails#bonus
    rdebug-ide --debug --host 0.0.0.0 --port 1234 -- /app/bin/rails server --binding 0.0.0.0 --port 3000
  else
    bundle exec rails server --binding 0.0.0.0 --port 3000
  fi
fi