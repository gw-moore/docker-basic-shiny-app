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