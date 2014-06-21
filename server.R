library(shiny)
library(caret)

print("Loading Data...")
ttt <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE, sep=",")
print("DONE")

print("Training Random Forest...")
modelrf <- train(ttt$V10~.,method="rf",data=ttt, trControl = trainControl(method = "cv", number = 2))
print("DONE")

print("Training Decision Tree...")
modelrpart <- train(ttt$V10~.,method="rpart",data=ttt)
print("DONE")

columnnames <- colnames(ttt)

makefact <- function(something) {
    if(something == "Blank") return(as.factor("b"))
    if(something == "  X  ") return(as.factor("x"))
    if(something == "  O  ") return(as.factor("o"))
    return(as.factor(1))
}

shinyServer(

    
    
    function(input, output) {
        output$textrf <- renderPrint({modelrf})
        output$texttree <- renderPrint({modelrpart$finalModel})
        getmethodofpred <-reactive({
                     x<-input$methodofpred
                     return(x)
        })   
         
        getrow1 <- reactive({
            return(c(input$c11,input$c12,input$c13))
        })
        
        getrow2 <- reactive({
            return(c(input$c21,input$c22,input$c23))
        })
        
        getrow3 <- reactive({
            return(c(input$c31,input$c32,input$c33))
        })
        
              
        
        ipc11 <- reactive({return(input$c11)})
        ipc12 <- reactive({return(input$c12)})
        ipc13 <- reactive({return(input$c13)})
        ipc21 <- reactive({return(input$c21)})
        ipc22 <- reactive({return(input$c22)})
        ipc23 <- reactive({return(input$c23)})
        ipc31 <- reactive({return(input$c31)})
        ipc32 <- reactive({return(input$c32)})
        ipc33 <- reactive({return(input$c33)})
        
        
        
        
        rawtable <- reactive({
            d <- data.frame(
                V1 = makefact(ipc11()),
                V2 = makefact(ipc12()),
                V3 = makefact(ipc13()),
                V4 = makefact(ipc21()),
                V5 = makefact(ipc22()),
                V6 = makefact(ipc23()),
                V7 = makefact(ipc31()),
                V8 = makefact(ipc32()),
                V9 = makefact(ipc33()),
                V10<-""
                )
            return(d)
        })
        
        
        output$methodchosen <-renderPrint({
            if(getmethodofpred()=="rpart") 
                {"Decision Tree"}
            else
                {"Random Forest"}
        })
        
        output$row1 <- renderText({
            getrow1()
        })
        output$row2 <- renderText({
            getrow2()
        })
        output$row3 <- renderText({
            getrow3()
        })
        

        output$resultofgame <- renderPrint({
            if(getmethodofpred()=="rpart") 
                {as.character(predict(modelrpart,rawtable()))}
            else
                {as.character(predict(modelrf,rawtable()))}
            
        })
    
    }
)
