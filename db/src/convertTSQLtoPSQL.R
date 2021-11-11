library(magrittr)
library(dataplumbr)

sql_file <- "Create_Table_ASMT.sql"
new_schema <- "blackknight"
new_table <- "asmt_20210621"

sql <- readr::read_lines(paste0("../../Desktop/blkknight/ReferenceScript/", sql_file))

sql_fix <- stringr::str_remove_all(sql, "[\\[\\]]") %>%
  stringr::str_replace("Create[:space:]TABLE[:space:].*?\\(", ",") %>%
  stringr::str_remove("TABLE[:space:]dbo.*?[:space:]") %>%
  stringr::str_remove("^.*ON PRIMARY.*$")

sql_fix_str <- paste(sql_fix, collapse = "")

sql_parsed <- stringr::str_match_all(sql_fix_str, ",(.*?)[:space:]([a-z]+.*?)[:space:](.*?[Nn][Uu][Ll][Ll])")
col_names <- sql_parsed[[1]][,2]
col_types <- sql_parsed[[1]][,3]
col_nulls <- sql_parsed[[1]][,4]

#col_names_fix_acronyms <- fix_acronyms(col_names)

col_names_fixed <- name.standard_col_names(col_names, fix_acronyms = T, fix_camel = T) 

col_types[col_types == "bit"] <- "boolean"
col_types[col_types == "int"] <- "integer"

new_col_defs <- paste(col_names_fixed, col_types, col_nulls, "\n", collapse = ", ")
new_ddl <- paste0("CREATE TABLE ", new_schema, ".", new_table," (", new_col_defs, ")")

cat(new_ddl)
readr::write_lines(new_ddl, paste0("../../Desktop/blkknight/ReferenceScript/", strsplit(sql_file, "\\.")[[1]][1],"_psql.sql"))


