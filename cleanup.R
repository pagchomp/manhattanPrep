folder <- "E:\\Projects\\manhattanPrep\\"
# folder <- "C:\\Users\\bmburk\\Dropbox\\manhattanPrep\\"
api.key <- read.table(paste0(folder, "convertAPIKey"), header = F)[[1]]
wf <- read.csv(paste0(folder, "GMATraw.csv"), stringsAsFactors = FALSE)
names(wf)[1] <- "SID"
ques <- read.csv(paste0(folder, "GMATrawQues.csv"), stringsAsFactors = FALSE)
names(wf) <- ques[,2]

# added here
quart.df <- data.frame(first = numeric(), second = numeric(), third = numeric(), fourth = numeric())
for(col in 2:24){
  quart.df <- rbind(quart.df, summary(wf[,col]))
}

inst.df <- data.frame(Question = ques[2:24,2])

unique.codes <- unique(c(wf$`Lead Instructor Code`, wf$`Co-Instructor Code`))
avgs <- numeric()
for(uc in unique.codes){
  
  ic <- wf[wf$`Lead Instructor Code` == uc | wf$`Co-Instructor Code` == uc,]
  inst.df <- data.frame(inst.df, Mean = round(colMeans(ic[,2:24], na.rm = T), 3))
  names(inst.df)[ncol(inst.df)] <- uc
  
}

colnames(inst.df) <- gsub("^X", "",  colnames(inst.df))

inst.df <- data.frame(t(inst.df))
names(inst.df) <- ques[2:24,2]
inst.df <- inst.df[-1,]
inst.df <- data.frame(instCode = row.names(inst.df), inst.df, stringsAsFactors = F, check.names = F)
library(reshape2)
inst.df <- melt(inst.df, id.vars = "instCode")
names(inst.df) <- c("Instructor", "Questions", "Means")

write.csv(inst.df, paste0(folder, "cleanedManhattan.csv"), row.names = F)

ques.df <- wf <- inst.df 

folder <- "E:\\Projects\\manhattanPrep\\"
wf <- read.csv(paste0(folder, "cleanedManhattan.csv"), stringsAsFactors = FALSE)

# ggplot(data = ques.df, aes(x = Questions, y = Means)) + 
#   geom_bar(stat="identity", position = position_dodge(width=10)) + 
#   # coord_flip() + 
#   ylab("Likert Score") + 
#   ggtitle(paste("Instructor", "")) +
# theme_bw() +
# ylim(0, 4)

# 
# ques.df <- colMeans(wf[,2:24])
# ques.df <- data.frame(Questions = names(ques.df), Means = ques.df)
# ques.df <- ques.df[,2:3]
# names(ques.df) <- c("Questions", "Means")