library(data.table)
library(magrittr)
library(RPostgreSQL)
source("db/src/db_connection.R")

deed_cols <- fread("/project/biocomplexity/sdad/projects-active/usda/bb/original/corelogic/corelogic_usda/deed/corelogic-USDA_Deed_cols.txt") %>% 
  colnames() %>% 
  make.names() %>% 
  gsub("\\.", "_", .) %>% 
  tolower() %>% paste0("\"", ., "\"", " varchar")

for (y in c("2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015")) {
  deed_cols_create <- paste0("CREATE TABLE usda_deed_", y," (", paste(deed_cols, collapse = ","),")")
  con <- get_db_conn()
  dbSendQuery(con, deed_cols_create)
  DBI::dbDisconnect(con)
}

"\copy usda_deed_2015 from /project/biocomplexity/sdad/projects-active/usda/bb/original/corelogic/corelogic_usda/deed/corelogic-USDA_Deed_2015.csv WITH (FORMAT 'csv', DELIMITER E'\|', QUOTE E'\"', HEADER);"


tax_cols <- fread("/project/biocomplexity/sdad/projects-active/usda/bb/original/corelogic/corelogic_usda/tax/TaxHistory.Tax_History_cols.txt") %>% 
  colnames() %>% 
  make.names() %>% 
  gsub("\\.", "_", .) %>% 
  tolower() %>% paste0("\"", ., "\"", " varchar")

for (y in c("08","09","10")) {
  deed_cols_create <- paste0("CREATE TABLE usda_tax_history_", y," (", paste(tax_cols, collapse = ","),")")
  con <- get_db_conn()
  dbSendQuery(con, deed_cols_create)
  DBI::dbDisconnect(con)
}


state8_deed_cols <- fread("/project/biocomplexity/sdad/projects-active/usda/bb/original/corelogic/8state/8State_Deed_Cols.txt", colClasses = "character") %>% 
  colnames() %>% 
  gsub("\\`", "", .) %>%
  make.names() %>% 
  gsub("\\.", "_", .) %>% 
  tolower() %>% paste0("\"", ., "\"", " varchar")

state8_deed_cols_create <- paste0("CREATE TABLE state8_deed (", paste(state8_deed_cols, collapse = ","),")")
con <- get_db_conn()
dbSendQuery(con, state8_deed_cols_create)
DBI::dbDisconnect(con)


state8_tax_cols <- fread("/project/biocomplexity/sdad/projects-active/usda/bb/original/corelogic/8state/8State_Tax_Cols.txt", colClasses = "character") %>% 
  colnames() %>% 
  gsub("\\`", "", .) %>%
  make.names() %>% 
  gsub("\\.", "_", .) %>% 
  tolower() %>% paste0("\"", ., "\"", " varchar")

state8_tax_cols_create <- paste0("CREATE TABLE state8_tax (", paste(state8_tax_cols, collapse = ","),")")
con <- get_db_conn()
dbSendQuery(con, state8_tax_cols_create)
DBI::dbDisconnect(con)


"\copy state8_deed from /project/biocomplexity/sdad/projects-active/usda/bb/original/corelogic/8state/8State_Deed.txt WITH (FORMAT 'csv', DELIMITER E'\|', QUOTE '`', HEADER);"
"\copy state8_tax from /project/biocomplexity/sdad/projects-active/usda/bb/original/corelogic/8state/8State_Tax_10.txt WITH (FORMAT 'csv', DELIMITER E'\|', QUOTE '`', HEADER);"


"CREATE INDEX corelogic_usda_2006_fips_trgm_idx ON corelogic_usda.usda_deed_2006 USING GIST (fips gist_trgm_ops);"
