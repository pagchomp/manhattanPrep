Manhattan Prep Presentation: Brett Burk 2017/07/13
Manhattan Prep
========================================================
author: Brett Burk
date: 2017-07-14
width: 1440
height: 900

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

Means Exploration
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
 

Mean Scores for Each Question
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


Aggregate by Course Type
========================================================
<small style="font-size:.5em">


|Question                       | Bootcamp| In-Person Course| Online Course| Private Tutoring| Self Study| Workshop|
|:------------------------------|--------:|----------------:|-------------:|----------------:|----------:|--------:|
|How would you rate your overal |     3.76|             3.63|          3.62|             3.50|       3.62|     3.70|
|Knows [Test] content           |     3.90|             3.93|          3.93|             3.90|         NA|     3.84|
|Is engaging                    |     3.71|             3.83|          3.80|             3.52|         NA|     3.76|
|Communicates effectively       |     3.76|             3.78|          3.81|             3.57|         NA|     3.76|
|Is approachable and friendly   |     3.76|             3.82|          3.83|             3.67|         NA|     3.84|
|Is enthusiastic                |     3.71|             3.86|          3.86|             3.67|         NA|     3.85|
|Cares about my success         |     3.38|             3.61|          3.65|             3.38|         NA|     3.59|
|How would you rate [Instructor |     3.81|             3.80|          3.81|             3.67|         NA|     3.74|
|Would you recommend [Instructo |     3.76|             3.79|          3.80|             3.71|         NA|     3.72|
|Class recordings               |       NA|               NA|            NA|               NA|       3.25|       NA|
|Course slides                  |     3.24|             3.15|          3.37|             3.43|       3.09|     3.48|
|Books                          |     3.71|             3.62|          3.74|             3.76|       3.77|     3.61|
|Online materials               |     3.57|             3.55|          3.66|             3.71|       3.74|     3.59|
|Classroom is comfortable       |     3.29|             3.29|            NA|               NA|         NA|       NA|
|Location is accessible         |     3.43|             3.46|            NA|               NA|         NA|       NA|
|Overall ease of enrollment     |     3.90|             3.70|          3.69|             3.57|       3.64|     3.68|
|Guidance on enrollment options |     3.57|             3.45|          3.44|             3.62|       3.53|     3.43|
|Payment & billing services     |     3.71|             3.57|          3.61|             3.24|       3.64|     3.67|
|Receipt of course materials    |     3.71|             3.62|          3.67|             3.60|       3.59|     3.61|

***

<br>
<br>
<br>


|Question                       | Bootcamp| In-Person Course| Online Course| Private Tutoring| Self Study| Workshop|
|:------------------------------|--------:|----------------:|-------------:|----------------:|----------:|--------:|
|Technical support              |     3.45|             3.50|          3.53|             3.38|       3.53|     3.51|
|Timely and effective response  |     3.57|             3.57|          3.62|             3.57|       3.65|     3.66|
|Professionalism and friendline |     3.76|             3.69|          3.72|             3.71|       3.65|       NA|
|Would you recommend Manhattan  |     3.81|             3.74|          3.76|             3.76|       3.74|     3.75|
|Do you believe a dedicated cor |     0.10|             0.26|          0.20|               NA|         NA|       NA|
|May we contact you to discuss  |     0.19|             0.09|          0.06|               NA|         NA|       NA|
|Knows GMAT content(co)         |     3.83|               NA|          3.88|               NA|         NA|     3.76|
|Is engaging(co)                |     3.78|               NA|          3.67|               NA|         NA|     3.68|
|Communicates effectively(co)   |     3.72|               NA|          3.71|               NA|         NA|     3.67|
|Is approachable and friendly(c |     3.83|               NA|          3.83|               NA|         NA|     3.78|
|Is enthusiastic(co)            |     3.89|               NA|          3.81|               NA|         NA|     3.83|
|Cares about my success(co)     |     3.39|               NA|          3.69|               NA|         NA|     3.62|
|How would you rate [Instructor |     3.72|               NA|          3.75|               NA|         NA|     3.66|
|Would you recommend [Instructo |     3.67|               NA|          3.74|               NA|         NA|     3.63|
|Program Description            |       NA|               NA|            NA|               NA|         NA|       NA|
</small>

Average Score Per Student
========================================================


|     Min.| 1st Qu.|   Median|     Mean|  3rd Qu.| Max.|
|--------:|-------:|--------:|--------:|--------:|----:|
| 1.428571| 3.47619| 3.736842| 3.656834| 3.909091|    4|


Average Score by Instructor Code
========================================================

| Min.| 1st Qu.| Median|  Mean| 3rd Qu.| Max.|
|----:|-------:|------:|-----:|-------:|----:|
| 2.81|    3.34|  3.425| 3.395|  3.4825| 3.59|

Instructor 69?

https://burkdatascience.shinyapps.io/manhattanPrep/


Frequency of Responses
========================================================

|Var1 | Freq|   Pct|
|:----|----:|-----:|
|1    |    8|  0.72|
|2    |   37|  3.33|
|3    |  311| 27.99|
|4    |  755| 67.96|

High and Low scores
========================================================
'Low' is <= 2  
'High' is > 2
<small style="font-size:.55em">

|question                       | overall| lowest| highest| high.low.diffs| overall.low.diffs|
|:------------------------------|-------:|------:|-------:|--------------:|-----------------:|
|How would you rate your overal |    3.63|   1.82|    3.71|           1.89|              1.81|
|Knows [Test] content           |    3.92|   3.65|    3.93|           0.28|              0.27|
|Is engaging                    |    3.81|   3.05|    3.84|           0.80|              0.77|
|Communicates effectively       |    3.78|   2.93|    3.81|           0.88|              0.85|
|Is approachable and friendly   |    3.82|   3.16|    3.85|           0.69|              0.66|
|Is enthusiastic                |    3.85|   3.30|    3.88|           0.58|              0.55|
|Cares about my success         |    3.61|   2.74|    3.64|           0.89|              0.87|
|How would you rate [name]'s te |    3.80|   2.91|    3.83|           0.93|              0.89|
|Would you recommend [name]?    |    3.79|   2.91|    3.82|           0.92|              0.88|
|Class recordings               |    3.25|   2.50|    3.43|           0.93|              0.75|
|Course slides                  |    3.23|   2.36|    3.25|           0.89|              0.87|
|Books                          |    3.66|   3.13|    3.67|           0.54|              0.52|
|Online materials               |    3.59|   2.93|    3.60|           0.67|              0.66|
|Classroom is comfortable       |    3.29|   2.72|    3.28|           0.56|              0.56|
|Location is accessible         |    3.46|   3.24|    3.46|           0.22|              0.22|
|Overall ease of enrollment     |    3.70|   3.29|    3.71|           0.42|              0.41|
|Guidance on enrollment options |    3.45|   2.56|    3.48|           0.92|              0.89|

***

<br>
<br>


|question                       | overall| lowest| highest| high.low.diffs| overall.low.diffs|
|:------------------------------|-------:|------:|-------:|--------------:|-----------------:|
|Payment & billing services     |    3.58|   3.07|    3.61|           0.54|              0.51|
|Receipt of course materials    |    3.63|   3.07|    3.67|           0.60|              0.56|
|Technical support              |    3.50|   2.83|    3.52|           0.70|              0.68|
|Timely and effective response  |    3.59|   2.81|    3.62|           0.81|              0.78|
|Professionalism and friendline |    3.70|   3.10|    3.72|           0.62|              0.60|
|Would you recommend Manhattan  |    3.75|   2.53|    3.80|           1.27|              1.21|
|Do you believe a dedicated cor |    0.24|   0.22|    0.25|           0.03|              0.03|
|May we contact you to discuss  |    0.08|   0.09|    0.09|           0.00|              0.00|
|Knows GMAT content(co)         |    3.85|   3.54|    3.86|           0.32|              0.31|
|Is engaging(co)                |    3.67|   3.54|    3.69|           0.15|              0.14|
|Communicates effectively(co)   |    3.70|   3.54|    3.72|           0.19|              0.17|
|Is approachable and friendly(c |    3.82|   3.62|    3.82|           0.21|              0.20|
|Is enthusiastic(co)            |    3.82|   3.54|    3.81|           0.27|              0.28|
|Cares about my success(co)     |    3.66|   3.23|    3.67|           0.44|              0.43|
|How would you rate [name]'s te |    3.73|   3.46|    3.74|           0.28|              0.26|
|Would you recommend [name]? (c |    3.71|   3.46|    3.73|           0.27|              0.25|
</small>

Communicates Effectively = 0.85  
Cares about my success = 0.89  
Course slides = 0.87  
Guidance on enrollment options = 0.89  


Linear model
========================================================

R^2 0.4617748 <br>Adjusted R^2 0.4441693



***
<small style="font-size:.75em">

|                                                | Coefficient| P-Value|
|:-----------------------------------------------|-----------:|-------:|
|(Intercept)                                     |      -0.588|   0.056|
|`Knows [Test] content`                          |       0.032|   0.681|
|`Is engaging`                                   |      -0.071|   0.258|
|`Communicates effectively`                      |       0.002|   0.974|
|`Is approachable and friendly`                  |      -0.015|   0.805|
|`Is enthusiastic`                               |      -0.043|   0.526|
|`Cares about my success`                        |       0.120|   0.002|
|`How would you rate [name]'s teaching overall?` |       0.362|   0.000|
|`Would you recommend [name]?`                   |       0.169|   0.003|
|`Course slides`                                 |       0.075|   0.009|
|Books                                           |       0.160|   0.000|
|`Online materials`                              |       0.086|   0.010|
|`Classroom is comfortable`                      |       0.032|   0.242|
|`Location is accessible`                        |       0.015|   0.613|
|`Overall ease of enrollment`                    |      -0.031|   0.534|
|`Guidance on enrollment options`                |       0.087|   0.028|
|`Payment & billing services`                    |       0.099|   0.038|
|`Receipt of course materials`                   |       0.017|   0.654|
|`Technical support`                             |      -0.012|   0.801|
|`Timely and effective response`                 |      -0.011|   0.836|
|`Professionalism and friendliness of staff`     |       0.088|   0.058|
|`Has Coinstructor`                              |      -0.024|   0.845|
</small>

Linear model 2
========================================================
R^2 0.3887274 <br>Adjusted R^2 0.3851666

<small style="font-size:.85em">

|                                 | Coefficient| P-Value|
|:--------------------------------|-----------:|-------:|
|(Intercept)                      |       0.453|   0.001|
|`Cares about my success`         |       0.268|   0.000|
|`Course slides`                  |       0.098|   0.000|
|Books                            |       0.177|   0.000|
|`Online materials`               |       0.130|   0.000|
|`Guidance on enrollment options` |       0.117|   0.000|
|`Payment & billing services`     |       0.108|   0.001|
 
***

|                                 |   Df|  Sum Sq| Mean Sq| F value| Pr(>F)|
|:--------------------------------|----:|-------:|-------:|-------:|------:|
|`Cares about my success`         |    1|  66.813|  66.813| 319.883|  0.000|
|`Course slides`                  |    1|  27.922|  27.922| 133.681|  0.000|
|Books                            |    1|  20.695|  20.695|  99.085|  0.000|
|`Online materials`               |    1|   8.412|   8.412|  40.276|  0.000|
|`Guidance on enrollment options` |    1|  10.685|  10.685|  51.157|  0.000|
|`Payment & billing services`     |    1|   2.283|   2.283|  10.928|  0.001|
|Residuals                        | 1030| 215.133|   0.209|      NA|     NA|
</small>

Net Promoter Score
========================================================

Using "How would you rate your overall learning experience with Manhattan Prep?"

+ Promoters (score 9-10) are loyal enthusiasts who will keep buying and refer others, fueling growth. Here they are 4s.
+ Passives (score 7-8) are satisfied but unenthusiastic customers who are vulnerable to competitive offerings. Here they are 3s.
+ Detractors (score 0-6) are unhappy customers who can damage your brand and impede growth through negative word-of-mouth. Here they are 2s and 1s.

Net Promoter Score Individual Questions
========================================================
  
    
    
  Would you recommend Manhattan [Test] to your friends?

|V1  |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:---|:---------|:--------|:---------|:--------|:---------|:--------|
|1   |3         |0.4      |NA        |NA       |4         |8.89     |
|2   |NA        |NA       |NA        |NA       |15        |33.33    |
|3   |39        |5.17     |165       |53.05    |24        |53.33    |
|4   |713       |94.44    |146       |46.95    |2         |4.44     |
|SUM |755       |100.01   |311       |100      |45        |99.99    |
  
    
    
  Program Description

|V1               |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:----------------|:---------|:--------|:---------|:--------|:---------|:--------|
|Bootcamp         |13        |1.72     |4         |1.29     |NA        |NA       |
|In-Person Course |475       |62.91    |198       |63.67    |29        |64.44    |
|Online Course    |172       |22.78    |80        |25.72    |8         |17.78    |
|Private Tutoring |9         |1.19     |6         |1.93     |1         |2.22     |
|Self Study       |20        |2.65     |7         |2.25     |2         |4.44     |
|Workshop         |66        |8.74     |16        |5.14     |5         |11.11    |
|SUM              |755       |99.99    |311       |100      |45        |99.99    |

Net Promoter Score Individual Questions Continued
========================================================
  
    
    
  Is engaging

|V1  |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:---|:---------|:--------|:---------|:--------|:---------|:--------|
|1   |1         |0.14     |1         |0.33     |1         |2.33     |
|2   |4         |0.54     |9         |2.96     |14        |32.56    |
|3   |51        |6.94     |81        |26.64    |10        |23.26    |
|4   |679       |92.38    |213       |70.07    |18        |41.86    |
|SUM |735       |100      |304       |100      |43        |100.01   |
  
    
    
  Communicates effectively

|V1  |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:---|:---------|:--------|:---------|:--------|:---------|:--------|
|1   |1         |0.14     |3         |0.99     |4         |9.3      |
|2   |3         |0.41     |15        |4.93     |13        |30.23    |
|3   |60        |8.16     |87        |28.62    |8         |18.6     |
|4   |671       |91.29    |199       |65.46    |18        |41.86    |
|SUM |735       |100      |304       |100      |43        |99.99    |

Net Promoter Score Individual Questions Continued
========================================================
  
    
    
  Cares about my success

|V1  |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:---|:---------|:--------|:---------|:--------|:---------|:--------|
|1   |5         |0.68     |4         |1.32     |9         |20.93    |
|2   |7         |0.95     |39        |12.83    |8         |18.6     |
|3   |130       |17.69    |126       |41.45    |11        |25.58    |
|4   |593       |80.68    |135       |44.41    |15        |34.88    |
|SUM |735       |100      |304       |100.01   |43        |99.99    |
  
    
    
  Course slides

|V1  |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:---|:---------|:--------|:---------|:--------|:---------|:--------|
|1   |2         |0.27     |3         |0.99     |4         |8.89     |
|2   |52        |6.98     |54        |17.76    |24        |53.33    |
|3   |350       |46.98    |211       |69.41    |14        |31.11    |
|4   |341       |45.77    |36        |11.84    |3         |6.67     |
|SUM |745       |100      |304       |100      |45        |100      |


Net Promoter Score Individual Questions Continued
========================================================
  
    
    
  Guidance on enrollment options

|V1  |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:---|:---------|:--------|:---------|:--------|:---------|:--------|
|1   |NA        |NA       |4         |1.3      |5         |11.63    |
|2   |29        |3.91     |41        |13.36    |19        |44.19    |
|3   |215       |28.98    |177       |57.65    |9         |20.93    |
|4   |498       |67.12    |85        |27.69    |10        |23.26    |
|SUM |742       |100.01   |307       |100      |43        |100.01   |
  
    
    
  Professionalism and friendliness of staff

|V1  |Prom.Freq |Prom.Pct |Pass.Freq |Pass.Pct |Detr.Freq |Detr.Pct |
|:---|:---------|:--------|:---------|:--------|:---------|:--------|
|1   |NA        |NA       |1         |0.35     |NA        |NA       |
|2   |1         |0.15     |13        |4.53     |11        |28.21    |
|3   |109       |16.17    |126       |43.9     |13        |33.33    |
|4   |564       |83.68    |147       |51.22    |15        |38.46    |
|SUM |674       |100      |287       |100      |39        |100      |
