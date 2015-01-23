# Load libraries
library(shiny)

shinyUI(
    pageWithSidebar(
        headerPanel("Regression Explorer"),

        # Select inputs
        sidebarPanel(
            
            h4("Upload a file or use the default dataset 'Ozone':"),  
              
            # User enters name of dat.frame here.
            fileInput(inputId = "uploadFile",
                        label   = "Upload a data file (csv format)"),
            
            # Select menu for independent variable, available once
            # the user has selected a valid data.frame
            uiOutput(outputId = "yVarSelector"),
            # Checkbox group for independent variables, available once
            # the user has selected a valid data.frame, and includes
            # all variables in the data.frame EXCEPT the dependent variable.
            uiOutput(outputId = "xVarSelector"),br(),
            h4("Regression Explorer App help:"),
            helpText("1. Upload a dataset or use the default ozone dataset.",br(),  
                     "2. Select a variable as the outcome.",br(),
                     "3. Select the regressors among the rest of the variables.",br(),
                     "4. The 'Model Summary' tab shows the summary of the linear model",br(),
                     "5. Select among 6 different graphs in the 'Diagnostic Plots' tab"),
            width = 5
        ),
        
        # Regression output goes here
        mainPanel(
            # Reminder of the model being evaluated.
            p(htmlOutput(outputId = "regHeader")),
            # Include an HTML horizontal line above tab panel.
            tabsetPanel(
                tabPanel("Model Summary",
                    verbatimTextOutput(outputId = "regSummary")
                ),
                tabPanel("Diagnostic Plots",
                    selectInput(
                        inputId = "regPlotType",
                        label   = "Select diagnostic plot",
                        choices = list(
                            "Residuals vs Fitted"   = 1,
                            "Normal Q-Q"            = 2,
                            "Scale-Location"        = 3,
                            "Cook's Distance"       = 4,
                            "Residuals vs Leverage" = 5,
                            "Cook's Dist vs Leverage" = 6)
                    ),
                    plotOutput(outputId = "regPlot"))
                
            ),
            width = 6
        )
        
        
    )
)
