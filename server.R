library(shiny) 
shinyServer( 
  function(input, output){ 
    output$value <- renderText({calculateValue(input$sum, input$years, input$inflation)})
 
    output$cashYield <- renderText({ calculateCashYield(input$sum, input$years, input$inflation) }) 
 
    output$cashPlot<- renderPlot({
      inflation = -0.01 * input$inflation
      growSum <- input$sum   
      linePlace <- input$years
      cData<-data.frame(1, 1)
      for (i in 1:50)
      {
        growSum<-growSum + (growSum*inflation)
        cData[i,1]<-as.numeric(round(growSum, digits = 2))
        cData[i, 2] <- i
      }
      plot(cData[, 2], cData[, 1], xlab = "Year of investment", ylab = "Sum", main = "Depreciation of cash over years", col="blue", ylim = c(0, input$sum), type = "o")
      lines(cData[, 2], cData[, 1], type = "h", lwd=1.5, col = "red") 
      lines(cData[as.numeric(linePlace), 2], cData[as.numeric(linePlace), 1], type = "h", lwd=5, col = "black") 
      })
   
    output$bankYield <- renderText({ calculateBankYield(input$sum, input$years, input$inflation, input$bankRet) }) 
    
    output$bankPlot<- renderPlot({
      inflation = -0.01 * input$inflation
      bRate <- 0.01 * input$bankRet
      linePlace <- input$years
      growSum <- input$sum   
      cbData<-data.frame(1, 1)
      for (i in 1:50)
      {
        growSum<-growSum + (growSum*bRate)
        growSum<-growSum + (growSum*inflation)
        cbData[i, 1]<-as.numeric(round(growSum, digits = 2))
        cbData[i, 2] <- i
      }
      plot(cbData[, 2], cbData[, 1], xlab = "Years of investment", ylab = "Sum", main = "Growth/loss of banking investment over years", col="blue", ylim = c(min(cbData[, 1]), max(cbData[,1]) ), type = "o")
      lines(cbData[, 2], cbData[, 1], type = "h", lwd=1.5, col = "red")
      lines(cbData[as.numeric(linePlace), 2], cbData[as.numeric(linePlace), 1], type = "h", lwd=5, col = "black") 
    })
    
    
    output$investYield <- renderText({ calculateInvestYield(input$sum, input$years, input$inflation, input$investRet) }) 
   
    output$investPlot<- renderPlot({
      inflation = -0.01 * input$inflation
      iRate <- 0.01 * input$investRet
      linePlace <- input$years
      growSum <- input$sum   
      ciData<-data.frame(1, 1)
      for (i in 1:50)
      {
        growSum<-growSum + (growSum*iRate)
        growSum<-growSum + (growSum*inflation)
        ciData[i, 1]<-as.numeric(round(growSum, digits = 2))
        ciData[i, 2] <- i
      }
      plot(ciData[, 2], ciData[, 1], xlab = "Years of investment", ylab = "Sum", main = "Growth/loss of financial investment over years", col="blue", ylim = c(min(ciData[, 1]), max(ciData[,1]) ), type = "o")
      lines(ciData[, 2], ciData[, 1], type = "h", lwd=1.5, col = "red")
      lines(ciData[as.numeric(linePlace), 2], ciData[as.numeric(linePlace), 1], type = "h", lwd=5, col = "black")    })
    
calculateValue <- function (sum, years, inflat)  
{ 
  inflation = 0.01 * inflat
  growSum <- sum  
  for (i in 1:years){
    growSum<-growSum + (growSum*inflation)
  }
  result <- growSum
  return(round(result, digits = 2)) 
} 


calculateCashYield <- function (sum, years, inflat)  
{ 
  inflation = -0.01 * inflat
  growSum <- sum  
  for (i in 1:years){
    growSum<-growSum + (growSum*inflation)
  }
  result <- growSum
  return(round(result, digits = 2)) 
} 

calculateBankYield <- function (sum, years, inflat, bankRet)  
{ 
  inflation <- -0.01 * inflat
  bankReturn = 0.01*bankRet
  growSum <- sum    
  for (i in 1:years){
    growSum<-growSum + (growSum*bankReturn)
    growSum <- growSum + (growSum*inflation)
  }
  result <- growSum
  return(round(result, digits = 2)) 
} 

calculateInvestYield <- function (sum, years, inflat, investRet)  
{ 
  inflation = -0.01 * inflat
  investReturn = 0.01*investRet
  growSum <- sum    
  for (i in 1:years){
    growSum<-growSum + (growSum*investReturn)
    growSum <- growSum + (growSum*inflation)
  }
  result <- growSum
  return(round(result, digits = 2)) 
} 

})