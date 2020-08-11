library(shiny)
library(broom)

function(input, output, session) {
    output$well <- renderText({ 
        code <- "ui <- fluidPage(...)
        
server <- function(input, output) {
...
}

shinyApp(ui, server)" 
        code
        })
    output$textOut <- renderPrint({ input$text })
    output$numOut <- renderPrint({ input$num })
    output$slide1Out <- renderPrint({ input$slide1 })
    output$slide2Out <- renderPrint({ input$slide2 })
    output$slide3Out <- renderPrint({ input$slide3 })
    output$selectOut <- renderPrint({ input$select })
    output$radioOut <- renderPrint({ input$radio })
    output$checkOut <- renderPrint({ input$check })
    output$tableOut <- renderTable({ tidy(lm(mpg~wt+qsec, data=mtcars ))},
                                   striped=TRUE, hover=TRUE, bordered=TRUE)
    output$plotOut <- renderPlot({ plot(mtcars$wt, mtcars$mpg, col="red") })
}