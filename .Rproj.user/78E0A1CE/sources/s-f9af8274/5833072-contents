library(DBI, RPostgreSQL, pool)
library(rio)
library(sdalr)

# Get files to load to db
filelist <- list.files("/home/sdal/projects/limbo/arlco_dpr/DPR/DPR Sports Data/", pattern = "^.*\\.xlsx", full.names = TRUE)

# Get data connection
# pool <- dbPool(
#   drv = RPostgreSQL::PostgreSQL(),
#   dbname = "arlington",
#   host = "localhost",
#   port = 5432,
#   user = "aschroed",
#   password = "12Character$"
# )
con <- con_db('virginia', 'aschroed')

filepath <- "/home/aschroed/2014_fm_divsch_70_207.csv"
load2db(filepath, con, table_prefix = "", table_schema = "education", table_name = "vdoe_fm_divsch_70_207_2014")

# Load functions
load2db <- function(file_path = x, db_con, table_prefix = "orig_", table_schema = "public", table_name = "auto") {
  df <- import(file_path)
  colnames(df) <- fix_column_names(df)
  if (table_name == "auto") {
    table_name <- sub(pattern = "(.*)\\..*$", replacement = "\\1", basename(file_path))
    table_name <- gsub("-", " ", tolower(table_name))
    table_name <- gsub("[(]", " ", tolower(table_name))
    table_name <- gsub("[)]", "", tolower(table_name))
    table_name <- gsub(" +", "_", tolower(table_name))
    table_name <- substr(paste0(table_prefix, table_name), 1, 63)
  }
  print(paste("loading table", table_name))
  dbWriteTable(db_con, c(table_schema, table_name), df, row.names = FALSE)
}

fix_column_names <- function(df) {
  names <- colnames(df)
  names <- make.names(names, unique = TRUE)
  names <- gsub("\\.", "_", names)
  names <- tolower(names)
  print("Fixing column names")
  return(names)
}

# Load file to db tables
table_schema = "dpr"
lapply(filelist, load2db, db_con = pool, table_prefix = "orig_", table_schema = table_schema)

dbGetQuery(pool, paste0("SELECT table_schema, table_name FROM information_schema.tables WHERE table_schema = '", table_schema,"'"))


