#Displays Date & Time
date()

#Displays any existing objects in the workspace
ls()

#Step to check which liabraries are loaded
search()

#Removes all existing objects and variable assignments. 
#Will be commented out in the final homework to avoid repetition during future executions
rm(list=ls())
ls()

#STEP_02: Loads the workspace from the previous assignment. Displays
#a summary of the data frame containing data as of May 28.
load("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_05\\HW_04_KM.RData")
ls()
summary(s7FRAME)

#STEP_03: Use the median function combined with the with function to display the Median of the positive
#case count from the May 28 data frame. Display the median of the death count using the same method.
names(s7FRAME)[3]; names(s7FRAME)[4]	#Double checking the columns
grep("TRUE",(s7FRAME[,3]<0))	#To check if there are any negative values
grep("TRUE",(s7FRAME[,4]<0))	#To check if there are any negative values
with(s7FRAME,median(PEOPLE_POSITIVE_CASES_COUNT,na.rm=TRUE)) #Median for Positive cases count
with(s7FRAME,median(PEOPLE_DEATH_COUNT,na.rm=TRUE)) #Median for Positive Death count

#STEP_04: Use a line of code to direct all graphic output to your PDF document.
pdf("C:/Users/Kaushik/Desktop/TAMU Semesters & Courses/Summer_2020/STAT_604/Assignments/HW_05/Final Files/Graphic Output.pdf")

#STEP_05: Create a histogram of the column containing the total cases percent from the May 28 data with
#breaks at every 0.001.
s5<-s7FRAME$PPCC_PERCENT[grep("FALSE",s7FRAME[,9]=="NA")]	#Selecting only non-NA Values
hist(s5,breaks=(0.03/0.001),freq=FALSE, main="PPCC_Percent Histogram",xlab="Percent")

#STEP_06: Add to the graph a blue line that shows the normal distribution density of 
#these percentage amounts.
#create a vector of "X" values
	Xd<-seq(0,0.03,0.001)
  #create vector of densities for our data
	Yd<-dnorm(Xd,mean=mean(s5),sd=sd(s5)) 
  #plot the distribution
	lines(Xd,Yd,col="blue")


#STEP_07: Draw a red vertical line at the mean percentage value. Use a function 
#to determine the position of the line instead of hard coding the current mean 
#value. Use the color number from the color palette to specify the line color. 
#Draw a yellow line at the median in the same manner.
palette()	#Checking colors in palette
palette(c("blue","red","yellow","green","orange","violet")) #Changing palette
abline(v=mean(s5),col=palette()[2]) #Red Vertical Line
abline(v=median(s5),col=palette()[3]) #Yellow Vertical Line

#STEP_08: Plot a point for each county with data using total
#cases for the x axis and total deaths for the y axis. Use a plot 
#character that resembles a small x. Use a hex value to “mix” a color 
#for the points that has a Red amount of 39, a Green amount of
#33 and a Blue amount of FF. Supply appropriate labels for the axes and an appropriate title for
#the graph.
s8a<-s7FRAME[,3][!is.na(s7FRAME[,3])]
s8a
s8b<-s7FRAME[,4][!is.na(s7FRAME[,4])]
s8b
plot(s8a,s8b,pch=4,type="p",main="Cases & Deaths Correlation",xlab="Total Cases",ylab="Total Deaths",col="#3933ff")

#STEP_09: Add a fit line to the plot.
abline(lm(s8b~s8a),col="green")
#Fit line colored green for contrast

#STEP_10: Use functions to imbed text showing the date and time of creation in the lower 
#right-hand corner of the graph area. The exact value of the coordinates for the time stamp 
#location are not critical as long as the time stamp is near the corner. You may hard code 
#these coordinates. The date and time must change automatically each time the script is run.
mtext(date(),side=4,adj=0)

#STEP_11: Use logic expressions as index parameters to create a subset of the Texas COVID data frame
#where the population of the county is greater than 1 million and the date is greater than March
#15, 2020. You can use the value “2020-03-15” in your comparison statement. Include all
#columns in the subset. Display a summary of the new data frame. Display a table showing a
#frequency count of each county in the data frame. You will need to treat the county name as a
#character value. Otherwise, it will remember all the values in the factor from the original data
#frame and fill up your console with values that have a count of 0. Your table should only have 6
#columns.
s11<-MTEXAS[((MTEXAS$ACTUAL_DATE>"2020-03-15")&(MTEXAS$POPULATION>1000000)),]
summary(s11)
table(as.factor(s11$COUNTY_NAME))

#STEP_12: Create a boxplot of the New Cases Count grouped by county using the subset of large 
#counties. You will need to treat the county name as character is this step, also. Supply 
#appropriate axis labels and a main title for the chart. The inside of the boxes is maroon.
s12a<-s11[,5][!is.na(s11[,5])]
str(s12a)
s12b<-s11$COUNTY_NAME
s12b
grep("Maroon",colors(),ignore.case=TRUE)
#Line to find out the number for Maroon, it is #455
s12c<-colors()[455]
boxplot(s12a~s12b,col=s12c,main="County Boxplot",xlab="County Name",ylab="New Cases")

#Closing Step
graphics.off()

#STEP_13a: What was the maximum new death count on May 28?
# 4

#STEP_13b: What was the median positive cases count on May 28?
# 23

#STEP_13c: What was the median death count on May 28?
# 0

#STEP_13d: Explain why you think the case percent graphed in step 5 is or is not normally
#distributed.
# The fit between the normal distribution line and the data is almost non-existent
# Most of the data entries are concentrated between 0 & 0.0010, while 
# the mean is 0.0018. More than 90% of the data is within 1 standard
#deviation (sd = 0.0029) from the mean (0.00176). This is not a 
#characteristic of a normally distributed dataset

#STEP_13e: Describe the relationship with the fit line and the plotted points.
# The total deaths increase linearly with the total cases from the fit line.
# Counties with higher number of cases also usually have a higher number of deaths 

#STEP_13f: How many times is Travis county in the data frame of large counties?
# 74 times

#STEP_13g: Which counties have outliers in the plot of daily new cases by county?
# Bexar, Harris, Tarrant