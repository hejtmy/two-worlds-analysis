ui <- fluidPage(
  sliderInput(inputId = "sliderTrial", label = "Select trial to plot", 
              value = 1, min = 1, step = 1, max = n_walk_trials),
  plotOutput(outputId = "plotTrialPath"),
  sliderInput(inputId = "sliderSop", label = "Slide to select pointing", 
              value = 1, min = 1, max = n_sop_trials, step = 1),
  plotOutput(outputId = "plotSop"),
  sliderInput(inputId = "sliderRestimoteTrial", label = "Slide to select restimote trial", 
              value = 1, min = 1, max = n_restimote_trials, step = 1),
  sliderInput(inputId = "sliderRestimoteTrialTime", label = "Slide to select restimote trial time", 
              value = 2, min = 2, max = restimote_nrow, step = 1,
              animate = animationOptions(interval = 100, loop = FALSE)),
  plotOutput(outputId = "plotRestimoteTrial"),
  sliderInput(inputId = "sliderRestimotePoint", label = "Slide to select restimote pointing", 
              value = 1, min = 1, max = n_restimote_sop, step = 1),
  plotOutput(outputId = "plotRestimoteSop")
)