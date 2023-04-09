library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    tabItems(
      tabItem(tabName = "tab1"),
      tabItem(tabName = "tab2")
    )
  )
)

server <- function(input, output) {}

shinyApp(ui, server)
