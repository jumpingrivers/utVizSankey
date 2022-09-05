library("shiny")

sidebar = function() {
  sidebarPanel(
    h2("Alt-click on a node to see the raw data")
  )
}

main_body = function() {
  mainPanel(
    sankeyOutput("my_sankey"),
    tableOutput("node_data")
  )
}

ui = fluidPage(
  titlePanel("Using Sankey charts inside a shiny app"),
  sidebarLayout(
    sidebar(),
    main_body()
  )
)
