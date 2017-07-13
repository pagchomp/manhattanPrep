<style type="text/css">

body, td {
   font-size: 14px;
}
code.r{
  font-size: 14px;
}
pre {
  font-size: 14px
}
</style>

Manhattan Prep Presentation
Manhattan Prep
========================================================
author: Brett Burk
date: 2017-07-14
autosize: true

Getting started
========================================================

R used for the load-in and analysis. All files (including this one) are on https://github.com/pagchomp/manhattanPrep
<small style="font-size:.3em">

```r
library(reshape2)
folder <- "E:\\Projects\\manhattanPrep\\"
# folder <- "C:\\Users\\bmburk\\Dropbox\\Projects\\manhattanPrep\\"
# Load in
wf <- read.csv(paste0(folder, "GMATraw.csv"), stringsAsFactors = FALSE)
ques <- read.csv(paste0(folder, "GMATrawQues.csv"), stringsAsFactors = FALSE)
names(wf)[1] <- "SID"
names(wf) <- ques[,2]

# Create df for instructors
inst.df <- data.frame(Question = ques[2:24,2])

# Get unique codes
unique.codes <- unique(c(wf$`Lead Instructor Code`, wf$`Co-Instructor Code`))
# Create avgs vector
avgs <- numeric()
# Fill inst.df
for(uc in unique.codes){
  ic <- wf[wf$`Lead Instructor Code` == uc | wf$`Co-Instructor Code` == uc,]
  inst.df <- data.frame(inst.df, Mean = round(colMeans(ic[,2:24], na.rm = T), 3))
  names(inst.df)[ncol(inst.df)] <- uc
}

# R insists on adding X to the beginning of column names
colnames(inst.df) <- gsub("^X", "",  colnames(inst.df))

# Rotate and change names
inst.df <- data.frame(t(inst.df))
names(inst.df) <- ques[2:24,2]
inst.df <- inst.df[-1,]

# 
inst.df <- data.frame(instCode = row.names(inst.df), inst.df, stringsAsFactors = F, check.names = F)

inst.df <- melt(inst.df, id.vars = "instCode")
names(inst.df) <- c("Instructor", "Questions", "Means")

# Write data frame
write.csv(inst.df, paste0(folder, "cleanedManhattan.csv"), row.names = F)

# Create mean scores df and write it
ms.df <- data.frame(Question = ques[2:24,2], Mean = colMeans(wf[,2:24], na.rm = T))
ms.df[,3] <- ms.df[,2]
ms.df[,2] <- ms.df[,1]
ms.df[,1] <- NA
ms.df <- cbind(ms.df, 'Mean')
names(ms.df) <- c("Instructor", "Questions", "Means", "Type")
write.csv(ms.df, paste0(folder, "meanScores.csv"), row.names = F)
```
</small>

Means exploration
========================================================

How would you rate your overall learning experience with Manhattan Prep? MEAN: 3.63 


|  1|  2|   3|   4|  NA|
|--:|--:|---:|---:|---:|
|  8| 37| 311| 755| 248|
 
Knows [Test] content MEAN: 3.92 


|  1|  2|  3|    4| NA|
|--:|--:|--:|----:|--:|
|  1|  3| 91| 1226| 38|
 
Is engaging MEAN: 3.81 


|  1|  2|   3|    4| NA|
|--:|--:|---:|----:|--:|
|  3| 33| 173| 1112| 38|
 

Mean Scores for each question
========================================================
<small style="font-size:.5em">


|   |Question                                                                 |     Mean|
|:--|:------------------------------------------------------------------------|--------:|
|2  |How would you rate your overall learning experience with Manhattan Prep? | 3.631863|
|3  |Knows [Test] content                                                     | 3.924300|
|4  |Is engaging                                                              | 3.812263|
|5  |Communicates effectively                                                 | 3.781983|
|6  |Is approachable and friendly                                             | 3.822727|
|7  |Is enthusiastic                                                          | 3.853899|
|8  |Cares about my success                                                   | 3.613172|
|9  |How would you rate [InstructorFirstName]'s teaching overall?             | 3.797880|
|10 |Would you recommend [InstructorFirstName]?                               | 3.786525|
|11 |Class recordings                                                         | 3.250000|
|12 |Course slides                                                            | 3.229679|
|13 |Books                                                                    | 3.655970|
|14 |Online materials                                                         | 3.585403|
|15 |Classroom is comfortable                                                 | 3.286374|
|16 |Location is accessible                                                   | 3.458430|
|17 |Overall ease of enrollment                                               | 3.697173|
|18 |Guidance on enrollment options                                           | 3.452167|

***

<br>
<br>
<br>


|   |Question                                                                         |      Mean|
|:--|:--------------------------------------------------------------------------------|---------:|
|19 |Payment & billing services                                                       | 3.5847076|
|20 |Receipt of course materials                                                      | 3.6315396|
|21 |Technical support                                                                | 3.5045942|
|22 |Timely and effective response                                                    | 3.5901141|
|23 |Professionalism and friendliness of staff                                        | 3.7018684|
|24 |Would you recommend Manhattan [Test] to your friends?                            | 3.7476085|
|25 |Do you believe a dedicated corporate [Test] course for your company's employees  | 0.2422981|
|26 |May we contact you to discuss arranging a dedicated corporate course at your com | 0.0818260|
|27 |Knows GMAT content(co)                                                           | 3.8495575|
|28 |Is engaging(co)                                                                  | 3.6747788|
|29 |Communicates effectively(co)                                                     | 3.7035398|
|30 |Is approachable and friendly(co)                                                 | 3.8185841|
|31 |Is enthusiastic(co)                                                              | 3.8163717|
|32 |Cares about my success(co)                                                       | 3.6615044|
|33 |How would you rate [InstructorFirstName]'s teaching overall?(co)                 | 3.7256637|
|34 |Would you recommend [InstructorFirstName]? (co)                                  | 3.7101770|
</small>
