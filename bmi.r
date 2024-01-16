# Install required packages if not already installed
# install.packages(c("shiny", "shinydashboard"))

library(shiny)
library(shinydashboard)

# BMI Calculation function
calculate_bmi <- function(weight, height) {
  bmi <- weight / ((height/100)^2)
  return(bmi)
}

# BMI Category function
get_bmi_category <- function(bmi) {
  if (bmi < 18.5) {
    return("Underweight")
  } else if (bmi < 24.9) {
    return("Normal Weight")
  } else if (bmi < 29.9) {
    return("Overweight")
  } else {
    return("Obese")
  }
}

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "BMI Calculator"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("BMI Calculator", tabName = "bmi_calculator")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "bmi_calculator",
        h2("BMI Calculator"),
        fluidRow(
          box(
            title = "Enter Details",
            width = 4,
            textInput("weight", "Weight (kg):", value = ""),
            textInput("height", "Height (cm):", value = ""),
            actionButton("calculate", "Calculate BMI")
          ),
          box(
            title = "Result",
            width = 4,
            verbatimTextOutput("result")
          ),
          box(
            title = "BMI Category",
            width = 4,
            verbatimTextOutput("category")
          )
        ),
        fluidRow(
          box(
            title = "BMI Graph",
            width = 12,
            plotOutput("bmi_plot")
          )
        )
      )
    )
  )
)

# Define server
server <- function(input, output) {
  
  # Reactive function for BMI calculation
  bmi_result <- eventReactive(input$calculate, {
    weight <- as.numeric(input$weight)
    height <- as.numeric(input$height)
    
    if (is.na(weight) || is.na(height) || weight <= 0 || height <= 0) {
      return(NULL)
    }
    
    bmi <- calculate_bmi(weight, height)
    category <- get_bmi_category(bmi)
    
    return(list(bmi = bmi, category = category))
  })
  
  # Output result
  output$result <- renderText({
    result <- bmi_result()
    if (is.null(result)) {
      return("Invalid input. Please enter valid weight and height.")
    }
    return(paste("BMI:", round(result$bmi, 2)))
  })
  
  # Output BMI category
  output$category <- renderText({
    result <- bmi_result()
    if (is.null(result)) {
      return("")
    }
    return(paste("Category:", result$category))
  })
  
  # Output BMI graph
  output$bmi_plot <- renderPlot({
    result <- bmi_result()
    if (!is.null(result)) {
      category <- result$category
      bmi <- result$bmi
      plot(1, type = "n", xlab = "", ylab = "", main = paste("BMI Category: ", category))
      text(1, 1, paste("BMI:", round(bmi, 2)), cex = 1.5)
    }
  })
}

# Run the application
shinyApp(ui, server)


# to install package commands are as below 
# install.packages("shinydashboard")