ui <- fluidPage(
  sliderInput(inputId = "sliderTrial", label = "Select trial to plot", 
              value = 1, min = 1, step = 1, max = n_trials),
  plotOutput(outputId = "plotTrialPath"),
  sliderInput(inputId = "sliderSop", label = "Slide to select pointing", 
              value = 2, min = 2, max = log_nrow, 
              animate = animationOptions(interval = 250, loop = FALSE)),
  plotOutput(outputId = "plotSop")
)