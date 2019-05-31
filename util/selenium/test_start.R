library(RSelenium)
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4444L,
  browserName = "chrome"
)
remDr$open()
remDr$getStatus()
