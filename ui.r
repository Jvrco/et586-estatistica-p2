# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Análise de Séries Temporais"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Análise de uma classe", tabName = "tab1", icon = icon("line-chart")),
      menuItem("Análise de duas classes", tabName = "tab2", icon = icon("bar-chart"))
    )
  ),
  dashboardBody(
    tabItems(

      # Aba 1 - Análise de uma classe
      tabItem(
        tabName = "tab1",
        fluidRow(
          box(
            title = "Inputs",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("classe", "Classe a ser analisada:", choices),
            dateRangeInput("datas", "Intervalo de datas:", start = "1992-06-26", end = "2021-10-01")
          )
        ),
        fluidRow(
          box(
            title = "Resultados",
            status = "success",
            solidHeader = TRUE,
            width = 12,
            tableOutput("tabela1"),
            plotOutput("grafico_linha"),
            plotOutput("histograma"),
            plotOutput("boxplot")
          )
        )
      ),

      # Aba 2 - Análise de Duas Classes
      tabItem(
        tabName = "tab2",
        fluidRow(
          box(
            title = "Inputs",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("classe1", "Primeira classe:", choices),
            selectInput("classe2", "Segunda classe:", choices),
            dateRangeInput("datas2", "Intervalo de datas:", start = "1992-06-26", end = "2021-10-01")
          )
        ),
        fluidRow(
          box(
            title = "Resultados",
            status = "success",
            solidHeader = TRUE,
            width = 12,
            tableOutput("tabela2"),
            plotOutput("grafico_linha2"),
            plotOutput("grafico_barra"),
            plotOutput("scatterplot")
          )
        )
      )
    )
  )
)