grant_db_permissions <- function(grant_database, grant_username, schema = "public", db_user = Sys.getenv("db_userid"), db_pass = Sys.getenv("db_pwd"), db_host = "postgis_1", db_port = "5432") {
  con <- DBI::dbConnect(drv = RPostgreSQL::PostgreSQL(),
                        dbname = grant_database,
                        host = db_host,
                        port = db_port,
                        user = db_user,
                        password = db_pass)
  
  DBI::dbExecute(con, paste0("GRANT ALL ON DATABASE ", database," TO ", grant_username))
  print(paste0("GRANT ALL ON DATABASE ", database," TO ", grant_username))
  
  DBI::dbExecute(con, paste0("GRANT ALL ON SCHEMA ", schema," TO ", grant_username))
  print(paste0("GRANT ALL ON SCHEMA ", schema," TO ", grant_username))
  
  DBI::dbExecute(con, paste0("GRANT ALL ON ALL TABLES IN SCHEMA ", schema," TO ", grant_username))
  print(paste0("GRANT ALL ON ALL TABLES IN SCHEMA ", schema," TO ", grant_username))
  
  DBI::dbExecute(con, paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA ", schema," GRANT ALL ON TABLES TO ", grant_username))
  print(paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA ", schema," GRANT ALL ON TABLES TO ", grant_username))
  
  DBI::dbExecute(con, paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA ", schema," GRANT ALL ON SEQUENCES TO ", grant_username))
  print(paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA ", schema," GRANT ALL ON SEQUENCES TO ", grant_username))
}
