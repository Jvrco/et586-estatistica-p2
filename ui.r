# Define UI
ui <- dashboardPage(
  skin = "green",
  dashboardHeader(
    title = "Análise da ação da Starbucks",
    titleWidth = 300
  ),
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
            status = "primary",
            background = "green",
            width = 12,
            tags$b("Análise de características individuais da ação da Starbucks (SBUX), listada no índice Nasdaq, entre 1992 e 2021"),
            p("Legenda das séries temporais:"),
            tags$ul(
              tags$li("Open: Preço da ação no momento da abertura do pregão"),
              tags$li("High: Preço mais alto alcançado pela ação no pregão"),
              tags$li("Low: Preço mais baixo alcançado pela ação no pregão"),
              tags$li("Close: Preço da ação no momento do fechamento do pregão"),
              tags$li("Volume: Quantidade de movimentações (compras e vendas de ações)"),
              tags$li("Dividends: Participação no lucro da empresa (lucro destinado à divisão entre acionistas dividido pelo número de ações)"),
            )
          )
        ),
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
        ),
        fluidRow(
          box(
            status = "primary",
            width = 12,
            tags$b("Participantes do grupo:"),
            tags$ul(
              tags$li("João Luís Gomes Agra (jlga)"),
              tags$li("João Victor Ribeiro Costa de Omena (jvrco)"),
              tags$li("Ricardo Bizerra de Lima Filho (rblf)")
            )
          )
        )
      ),

      # Aba 2 - Análise de Duas Classes
      tabItem(
        tabName = "tab2",
        fluidRow(
          box(
            status = "primary",
            background = "green",
            width = 12,
            tags$b("Análise de duplas de características da ação da Starbucks (SBUX), listada no índice Nasdaq, entre 1992 e 2021"),
            p("Legenda das séries temporais:"),
            tags$ul(
              tags$li("Open: Preço da ação no momento da abertura do pregão"),
              tags$li("High: Preço mais alto alcançado pela ação no pregão"),
              tags$li("Low: Preço mais baixo alcançado pela ação no pregão"),
              tags$li("Close: Preço da ação no momento do fechamento do pregão"),
              tags$li("Volume: Quantidade de movimentações (compras e vendas de ações)"),
              tags$li("Dividends: Participação no lucro da empresa (lucro destinado à divisão entre acionistas dividido pelo número de ações)"),
            )
          )
        ),
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
        ),
        fluidRow(
          box(
            status = "primary",
            width = 12,
            tags$b("Participantes do grupo:"),
            tags$ul(
              tags$li("João Luís Gomes Agra (jlga)"),
              tags$li("João Victor Ribeiro Costa de Omena (jvrco)"),
              tags$li("Ricardo Bizerra de Lima Filho (rblf)")
            )
          )
        )
      )
    )
  )
)