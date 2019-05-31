grant_db_permissions <- function(database, grant_username, schema = "public", db_user = Sys.getenv("db_userid"), db_pass = Sys.getenv("db_pwd")) {
  con <- DBI::dbConnect(drv = RPostgreSQL::PostgreSQL(),
                        dbname = database,
                        host = "127.0.0.1",
                        port = "5433",
                        user = db_user,
                        password = db_pass)
  DBI::dbExecute(con, paste0("GRANT ALL ON DATABASE ", database," TO ", grant_username))
  DBI::dbExecute(con, paste0("GRANT ALL ON SCHEMA ", schema," TO ", grant_username))
  DBI::dbExecute(con, paste0("GRANT ALL ON ALL TABLES IN SCHEMA ", schema," TO ", grant_username))
  DBI::dbExecute(con, paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA ", schema," GRANT ALL ON TABLES TO ", grant_username))
  DBI::dbExecute(con, paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA ", schema," GRANT ALL ON SEQUENCES TO ", grant_username))
}
