use Mix.Config

config :db, Db.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "db_repo_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
]
