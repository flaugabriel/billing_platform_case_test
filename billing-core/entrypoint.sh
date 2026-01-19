#!/bin/bash
set -e
rm -f /app/tmp/pids/server.pid
echo "===> Waiting for Postgres..."
until nc -z postgres 5432; do
  sleep 1
done

echo "===> Running migrations..."
bundle exec rails db:create 
bundle exec rails db:migrate

echo "===> Starting Rails..."
bundle exec rails s -b 0.0.0.0
