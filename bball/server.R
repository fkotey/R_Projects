server = function(input, output, session) {

  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    bdata <- sapply(fields, function(x) input[[x]])
    bdata
  })

  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })

  # Show the previous responses
  # (update with current response when Submit is clicked)
  output$responses <- DT::renderDataTable({
    input$submit
    loadData()
  })

  observeEvent(input$file1, {
    inFile <- input$file1

    if (is.null(inFile))
      return(NULL)

    bdata <- read.csv(inFile$datapath, header=input$header,
                      sep=input$sep, quote=input$quote)

    bnrow <- nrow(loadData()) + 1

    bdata$PlayerID <- bnrow:(bnrow+nrow(bdata)-1)

    db <- dbConnect(drv=RSQLite::SQLite(),
                    dbname=file.path(database))
    dbWriteTable(db, "BballaPlayerInfo", bdata, append=TRUE)
    dbDisconnect(db)
    loadData()
  })

  # A reactive subset of baseball data
  Bball <- reactive({
    bdata <- loadData()
    bdata
  })

  Bball %>%
    ggvis(~ BallFaced, ~Hits, key:= ~PlayerName, fillOpacity = ~Hits,
          shape := "circle",
          fill := "red",
          size := 100 ) %>%
    layer_points() %>%
    add_axis("y", title = "Number of Hits") %>%
    add_axis("x", title = "Average Battling") %>%
    add_axis("x", orient = "top", ticks = 0,
             title = "Scatter Plot of Number of balls vs number of hits for players ",
             properties = axis_props(
               axis = list(stroke = "white"),
               labels = list(fontSize = 0))) %>%
    add_tooltip(function(data) paste0("Name: ", data$PlayerName, "<br>", "Balls Hit: ",as.character(data$Hits),
                                      "<br>", "Balls Faced: ", as.character(data$BallFaced)), "hover") %>%
    set_options(width = "auto", height = "auto") %>%
    bind_shiny("plot")
}