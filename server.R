library(shiny)
library(ggplot2)

data <- as.data.frame(UCBAdmissions)
nsum <- aggregate(data$Freq ~ data$Gender + data$Dept, data, sum)
names(nsum) <- c("Gender","Dept","Total")
data2 <- merge(data, nsum, by=c("Dept","Gender"))
data2$Percentage <- round((data2$Freq/ data2$Total * 100),1)

shinyServer(function(input, output) {
  
  select_data  <- reactive({
                            subset(data2, Dept == input$select_dept & Gender == input$select_gender)
                          })
  output$comparison <- renderTable({ 
                                    select_data()
                                  })
  output$output_dept <- renderText({
                                    paste("Department selected:", input$select_dept)
                                  })
  output$output_gender <- renderText({
                                      paste("Gender selected:", input$select_gender)
                                    })
  output$output_plot <- renderPlot({
                                    p <-  ggplot(select_data(), aes(x = Admit, y = Percentage)) + geom_bar(stat = "identity", fill=c("green","red")) + ggtitle("UC Berkeley Admissions, by Dept and Gender") + xlab("")
                                    p + theme(plot.title = element_text(size = 20))
                                  })
})
