
library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Simulating Sample Distribution for OLS Estimators"),
  sidebarPanel(
    h5('Introduction'),    
      
    p("This is a simple application to demonstrate the behavior of the ordinary least squares (OLS) estimator, under different samples.
      The user can choose the regression errors standard deviation, regression linear coefficient and regression angular coefficient. Besides, 
      it is possible to select the number of observations in each sample and the number of simulations. The higher the number of simulations or the sample size,
      the more intensive the computations will be."),
    
    h5('Regression Parameters'),
    
    p('In this part of the layout, the user can select the parameters for the estimated regression. Choose the standard deviation for regression residues,
      and the linear and angular coefficients.'),
    
    numericInput('desv_pad_errors', "Errors standard deviation", 5, min =0.05, max = 100, step = 0.05),    
    numericInput('beta0', "Linear coefficient", 5, min=-100, max=100, step = 1 ),
    numericInput('beta1', "Angular coefficient", 0.5, min=-20, max=20, step = 0.5),
    
    h5('Simulation Parameters'),
    
    p('Now, the user can select the number of observations for each sample and the number of simulated samples. 
      The higher the number of simulations or the sample size,
      the more intensive the computations will be.'),
    
    numericInput('nobs', "Number of observations per sample", 50, min=10, max=1000, step = 10),
    numericInput('nsimulations', "Number of simulations", 100, min=10, max=1000, step = 10),
    
    h5('Simulate again'),
    
    p('Press the button below to re-run the application.'),
    
    actionButton("goButton", "Simulate!")
  ),
  
  mainPanel(
    h5('Visualizing One of the Samples'),
    
    p('The graphs below present some basic indicators for one of the simulated sample. We present the scatter-plot to analyze the relationship 
      between simulated x and y. We also present the histogram for the simulated regression residues. Note that, if you increase the errors standard
      deviation or decrease the linear coefficient, identifying the linear relationship between x and y becomes more difficult.'),
    
    plotOutput('scatter_plot'),
    
    #     h4('Mean for OLS Estimates'),
    #     p("Mean for linear coefficient estimates"),
    #     textOutput("text1"),
    #     
    #     p("Mean for angular coefficient estimates"),
    #     textOutput("text2"),
    
    h5('Histograms for Sample Estimates'),
    
    p('This application generates the specified number of samples, and for each sample we estimate the linear and the angular coefficients. 
      We then save the list of estimates and analyze their distribution. The two histograms below present an overall picture of the regression 
      estimates accross all simulated samples. Note that, when we increase the errors standard deviation, the dispersion around the true parameter
      values (vertical red lines) increase. That means that the OLS estimates become less precise. On the other hand, when we increase the sample 
      size (number of observations in each simulated sample), the dispersion around the true values decrease, as the estimates become more precise.'),
    
    plotOutput('hist1')
  )
))
