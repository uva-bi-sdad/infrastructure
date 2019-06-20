# DB Functions
source("db/src/db_create_user.R")
source("db/src/db_grant_permissions.R")

# CREATE DB ACCOUNTS ----

# SDAD Staff
db_users_sdad <- data.table::fread("db/src/users_sdad.csv")[, uid]
# DSPG Students
db_users_dspg2019 <- data.table::fread("db/src/users_dspg2019.csv")[, uid]
# All Users
db_users <- c(db_users_dspg2019, db_users_sdad)

# Create users
for (dbu in db_users) {
  create_db_user(dbu)
}


# GRANT DB PERMISSIONS ----

# Grant all permissions on grant_database to grant_user

for (dbu in db_users) {
  grant_db_permissions(grant_username = dbu, grant_database = "gis")
}



# BACKUP DB ----

