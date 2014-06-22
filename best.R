best <- function(state, outcome) {
    
    outcomeDf <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    stateVect <- unique(outcomeDf$State)
    outcomeVect = c("heart attack","heart failure","pneumonia")
    
    if(!(state %in% stateVect)) {
        stop("invalid state")
    }
    if(!(outcome %in% outcomeVect)) {
        stop("invalid outcome")
    }

    result <- character(1)
    
    if(outcome == outcomeVect[1]) {
        outcomeStateDf <- outcomeDf[outcomeDf$State == state & 
                                    outcomeDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack != "Not Available",]
        sortedDf <- outcomeStateDf[order(as.numeric(outcomeStateDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
                                    , outcomeStateDf$Hospital.Name),]
    } else if(outcome == outcomeVect[2]) {
        outcomeStateDf <- outcomeDf[outcomeDf$State == state & 
                                    outcomeDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure != "Not Available",]        
        sortedDf <- outcomeStateDf[order(as.numeric(outcomeStateDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
                                    , outcomeStateDf$Hospital.Name),]       
    } else if(outcome == outcomeVect[3]) {
        outcomeStateDf <- outcomeDf[outcomeDf$State == state & 
                                    outcomeDf$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia != "Not Available",]        
        sortedDf <- outcomeStateDf[order(as.numeric(outcomeStateDf$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
                                    , outcomeStateDf$Hospital.Name),]       
    }
    
    result <- as.character(sortedDf[1,][2])
    #result <- cbind(sortedDf[1], sortedDf[11])
    
    result
}