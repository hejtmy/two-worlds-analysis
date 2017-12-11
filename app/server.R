server <- function(input, output, session){
  output$plotTrialPath <- renderPlot({
    plot_learning_trial(learn, input$sliderTrial)
  })
  
  output$plotSop <- renderPlot({
    plot_sop_point(sop, input$sliderSop)
  })
  
  restimoteLog <- reactive({
    dt_log <- get_position_trial(restimoteObj, input$sliderRestimoteTrial)
    restimote_nrow <<- nrow(dt_log)
    updateSliderInput(session, "sliderRestimoteTrialTime", value = restimote_nrow, max = restimote_nrow)
    return(dt_log)
  })
  
  subRestimoteLog <- reactive({
    dt <- restimoteLog()
    return(dt[1:input$sliderRestimoteTrialTime, ])
  })
  
  output$plotRestimoteTrial <- renderPlot({
    plt <- restimoter::create_plot(restimoteObj)
    plt <- plot_add_restimote_path(plt, df_pos = subRestimoteLog())
    plt + theme_bw()
  })
}
