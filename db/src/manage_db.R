

# CREATE DB ACCOUNTS ----

# SDAD Staff
db_users_sdad <- data.table::fread("db/src/users_sdad.csv")[, uid]
# EXTERNAL Staff
db_users_external <- data.table::fread("db/src/users_external.csv")[, uid]
# DSPG Students
db_users_dspg2019 <- data.table::fread("db/src/users_dspg2019.csv")[, uid]
# All Users
db_users <- c(db_users_sdad, db_users_external, db_users_dspg2019)

# Create database user accounts
source("db/src/db_create_user.R")
for (dbu in db_users) {
  create_db_user(
    dbu,
    db_host = "postgis_2")
}

# Create database user accounts on Rivanna
source("db/src/db_create_user.R")
for (dbu in db_users_sdad) {
  create_db_user_rivanna(
    dbu
  )
}

# GRANT DB PERMISSIONS ----
# Grant permissions to all users
source("db/src/db_grant_permissions.R")
# Grant permission to single user
grant_db_permissions(
  grant_username = "dtn2ep",
  grant_database = "gis",
  schema = "census_tl",
  db_host = "postgis_1"
)

for (dbu in db_users_sdad) {
  grant_db_permissions(
    grant_username = dbu,
    grant_database = "sdad",
    schema = "corelogic_usda",
    db_host = "postgis1"
  )
}



# BACKUP DB ----

