#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py collectstatic --noinput --clear
python manage.py makemigrations --settings=projectGoguma.settings.dev
python manage.py migrate --settings=projectGoguma.settings.dev

exec "$@"