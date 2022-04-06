library(shiny)
library(dplyr)

source("drawing_function.R")

data <- data.frame(project_name = c("Corazón", "Umaña"), 
                   organization_name = c("Aliñán enterprises", "Común Añadidos SA"),
                   variable1 = c(20,30),
                   variable2 = c(10, 15)
                   )

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  

    # Application title
    titlePanel("Testing display of spécial characters"),

    # Sidebar to select project
    sidebarLayout(
      sidebarPanel(
        selectInput("project", label = "Seleccioné un proyecto",
                    choices = unique(data$project_name)
                    )
      ),
    
        # Show text output and a plot
        mainPanel(
          tags$h4(textOutput("projectName", inline = TRUE)),
          tags$h5(textOutput("organizations", inline = TRUE)),
          plotOutput("metrics")
        )
    )
)

# Define server logic
server <- function(input, output) {
  
  data_reactive <- reactive({
    data %>% filter(project_name == input$project)
  })
  
  # print project name
  output$projectName <- renderText ({
    paste0(input$project)
  })
  
  # print organization
  output$organizations <- renderText ({
    paste0(data_reactive()$organization_name)
  })
  
  # draw indicator table
  output$metrics <- renderPlot({
    makeInfoPanel(data_reactive())
  })
  
  

    }


# Run the application 
shinyApp(ui = ui, server = server)
