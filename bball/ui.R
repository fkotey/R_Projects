ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Player Effectiveness"),
  dashboardSidebar(
    sidebarMenu(
      fileInput('file1', 'Upload Large Files',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      p("Please make sure the format"),
      p("of the data matches"),
      p("the displayed one"),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
    )
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(
        width = 6,
        title = "Current Data",
        DT::dataTableOutput("responses", width = 280), tags$hr()
        
      ),
      
      box(
        width = 2,
        title = "Data Capturing",
        textInput("PlayerName", "Name", "FirstName LastName"),
        textInput("Team", "Team", ""),
        textInput("BallFaced", "Number of Ball Faced", ""),
        textInput("Hits", "Number of Ball Hits", ""),
        textInput("InningsPlayed", "Innings Played", ""),
        textInput("PlayDate", "Date of Play", "14/01/2004"),
        actionButton("submit", "Submit")
      ),
      
      box(
        width = 4,
        title = "Effective Measurement",
        ggvisOutput("plot")
      )
    )
  )
)
