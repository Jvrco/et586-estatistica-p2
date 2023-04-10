library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

# Load dataset
starbucks <- read.csv("Starbucks_stock_history.csv")

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
      # Tab 1 content
      tabItem(
        tabName = "tab1",
        fluidRow(
          box(
            title = "Inputs",
            status = "primary",
            solidHeader = TRUE,
            width = 3,
            selectInput("classe", "Classe a ser analisada:", choices = c("Open","High","Low","Close","Volume","Dividends","Stock Splits")),
            dateRangeInput("datas", "Intervalo de datas:", start = "2000-01-01", end = "2017-12-31")
          ),
          box(
            title = "Resultados",
            status = "success",
            solidHeader = TRUE,
            width = 9,
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
            width = 3,
            selectInput("classe1", "Primeira classe:", choices = c("Open","High","Low","Close","Volume","Dividends","Stock Splits")),
            selectInput("classe2", "Segunda classe:", choices = c("Open","High","Low","Close","Volume","Dividends","Stock Splits")),
            dateRangeInput("datas2", "Intervalo de datas:", start = "2000-01-01", end = "2017-12-31")
          ),
          box(
            title = "Resultados",
            status = "success",
            solidHeader = TRUE,
            width = 9,
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

# Define server
server <- function(input, output) {
  
  # Function for filtering data based on inputs
  dados_filtrados <- reactive({
    starbucks %>%
      filter(Date >= input$datas[1] & Date <= input$datas[2])
  })
  
  # Tab 1 - Análise de uma classe
  output$tabela1 <- renderTable({
    dados <- dados_filtrados()
    resumo <- dados %>% 
      summarise(Moda = mode(!!sym(input$classe)),
                Média = mean(!!sym(input$classe)),
                Mediana = median(!!sym(input$classe)),
                DesvioPadrão = sd(!!sym(input$classe)),
                Máximo = max(!!sym(input$classe)),
                Mínimo = min(!!sym(input$classe)))
    resumo <- resumo %>%
      mutate(Classe = input$classe)
    resumo <- resumo %>%
      select(Classe, Moda, Média, Mediana, DesvioPadrão, Máximo, Mínimo)
    resumo
  })
  
  output$grafico_linha <- renderPlot({
    dados <- dados_filtrados()
    ggplot(dados, aes(x = Date, y = !!sym(input$classe))) +
      geom_line() +
      labs(x = "Data", y = input$classe) +
      ggtitle(paste("Série temporal de", input$classe))
  })
  
  output$histograma <- renderPlot({
    dados <- dados_filtrados()
    ggplot(dados, aes(x = !!sym(input$classe))) +
      geom_histogram() +
      labs(x = input$classe, y = "Frequência") +
      ggtitle(paste("Histograma de", input$classe))
  })
  
  output$boxplot <- renderPlot({
    dados <- dados_filtrados()
    ggplot(dados, aes(y = !!sym(input$classe))) +
      geom_boxplot() +
      labs(y = input$classe) +
      ggtitle(paste("Boxplot de", input$classe))
  })
  
  # Tab 2 - Análise de duas classes
  output$tabela2 <- renderTable({
    dados <- dados_filtrados()
    dados <- dados %>%
      select(Date, !!sym(input$classe1), !!sym(input$classe2))
    cor <- cor(dados[,2:3])
    tabela <- data.frame(Classe1 = input$classe1, Classe2 = input$classe2, Correlação = cor)
    tabela
  })
  
  output$grafico_linha2 <- renderPlot({
    dados <- dados_filtrados()
    ggplot(dados, aes(x = Date)) +
      geom_line(aes(y = !!sym(input$classe1), color = "Classe 1")) +
      geom_line(aes(y = !!sym(input$classe2), color = "Classe 2")) +
      labs(x = "Data", y = "Valor") +
      ggtitle(paste("Séries temporais de", input$classe1, "e", input$classe2)) +
      scale_color_manual(values = c("Classe 1" = "red", "Classe 2" = "blue"))
  })
  
}


shinyApp(ui, server)