#!/bin/bash
set -e
rm -f /www/app/tmp/pids/server.pid
exec "$@"