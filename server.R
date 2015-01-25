library(shiny) 
library(ggplot2)
library(MASS)

asn <- function(text) {as.numeric(text)}

pair <- function(a, b) {paste("(", a, ") + (", b, ")", "i", sep = "")}

solve <- function(degree, rec, imc, reA, imA) {
        r <- (reA^2 + imA^2)^(1/2)
        t <- seq(0, degree - 1, by = 1)
        rez <- round(rec + r^(1/degree) * cos(atan2(imA, reA)/degree + (2 * pi * t)/degree), 2)
        imz <- round(imc + r^(1/degree) * sin(atan2(imA, reA)/degree + (2 * pi * t)/degree), 2)
        data <- data.frame(x = paste("z", t, sep = ""), y = rez, z = imz)
        colnames(data) <- c("z", "Re(z)", "Im(z)")
        rownames(data) <- NULL
        return(data)
}

modulus <- function(reA = 0, imA = 0){
        (reA^2 + imA^2)^(1/(2*degree))
}

draw <- function(degree, rec = 0, imc = 0, reA = 0, imA = 0){
        data1 <- solve(degree, rec, imc, reA, imA)[,2]
        data2 <- solve(degree, rec, imc, reA, imA)[,3]
        df <- data.frame(x = data1, y = data2)
        
        r <- (reA^2 + imA^2)^(1/(2*degree))
        centre <- data.frame(x = rec, y = imc)
        
        g <- ggplot(data = df, aes(x, y)) + geom_point(col = 'salmon', size = 4) + xlim(rec - r - 1, rec + r + 1) + ylim(imc - r - 1, imc + r + 1)
        g <- g + geom_point(data = centre, aes(x,y), col = 'darkgreen', size = 4)
        
        angle <- seq(-pi, pi, length = 50)
        df2 <- data.frame(x = rec + r * cos(angle), y = imc + r * sin(angle))
        
        g <- g + geom_path(aes(x, y), data = df2, inherit.aes = F)
        g <- g + geom_polygon(data = df, aes(x, y), col = 'blue', fill = NA)
        g <- g + labs(x = 'Re(z)', y = 'Im(z)')
        return(g)       
}

shinyServer(
        function(input, output) {
                output$degree <- renderPrint({input$degree})
                output$centre <- renderPrint({noquote(pair(input$rec, input$imc))})
                output$A <- renderPrint({noquote(pair(input$reA, input$imA))})
                
                output$solution <- renderTable({
                        input$solveButton
                        isolate(solve(input$degree, asn(input$rec), asn(input$imc), asn(input$reA), asn(input$imA)))
                        }, include.rownames = FALSE)
                
                output$plot <- renderPlot({
                        if (input$plotButton == 0)
                                return()
                        isolate(draw(input$degree, asn(input$rec), asn(input$imc), asn(input$reA), asn(input$imA)))
                })
        } 
)