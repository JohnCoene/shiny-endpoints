library(shiny)

addResourcePath("assets", "assets")

filter_func <- function(data, req) {
  query <- parseQueryString(req$QUERY_STRING)

  print(query)

  json <- jsonlite::toJSON(
    data[[query$column]],
    auto_unbox = TRUE
  )

  httpResponse(
    status = 200L,
    content_type = "application/json",
    content = json
  )
}

ui <- fluidPage(
  tags$head(
    tags$script(
      src = "assets/script.js"
    )
  ),
  tags$button(
    "Get data",
    id = "get",
    class = "btn btn-info"
  ),
  selectInput(
    "column",
    "Column",
    choices = names(cars)
  ),
  div(
    id = "data"
  )
)

server <- function(input, output, session){
  path <- session$registerDataObj(
    "cars",
    cars,
    filter_func
  )

  session$sendCustomMessage(
    "path",
    path
  )
}

shinyApp(ui, server)
