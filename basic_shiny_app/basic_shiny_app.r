rm(list=ls())

library(knitr)
library(readr)
library(shiny)
library(shinydashboard)
library(ggplot2)

df <- read.csv("NIFI_OUTPUT.csv")

df_long <- df %>% 
  gather(key = "METRIC", value = "VALUE", -COMM_GROUP)


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


server <- function(input, output) {
  # Filter data based on selections
  output$table <- renderTable({
    req(input$commodity)
    df_long %>% 
      filter(COMM_GROUP == input$commodity)})
  
  output$graph <- renderPlot({
    req(input$metric)
    df_long %>% 
      filter(METRIC == input$metric) %>% 
      #filter(METRIC == "TOT_SALES") %>% 
      ggplot()+
      geom_bar(aes(x = reorder(COMM_GROUP,as.numeric(VALUE)), y = as.numeric(VALUE),
                   fill = (COMM_GROUP == input$commodity))
                   
                   ,stat="identity")+
      coord_flip()+
      theme_classic()}) 
  
}

shinyApp(ui = ui, server = server)

