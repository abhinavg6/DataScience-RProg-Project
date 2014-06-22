## Introduction

The set of R scripts analyse the outcome care data for hospitals across US, which is available from [Hospital Compare](https://data.medicare.gov/data/hospital-compare).

The data file used for this project is ![outcome-of-care-measures.csv](outcome-of-care-measures.csv). The file ![Hospital_Revised_Flatfiles.pdf](Hospital_Revised_Flatfiles.pdf) explains the context of each field in data file.

Following scripts were created for the project:
<ol>
<li>best.R - For a input state (two-letter code) and outcome (heart attack, heart failure or pneumonia), it returns the best performing hospital.</li>
<li>rankhospital.R - For input state (two-letter code), outcome (heart attack, heart failure or pneumonia) and a optional rank (best, worst or a number), it returns the best, worst or ranked hospital in the state. If rank is not provided, then it returns the best hospital by default.</li>
<li>rankall.R - For a input outcome (heart attack, heart failure or pneumonia) and a optional rank (best, worst or a number), it returns a data frame of best, worst or ranked hospital in each state. If rank is not provided, it returns the best hospital in each state.</li>
</ol>

