# create rtsudio menus
users <- data.table::fread("users/users.csv")[!is.na(rstudio_port)]

l <- vector("list", nrow(users))
for (i in 1:nrow(users)) {
  u <- paste0(
    "|[[", 
    users[i]$name, 
    ">>http://sdad.policy-analytics.net:", 
    users[i]$rstudio_port, 
    "||rel=\"noopener noreferrer\" target=\"_blank\"]]"
  )
  l[i] <- u
}

writeLines(unlist(l), "users/rstudio_users.txt")