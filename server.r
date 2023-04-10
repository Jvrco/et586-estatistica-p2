# Define server
server <- function(input, output) {
  
  # Filtrando dados com base no intervalo de datas
  dados_filtrados1 <- reactive({
    starbucks %>%
      filter(Date >= input$datas[1] & Date <= input$datas[2])
  })

  dados_filtrados2 <- reactive({
    starbucks %>%
      filter(Date >= input$datas2[1] & Date <= input$datas2[2])
  })
  # ABA 1
  
  # Uma tabela, contendo nome da classe, moda, média mediana e desvio padrão da série temporal a ser analisada
  output$tabela1 <- renderTable({
    dados <- dados_filtrados1()
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
  
  # Gráfico em linha da série
  output$grafico_linha <- renderPlot({
    dados <- dados_filtrados1()
    ggplot(dados, aes(x = Date, y = !!sym(input$classe))) +
      geom_line() +
      labs(x = "Data", y = input$classe) +
      ggtitle(paste("Série temporal de", input$classe))
  })
  
  # Histograma da série
  output$histograma <- renderPlot({
    dados <- dados_filtrados1()
    ggplot(dados, aes(x = !!sym(input$classe))) +
      geom_histogram() +
      labs(x = input$classe, y = "Frequência") +
      ggtitle(paste("Histograma de", input$classe))
  })
  
  # Boxplot da série
  output$boxplot <- renderPlot({
    dados <- dados_filtrados1()
    ggplot(dados, aes(y = !!sym(input$classe))) +
      geom_boxplot() +
      labs(y = input$classe) +
      ggtitle(paste("Boxplot de", input$classe))
  })
  
  # ABA 2

  # Uma tabela contendo o valor da correlação entre as duas classes escolhidas
  output$tabela2 <- renderTable({
    dados <- dados_filtrados2()
    dados <- dados %>%
      select(Date, !!sym(input$classe1), !!sym(input$classe2))
    classe1 <- as.name(input$classe1)
    classe2 <- as.name(input$classe2)
    cor <- cor(dados[[classe1]], dados[[classe2]])
    tabela <- data.frame(Classe1 = input$classe1, Classe2 = input$classe2, Correlação = cor)
    tabela
  })
  
  # Gráfico de linha das séries temporais selecionadas.
  output$grafico_linha2 <- renderPlot({
    dados <- dados_filtrados2()
    ggplot(dados, aes(x = Date)) +
      geom_line(aes(y = !!sym(input$classe1)), color = "red") +
      geom_line(aes(y = !!sym(input$classe2)), color = "blue") +
      labs(x = "Data", y = "Valor") +
      ggtitle(paste("Séries temporais de", input$classe1, "e", input$classe2))
  })

  # -[FALTA] Gráfico em barra das médias de cada série (isto é, você tira o valor da média de cada uma das séries e com esses valores faz o gráfico)
  
  # Scatterplot das séries
  output$scatterplot <- renderPlot({
    dados <- dados_filtrados2()
    ggplot(dados, aes(x = !!sym(input$classe1), y = !!sym(input$classe2))) +
      geom_point() +
      ggtitle(paste("Scatterplot das séries", input$classe1, "e", input$classe2))
  })
  
}