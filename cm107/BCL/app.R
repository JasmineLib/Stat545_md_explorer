#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
#str(bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE))

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      radioButtons("typeInput","Select your alcoholic beverage type.",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"), 
                   selected = "WINE")
    ),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("bcl_data")
    )
  ),
  
  br(),
  br(),
  br(),
  br(),
  
  
  br(),
  br(),
  "This is some text",
  br(),
  br(),
  "\n this is more textttt",
  tags$h1("level 1 header"),
  HTML("<h1>Level 1 header part 3</h1>"),
  h1(em("header part two")),
  a(href="https://google.ca","link to google"),
  br(),
  br(),
  tags$code("This text will be displayed as computer code."),
  br(),
  HTML("<code>This text will also be displayed as computer code.</code>"),
  tags$img(src = "www.rstudio.com", width = "100px", height = "100px")
  
)


# Define server logic required to draw a histogram
#input is c(15,30) for price input. so we subset in the filter function is [2] = 30, [1]= 15
server <- function(input, output) {
  observe(print(input$priceInput))
  bcl_filtered <-  reactive({
    bcl %>% 
      filter(Price < input$priceInput[2], 
             Price > input$priceInput[1],
             Type == input$typeInput)
  })
  
  output$price_hist <- renderPlot({
    bcl_filtered() %>%
      ggplot(aes(Price)) +
      geom_histogram()
  })
  
  output$bcl_data <- renderTable({
    bcl_filtered()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

