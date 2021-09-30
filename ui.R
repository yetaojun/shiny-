library(shiny)
shinyServer(function(input, output) {
  
  # Reactive value for selected dataset ----
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # Table of selected dataset ----
  # 将数据以表格形式输出
  output$table <- renderTable({
    datasetInput()
  })
  
  # Downloadable csv of selected dataset ----
  # 下载数据在R里的代表
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    # 记得这里要填个file
    content = function(file) {
      # 写数据内容
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
})
