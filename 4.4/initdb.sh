#!/usr/bin/env bash

docker-compose run -w /usr/local/src/rt-4.4.3 -e RT_DB_HOST=db rt make initdb
