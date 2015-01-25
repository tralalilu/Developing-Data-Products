library(shiny)
require(markdown)

shinyUI(navbarPage("Binomic Equation Calculator",
                   tabPanel("Solution",
                            sidebarLayout(      
                                    sidebarPanel(
                                            withMathJax(),
                                            p('We solve the binomic equation \\((z-c)^n = A\\), where \\(n\\) is a natural number and \\(c, A\\) are complex numbers.'),
                                            numericInput('degree', 'Insert the degree of the equation, \\(n\\) (between 1 and 20)', 1, min = 1, max = 20, step = 1),
                                            textInput('rec', 'Insert the real part of c', value = '0'),
                                            textInput('imc', 'Insert the imaginary part of c', value = '0'),
                                            textInput('reA', 'Insert the real part of A', value = '0'),
                                            textInput('imA', 'Insert the imaginary part of A', value = '0'),
                                            p(),
                                            actionButton('solveButton', 'Solve'),
                                            actionButton('plotButton', 'Plot')
                                    ),
                                    mainPanel(
                                            h4('You entered the following data:'), 
                                            p('The degree of the equation, \\(n\\), is'), verbatimTextOutput('degree'),
                                            p('The centre \\(c\\) is'), verbatimTextOutput('centre'),
                                            p('and the value of \\(A\\) is'), verbatimTextOutput('A'),
                                            h4('The solutions of the equation are:'),
                                            tableOutput('solution')
                                    )
                            )
                   ),
                   tabPanel("Plot", 
                            sidebarLayout(
                                    sidebarPanel(
                                            p('We plot the solutions of our binomic equation.'), 
                                            p('Notice that the solutions lie on a circle with centre \\(c\\) and radius \\(\\sqrt[n]{|A|}\\).'),
                                            p('The solutions are the vertices of a regular \\(n\\)-sided polygon inscribed in this circle.')
                                            ),
                                    mainPanel(
                                            p('Here is the plot!'), plotOutput("plot", width = 300, height = 300)
                                    )
                            )
                   ),
                   tabPanel("About", includeMarkdown("README.md"))
))
