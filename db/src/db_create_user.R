create_db_user <- function(new_username, db_user = Sys.getenv("db_userid"), db_pass = Sys.getenv("db_pwd"), db_host = "postgis_1", db_port = "5432", db_user_database = Sys.getenv("db_userid")) {
  
  con <- DBI::dbConnect(drv = RPostgreSQL::PostgreSQL(),
                        dbname = db_user_database,
                        host = db_host,
                        port = db_port,
                        user = db_user,
                        password = db_pass)

  u <- DBI::dbGetQuery(con, paste0("SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = '", new_username,"'"))
  if (nrow(u) == 0) {
    e <- DBI::dbExecute(con, paste0("CREATE USER ", new_username," WITH PASSWORD '", new_username, "'"))
    if (e == 0) print(paste("Created User", new_username))
  } else {
    print(paste("User", new_username, "Already Exists"))
  }

  d <- DBI::dbGetQuery(con, paste0("SELECT 1 FROM pg_database WHERE datname = '", new_username,"'"))
  if (nrow(d) == 0) {
    e <- DBI::dbExecute(con, paste0("CREATE DATABASE ", new_username))
    if (e == 0) print(paste("Created Database", new_username))
  } else {
    print(paste("Database", new_username, "Already Exists"))
  }

  DBI::dbExecute(con, paste0("GRANT ALL ON DATABASE ", new_username," TO ", new_username))
  print(paste0("GRANT ALL ON DATABASE ", new_username," TO ", new_username))

  con2 <- DBI::dbConnect(drv = RPostgreSQL::PostgreSQL(),
                         dbname = new_username,
                         host = db_host,
                         port = db_port,
                         user = db_user,
                         password = db_pass)

  DBI::dbExecute(con2, paste0("GRANT ALL ON ALL TABLES IN SCHEMA public TO ", new_username))
  print(paste0("GRANT ALL ON ALL TABLES IN SCHEMA public TO ", new_username))

  DBI::dbExecute(con2, paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO ", new_username))
  print(paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO ", new_username))

  DBI::dbExecute(con2, paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO ", new_username))
  print(paste0("ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO ", new_username))

  DBI::dbDisconnect(con)
  DBI::dbDisconnect(con2)
}


create_db_user_rivanna <- function(new_username, db_user = Sys.getenv("db_userid"), db_pass = Sys.getenv("db_pwd"), db_host = "postgis1", db_port = "5432", db_name = "sdad") {
  con <- DBI::dbConnect(drv = RPostgreSQL::PostgreSQL(),
                        dbname = db_name,
                        host = db_host,
                        port = db_port,
                        user = db_user,
                        password = db_pass)
  
  u <- DBI::dbGetQuery(con, paste0("SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = '", new_username,"'"))
  if (nrow(u) == 0) {
    e <- DBI::dbExecute(con, paste0("CREATE USER ", new_username," WITH PASSWORD '", new_username, "'"))
    if (e == 0) print(paste("Created User", new_username))
  } else {
    print(paste("User", new_username, "Already Exists"))
  }
  
  DBI::dbDisconnect(con)
}


