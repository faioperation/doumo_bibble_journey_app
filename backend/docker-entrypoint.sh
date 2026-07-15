#!/bin/sh
set -e

# Function to wait for PostgreSQL
wait_for_postgres() {
  echo "Waiting for PostgreSQL at $DB_HOST:$DB_PORT..."
  while ! nc -z "$DB_HOST" "$DB_PORT"; do
    sleep 1
  done
  echo "PostgreSQL is up and running!"
}

# Wait for database if engine is postgresql
if [ "$DB_ENGINE" = "postgresql" ]; then
  wait_for_postgres
fi

# Run database migrations
if [ "$RUN_MIGRATIONS" = "true" ]; then
  echo "Running database migrations..."
  python manage.py migrate --noinput
fi

# Collect static files
if [ "$COLLECT_STATIC" = "true" ]; then
  echo "Collecting static files..."
  python manage.py collectstatic --noinput
fi

# Determine service type to run
# SERVICE_TYPE options: "wsgi" (Gunicorn web server), "asgi" (Daphne WebSocket server), "scheduler" (APScheduler runner)
SERVICE_TYPE="${SERVICE_TYPE:-wsgi}"

if [ "$SERVICE_TYPE" = "asgi" ]; then
  echo "Starting Daphne ASGI server..."
  exec daphne -b 0.0.0.0 -p 8000 bibble_project.asgi:application
elif [ "$SERVICE_TYPE" = "scheduler" ]; then
  echo "Starting APScheduler daemon..."
  exec python manage.py run_scheduler
else
  echo "Starting Gunicorn WSGI server..."
  exec gunicorn bibble_project.wsgi:application \
       --name bibble_project \
       --bind 0.0.0.0:8000 \
       --workers "${GUNICORN_WORKERS:-3}" \
       --log-level "${LOG_LEVEL:-info}" \
       --access-logfile - \
       --error-logfile -
fi
