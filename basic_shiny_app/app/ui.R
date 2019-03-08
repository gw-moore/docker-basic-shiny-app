##Shiny App
ui <- fluidPage( 
  titlePanel("NF Integration 2.0"),
  sidebarLayout(
    
    sidebarPanel(
      selectInput(inputId = "commodity", label = "Choose a commodity", choices = df_long$COMM_GROUP),
      selectInput(inputId = "metric", label = "Choose a metric", choices = df_long$METRIC)
    ),
    mainPanel(tableOutput(outputId = "table"),
              plotOutput(outputId = "graph"))
  )
)