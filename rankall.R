rankall <- function(outcome, num = "best") {
    
    vect1 <- character(0)
    vect2 <- character(0)
    
    outcomeCompDf <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    outcomeVect = c("heart attack","heart failure","pneumonia")
    
    if(!(outcome %in% outcomeVect)) {
        stop("invalid outcome")
    }
    
    stateOutcomeList <- split(outcomeCompDf, outcomeCompDf$State)
    for(i in seq_along(stateOutcomeList)) {
        outcomeDf <- stateOutcomeList[[i]]
        outcomeRows <- nrow(outcomeDf)
        outcomeState <- outcomeDf$State[1]
        
        if(num != "best" && num != "worst") {
            if(as.numeric(num) > outcomeRows) {
                vect1 <- c(vect1, NA)
                vect2 <- c(vect2, outcomeState)
                next
            }
        }
        
        if(outcome == outcomeVect[1]) {
            outcomeStateDf <- outcomeDf[outcomeDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack != "Not Available",]
            sortedDf <- outcomeStateDf[order(as.numeric(outcomeStateDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
                                             , outcomeStateDf$Hospital.Name),]
        } else if(outcome == outcomeVect[2]) {
            outcomeStateDf <- outcomeDf[outcomeDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure != "Not Available",]        
            sortedDf <- outcomeStateDf[order(as.numeric(outcomeStateDf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
                                             , outcomeStateDf$Hospital.Name),]       
        } else if(outcome == outcomeVect[3]) {
            outcomeStateDf <- outcomeDf[outcomeDf$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia != "Not Available",]        
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
                result <- NA
            } else {
                result <- as.character(sortedDf[numRank,][2])
            }
        }
        
        vect1 <- c(vect1, result)
        vect2 <- c(vect2, outcomeState)
    }
    
    finalDf <- data.frame(hospital=vect1, state=vect2)
    
    finalDf
}