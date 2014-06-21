library(shiny)

shinyUI(fluidPage(
    
    br(),
    
    fluidRow(
        h1("Tic-Tac-Toe EndGame Learner"),
        hr(),
        h2("What this app does:"),
        p("Given an endgame for the game of Tic-Tac-Toe, (in which X has moved first), this app
          tells if X has won or not. Of course, it is easy to tell just looking at the end-game
          what the outcome is, but we want to see if machines can learn this, without performing the actual logic. 
          We train the machine by two methods ---
          Random Forests and Decision Trees. If you don't know what Tic-Tac-Toe is, see here: en.wikipedia.org/wiki/Tic-tac-toe

          "),
            
        br(),
        h2("How to use this app:"),
        p("This app runs best in full screen mode."),
        p("In the 9 cells below, enter your ending board. The titles of the inputs are self-explanatory.
          Choose one of the methods, and hit Submit. You will see the result of what the computer has learnt."),
        p("For fun, here are some end-games where the results of Decision Tree differs from a Random Forest: (b stands for Blank)"),
        p("EXAMPLE1 --- Row 1: o  o  x, Row 2:  x  x  o, Row 3:  o  x  x"),
        p("EXAMPLE2 --- Row 1: x  o  x, Row 2:  x  o  o, Row 3:  b  o  x"),
        p("EXAMPLE3 --- Row 1: x  x  o, Row 2:  b  o  o, Row 3:  x  x  o"),
        p("EXAMPLE4 --- Row 1: x  o  x, Row 2:  x  o  x, Row 3:  b  o  o"),
        p("Of course, random forests do much better than decision trees since they average over a lot of decision trees.
          If you want some more information on the trained models, look at the bottom of the page.")
    ),
    
    
    fluidRow(
        h2("Inputs:")
    ),
    
    br(),
    
    
    fluidRow(
        
        column(4,
               selectInput('c11', 'Row1 Col1',c('Blank',"  X  ","  O  "),selected="  O  "),
               selectInput('c21', 'Row2 Col1',c('Blank',"  X  ","  O  "),selected="  X  "),
               selectInput('c31', 'Row3 Col1',c('Blank',"  X  ","  O  "),selected="  O  ")            
        ),
        column(4,
               selectInput('c12', 'Row3 Col2',c('Blank',"  X  ","  O  "),selected="  O  "),
               selectInput('c22', 'Row3 Col2',c('Blank',"  X  ","  O  "),selected="  X  "),
               selectInput('c32', 'Row3 Col2',c('Blank',"  X  ","  O  "),selected="  X  ")
        ),
        
        column(4,
               selectInput('c13', 'Row3 Col3',c('Blank',"  X  ","  O  "),selected="  X  "),
               selectInput('c23', 'Row3 Col3',c('Blank',"  X  ","  O  "),selected="  O  "),
               selectInput('c33', 'Row3 Col3',c('Blank',"  X  ","  O  "),selected="  X  ")              
        )
        
    ),
    
    br(),
    
    fluidRow(
            column(3,
                radioButtons('methodofpred', 'Method',
                             choices = list(
                                 'Random Forest (method="rf")'="rf",
                                 'Decision Tree (method="rpart")'="rpart"),
                             selected="rf"),
                submitButton('Submit')
                
            )
        
                
        ),
    
    br(),
    
    fluidRow(
            h2("Results:")
        ),
    
    fluidRow(
                    h4("End Game Entered:"),
                    verbatimTextOutput("row1"),
                    verbatimTextOutput("row2"),
                    verbatimTextOutput("row3"),
                    textOutput("table1"),
                    h4("Method Chosen:"),
                    textOutput('methodchosen'),
                    h4("Has X won? (positive: Yes, negative: No): "),
                    textOutput("resultofgame")
                   
    
        ),
    
    hr(),
    
    fluidRow(
        
        h2("Models:"),
        
        column(5,
               h5("Random Forest"),
               textOutput('textrf')
               ),
        
        
        column(5,
               h5("Decision Tree"),
               textOutput('texttree')
        )
        
        
        ),
    
    hr(),
    
    fluidRow(
        h2("Acknowledgements:"),
        
        p("The data for this app comes from https://archive.ics.uci.edu/ml/datasets/Tic-Tac-Toe+Endgame"),
        p("We thank the creators of this data.")
        
        
        )
    
    
))