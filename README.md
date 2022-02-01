# NflRushing

Running the project with docker:

- Build the images and setup the db with `docker-compose run --rm phoenix mix ecto.setup`
- Start the services with `docker-compose up`

Running manually using a local Postgres instance:

- Update config/dev.exs

```diff
config :nfl_rushing, NflRushing.Repo,
   username: "postgres",
   password: "postgres",
-  hostname: "db",
+  hostname: "localhost",
   database: "nfl_rushing_dev",
```

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
