source("db/src/db_connection.R")
projects <- jsonlite::read_json("db/data/projects.json")

con <- get_db_conn()

for (i in 1:length(projects)) {
  # DROP (IF EXISTS) AND CREATE DB GROUP
  group <- projects[[i]]$project
  drop_group_sql <- paste0("DROP GROUP IF EXISTS ", group)
  DBI::dbGetQuery(con, drop_group_sql)
  create_group_sql <- paste0("CREATE GROUP ", group)
  create_group_result <- DBI::dbGetQuery(con, create_group_sql)
  if (is.null(create_group_result) == TRUE) {
    print("PROBLEM WITH CREATE GROUP")
  } else {
    print(paste0("Creation of group ", group, " successful!"))
  }
  
  # ASSIGN USERS TO DB GROUP
  for (j in 1:length(projects[[i]]$members)) {
    user <- projects[[i]]$members[[j]]
    # CREATE USER IF NOT EXISTS
    user_exists_sql <- paste0("SELECT 1 FROM pg_roles WHERE rolname='", user, "'")
    user_exists <- DBI::dbGetQuery(con, user_exists_sql)
    if (nrow(user_exists) > 0) {
      print(paste0("User ", user, " already exists."))
    } else {
      create_user_sql <- paste0("CREATE USER ", user," WITH PASSWORD '", user, "'")
      create_user_result <- DBI::dbGetQuery(con, create_user_sql)
      if (is.null(create_group_result) == TRUE) {
        print("PROBLEM WITH CREATE USER")
      } else {
        print(paste0("Creation of user ", user, " successful!"))
      }
    }
    # ASSIGN USER TO GROUP
    assign_group_sql <- paste0("GRANT ", group, " TO ", user)
    assign_group_result <- DBI::dbGetQuery(con, assign_group_sql)
    if (is.null(assign_group_result) == TRUE) {
      print("PROBLEM WITH ASSIGN USER")
    } else {
      print(paste0("User ", user, " assigned to group ", group))
    }
  }
}

DBI::dbDisconnect(con)
