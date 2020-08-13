# tmp.enc <- options()$encoding
# options(encoding="UTF-8")
# rsconnect::deployApp()
# options(encoding=tmp.enc)

library(shiny)
library(broom)

shinyServer(function(input, output, session) {
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
    
    output$distPlot <- renderPlot({
        x <- faithful$waiting
        bins <- seq(min(x), max(x), length.out = input$bins+1)
        hist(x, breaks=bins, col="#75AADB", border="white",
             xlab = "Waiting time to next eruption (in mins)",
             main = "Histogram of waiting times")
    })
    
    observeEvent(input$show, {
        showNotification("This is a notification.")
    })
    observeEvent(input$modal, {
        showModal(modalDialog(
            title="Warning !",
            "Wrong acccess"
        ))
    })
    output$basicOut <- renderPlot({
        input$goPlot
        
        dat <- data.frame(x=numeric(0), y=numeric(0))
        
        withProgress(message="Making plot", value=0, {
            n <- 10
            for (i in 1:n) {
                dat <- rbind(dat, data.frame(x=rnorm(1), y=rnorm(1)))
                incProgress(1/n, detail=paste("Doing part", i))
                Sys.sleep(0.1)
            }
        })
        plot(dat$x, dat$y, col="blue")
    })
})