rankhospital <- function(state, outcome, num = "best") {
    
    outcomeDf <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    stateVect <- unique(outcomeDf$State)
    outcomeVect = c("heart attack","heart failure","pneumonia")
    
    if(!(state %in% stateVect)) {
        stop("invalid state")
    }
    if(!(outcome %in% outcomeVect)) {
        stop("invalid outcome")
    }
    
    outcomeDfRows <- nrow(outcomeDf[outcomeDf$State == state,])
    
    if(num != "best" && num != "worst") {
        if(as.numeric(num) > outcomeDfRows) {
            return (NA)
        }
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
    
    if(num == "best") {
        result <- as.character(sortedDf[1,][2])
    } else if(num == "worst") {
        result <- as.character(sortedDf[nrow(sortedDf),][2])
    } else {
        numRank <- as.numeric(num)
        if(numRank > nrow(sortedDf)) {
            return (NA)
        } else {
            result <- as.character(sortedDf[numRank,][2])
        }
    }
    
    result
}