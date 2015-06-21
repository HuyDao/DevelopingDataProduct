library(shiny) 
shinyUI(pageWithSidebar( 
  titlePanel("Investment Yield Calculator"),
  sidebarPanel( 
    h4('Investment'),
    numericInput('sum', 'Investment Sum ($)', 50000, min = 10000, max = 100000000, step = 5000),
    numericInput('years', "Number of years until withdrawal", 5, min = 1, max = 50, step = 1),
    h5('Levers of growth / loss'),
    sliderInput('inflation', 'Inflation in %', value = 3, min = 2.4, max = 5, step = 0.1),
    sliderInput('bankRet', 'Bank interest in %', value = 1, min = 0.5, max = 5, step = 0.1),
    sliderInput('investRet', 'Investment return in %', value = 6, min = 4, max = 15, step = 0.5),
    p("Documentation:",a("AppDocumentation",href="ReadMe.html")) 
  
  ), 
  
  mainPanel( 
    h4("To have today's power of buying, you need to have: ($)"),
    textOutput("value"),
    h4("Cash Yield in today's money ($)"), 
    textOutput("cashYield"), 
    plotOutput('cashPlot'),
    h4("Bank Yield in today's money ($)"), 
    textOutput("bankYield"), 
    plotOutput('bankPlot'),
    h4("Investment Yield in today's money ($)"), 
    textOutput("investYield"), 
    plotOutput('investPlot'),
    br(), 
    h4('Documentation'), 
    helpText("This application shows potential investment yield over years taking into account inflation and predicted market appreciation."), 
    code("Cash Yield"), 
    helpText("Most likely a negative number - cash will only depreciate with inflation."), 
    code("Bank Yield"), 
    helpText("Appreciation of cash based on bank's interest rates."),    
    code("Investment Yield"), 
    helpText("Appreciation of cash based on investment market return rates.")
   ) 
)) 
