killDbConnections <- function () {
  
  all_cons <- DBI::dbListConnections(RPostgreSQL::PostgreSQL())
  
  print(all_cons)
  
  for(con in all_cons)
    +  DBI::dbDisconnect(con)
  
  print(paste(length(all_cons), " connections killed."))
  
}