# Replicator

This project allow you to restore the last Scalingo PostgreSQL backup in an another app.

The app need to have a PostgreSQL addon and 3 env variables set:
- `SCALINGO_CLI_TOKEN` that you can create here https://dashboard.scalingo.com/account/tokens
- `SOURCE_APP` the name of the app where the backup will be fetched
- `BUILDPACK_URL=https://github.com/Scalingo/nginx-buildpack.git` in order for the app to be deployable

You also need to follow this documentation since our app won't have any web container (any container at all actually).
https://doc.scalingo.com/platform/app/web-less-app
