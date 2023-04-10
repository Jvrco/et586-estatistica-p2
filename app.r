source('global.r')
source('ui.r')
source('server.r')

shinyApp(
  ui = ui, 
  server = server
)