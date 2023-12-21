  GNU nano 6.2                                                                                   entrypoint.sh                                                                                             
#!/bin/bash
set -e

# If running the rails server then create or migrate existing database
if [ "${*}" == "./bin/rails server" ]; then
  ./bin/rails db:create
  ./bin/rails db:prepare
fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
