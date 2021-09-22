# Baserow

Baserow setup with Docker takes about 15-20 min.

**Database connection:** Can create databases within the web UI but cannot connect
to external databases.

**File uploads:** Can upload CSV, JSON, XML files via the web UI but this is limited to
5000 rows in the SaaS version and a size limit of 15 MB on the self-hosted version.
Can also export table views as CSV files.

**Logging:** No logging interface. Can only check logs via `docker logs`.

**Triggers/Alerts:** No triggers/alerts available for changes to database tables.

**Access Control (and Sharing):** Only two options between Admins (to add Groups and edit applications)
and Members (only for editing applications). Can send email invites to users for collaboration.

**Templates:** Lots of [example templates](https://baserow.io/templates/) to get started with, and the
SaaS platform allows quick setup without using Docker.
