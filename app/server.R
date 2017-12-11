server <- function(input, output, session){
  
  output$plotTrialPath <- renderPlot({
    plot_learning_trial(learn, input$sliderTrial)
  })
  
  output$plotSop <- renderPlot({
    plot_sop_point(sop, input$sliderSop)
  })
}
