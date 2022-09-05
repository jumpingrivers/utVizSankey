data(admissions, package = "utVizSankey")

alt_click_handler = htmlwidgets::JS(r"(
  function(event, data) {
    Shiny.setInputValue("sankey_node_data:utVizSankey.nodeConverter", data.entries);
  }
)")

server = function(input, output, session) {
  steps = reactive({
    c("college", "student_type", "outcome")
  })

  sankey_object = reactive({
    sankey(admissions, steps = steps(), alt_click_handler = alt_click_handler)
  })

  output$my_sankey = renderSankey(
    sankey_object()
  )

  node_data = eventReactive(input$sankey_node_data, {
    input$sankey_node_data
  })

  output$node_data = renderTable({
    node_data()
  })
}
