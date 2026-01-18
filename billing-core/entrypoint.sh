#!/bin/bash
set -e

bundle install

bundle exec rails db:prepare

bundle exec rails s -b 0.0.0.0
