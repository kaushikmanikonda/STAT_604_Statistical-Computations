#displays any existing objects in the workspace
ls()

#Step to check which liabraries are loaded
search()

#Removes all existing objects and variable assignments. Will be commented out in the final homework to avoid repetition during future executions
#rm(list=ls())

#output is directed to a separate file while still appearing in the console. Includes the full path to show where the output file is being written.
sink("C:/Users/Kaushik/Desktop/TAMU Semesters & Courses/Summer_2020/STAT_604/Assignments/HW_02/Final Files/HW02 Output File",split=TRUE)

#Answer for step 3. The step only asks for the data storage type (class(x)), but I also include object type (mode(x)) for reference.
s3<-seq(from=4,to=80,by=4);s3;class(s3);mode(s3);c(s3[2],s3[4:6]);

#Answer for step 4. The step only asks for the data storage type (class(x)), but I also include object type (mode(x)) for reference.
s4<-seq(from=0.5,to=20,by=0.5);s4;class(s4);mode(s4);s4[1:4];

#Answer to step 5. A matrix that is five columns wide, with each column equal to vector s3 from step 3.
s5<-cbind(s3,s3,s3,s3,s3);s5
class(s5);mode(s5);length(s5);str(s5) #Data storage type and other properties are not asked in the homework. I just add them to the script for reference.

#Answer to step 6. New matric with two rows, with each row equal to vectors s3 & s4 from steps 3 & 4 respectively.
s6<-rbind(s3,s4);s6	#The number of elements in the vector s4 is a multiple of the number of elements in vector s3, so s3 recycling takes place in creating this matrix.
class(s6);mode(s6);length(s6);str(s6) #Data storage type and other properties are not asked in the homework. I just add them to the script for reference.

#Answer to step 7.
s7<-cbind(s3,s4);s7	#The number of elements in the vector s4 is a multiple of the number of elements in vector s3, so s3 recycling takes place in creating this matrix.
class(s7);mode(s7);length(s7);str(s7)	#Data storage type and other properties are not asked in the homework. I just add them to the script for reference.

#Answer to step 8. 
s8<-c(75,95,58,82,67);s8	#Displaying the vector is not required. Done here just for reference.
class(s8);mode(s8);length(s8);str(s8)	#Data storage type and other properties are not asked in the homework. I just add them to the script for reference.

#Answer to step 9.
s9<-c("Quill", "Gamora", "Drax", "Rocket", "Groot");s9
class(s9);mode(s9);length(s9);str(s9)	#Data storage type and other properties are not asked in the homework. I just add them to the script for reference.

#Answer to step 10. Combines vectors s8 & s9, and displays a data.frame
s10<-data.frame(s8,s9);s10
class(s10);mode(s10);length(s10);str(s10)	#Displaying Data storage type (class(x)) is required. Other properties are not asked in the homework. I just add them to the script for reference.
ls()	#shows the contents of the workspace.

#Answer to step 11. Loads the assignment input workspace from my homework folders.
load("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_02\\Final Files\\HW-02 Population.RData")
ls()	#shows the contents of the workspace with the newly loaded object(s).

#Answer to step 12. Displays the object type and Data storage type of the new object "Population".
class(Population);mode(Population);str(Population);length(Population)	#The other two properties are not required, just here for reference.

#Answer to step 13. Displays the object type (mode(x)) and data storage type (class(x)) of column 1 from Population.
class(Population[,1]);mode(Population[,1])

#Answer to step 14. Displays the structure of the object Population.
str(Population)

#Answer to step 15. Displays a summary of the object Population.
summary(Population)

#Answer to step 16. Displays the first 10 rows and all but column 3 from Population.
Population[1:10,-3]

#Answer to step 17. Creates and displays a new object from Population using the first 25 rows, the first column and third column.
s17<-Population[1:25,-2];s17

#Answer to step 18. Closes the output file and stops sending output to it.
sink()

# 19a)
#?date
#date() or Sys.Date()

# 19b)
# 7 packages given by search() command, shown below.
#[1] ".GlobalEnv"        "package:stats"     "package:graphics"  "package:grDevices" "package:utils"    
#[6] "package:datasets"  "package:methods"   "Autoloads"         "package:base"  

# 19c)
# "numeric"

# 19d)
# The values from the first vector s3 are recycled to create the 2x40 vector in step 6, s6.
# The number of elements in the vector s4 is a multiple of the number of elements in vector s3, so s3 recycling takes place in creating this matrix.

# 19e)
# "data.frame" is the class/object storage type & "list" is the object type.

# 19f)
# "factor" class/Data storage type & "numeric" object type

# 19g)
# 254 obs. of  3 variables:

# 19h)
# Median :  18726 &  Mean   : 112999. Half the counties have a population above 18,726 
# & half fall below that level. However, the average of all 254 observations 
# is much higher than the median at 112999. So, one inference could be that 
# Texas' population is heavily concentrated around a few major population centers. 