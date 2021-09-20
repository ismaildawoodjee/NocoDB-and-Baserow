# NocoDB

Start setup:

    docker-compose up -d

Connect to database from NocoDB web UI using:

    Host Address: root_db
    Port Number: 5432
    Username: postgres
    Password: password
    Database: root_db

For external applications, use `localhost:5433` instead.

If trying to load data by executing SQL statements, the `NC_DB` variable does not provide
enough permissions for the user, and will result in a `Parser.parseErrorMessage`.
Instead, use the Postgres credentials in the `.env` file.

Each Project in the NocoDB UI allows connection to one schema only (default `public` schema).
To change this, the connection JSON in `Edit Connection JSON` has to be modified to include
a `searchPath`. See [issue](https://github.com/nocodb/nocodb/issues/226) on GitHub and the
linked video.
