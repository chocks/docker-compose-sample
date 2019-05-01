#!/usr/bin/env bash

source /virtualenv/compose/bin/activate

until psql -h"$DB_HOST" -U"$DB_USER" -d"$DB_NAME" -c '\q'; do
      echo "Postgres $DB_HOST is un-available - sleeping"
      sleep 10
done

db_init=0
while [[ "$db_init" == "0" ]] ; do
    init=`psql -h"$DB_HOST" -U"$DB_USER" -d"$DB_NAME" -c "\d users"`
    if [[ "$init" == *'Table "public.users"'* ]]; then
        db_init=1
        break
    fi
sleep 30
done

exec python /app/app.py
