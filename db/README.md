# Default database state

Place the MantisBase data files you want as the "default" state here.

When using `docker-compose up`, this directory is mounted read-only and its contents are copied into `/mb/data` in the container on every start. The container is configured to restart every 30 minutes, so the portal data resets to this default each time.
