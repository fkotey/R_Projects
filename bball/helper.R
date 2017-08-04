#############################################################################
##
## Name: KOTEY FELIX NEEQUAYE
## Project: Website for Baseball Effectiveness Measurement
## Date: October 29, 2014
##
#############################################################################


if ("pacman" %in% rownames(installed.packages()) == FALSE)
{
  install.packages("pacman")
  library('pacman', character.only = T)
}else{
  library('pacman', character.only = T)
}

p_load(shinydashboard, shiny, DT, RSQLite, ggvis, shinythemes)

#############################################################################
#############################################################################

# path to sqlite database
# database holding player information
database <- "data/Bball.sqlite"
# table for player information
table <- "BballaPlayerInfo"

# Define the fields we want to save from the form
fields <- c("PlayerName", "Team", "BallFaced",
            "Hits", "InningsPlayed", "PlayDate")

#############################################################################
## function to save data to database
#############################################################################

saveData <- function(bdata)
{
  # Connect to the database
  db <- dbConnect(drv = RSQLite::SQLite(),dbname = file.path(database))
  # Construct the update query by looping over the data fields
  dbrow <- nrow(loadData()) + 1
  query <- sprintf(
    "INSERT INTO %s (%s) VALUES ('%s')",
    table,
    paste(c("PlayerID", names(bdata)), collapse = ", "),
    paste(c(dbrow, bdata), collapse = "', '")
  )
  # Submit the update query and disconnect
  dbGetQuery(db, query)
  dbDisconnect(db)
}

#############################################################################
## function to load data from database
#############################################################################

loadData <- function()
{
  # Connect to the database
  db <- dbConnect(drv = RSQLite::SQLite(),dbname = file.path(database))
  # Construct the fetching query
  query <- sprintf("SELECT * FROM %s", table)
  # Submit the fetch query and disconnect
  data <- dbGetQuery(db, query)
  dbDisconnect(db)
  data
}