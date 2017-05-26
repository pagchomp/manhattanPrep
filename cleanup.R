library(reshape2)
folder <- "E:\\Projects\\manhattanPrep\\"
# folder <- "C:\\Users\\bmburk\\Dropbox\\manhattanPrep\\"
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