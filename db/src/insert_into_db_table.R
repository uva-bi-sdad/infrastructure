get_db_conn <-
  function(db_name = "sdad",
           db_host = "postgis1",
           db_port = "5432",
           db_user = Sys.getenv("db_usr"),
           db_pass = Sys.getenv("db_pwd")) {
    RPostgreSQL::dbConnect(
      drv = RPostgreSQL::PostgreSQL(),
      dbname = db_name,
      host = db_host,
      port = db_port,
      user = db_user,
      password = db_pass
    )
  }

insert_into_db_table <- function(
  file_path,
  schema_name,
  table_name,
  col_names
) {
  dt <- data.table::fread(file_path)
  colnames(dt) <- col_names
  col_cnt <- ncol(dt)
  if (col_cnt == length(col_names)) {
    con <- get_db_conn()
    RPostgreSQL::dbWriteTable(con, c(db_schema_name, db_table_name), dt, row.names=F, append = T)
    DBI::dbDisconnect(con)
    print("OK")
  } else {
    print(paste("WRONG NUMBER OF COLUMNS FOR FILE:", file_path))
  }
}


file_paths <- list.files("/project/biocomplexity/sdad/projects_data/usda/bb/original/Corelogic_June_2020_Files/", pattern = "^x", full.names = T)
col_names <- db_col_names

for (f in file_paths) {
  insert_into_db_table(f, "corelogic_usda", "corelogic_usda_current_tax_2020_06_27", col_names)
}
