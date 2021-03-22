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

#STEP_02: Loads the workspace from assignment #4 & Displays
# the contents of my workspace.
load("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_06\\HW_04_KM.RData")
ls()

#STEP_03: Permanently convert the COUNTY_NAME column in the May 28 data frame from a factor to a
#character type.Display the structure of the modified data frame.
str(s7FRAME)
str(MTEXAS)
class(s7FRAME$COUNTY_NAME);mode(s7FRAME$COUNTY_NAME)
#No need to convert for me, because the column is already a character type.

#STEP_04: One of the parameters for the function will be a value for the upper 
#limit of the Y axis. Assign the value of 500 to a scalar that can be used in 
#the plotting expression.
s4<-500
class(s4);mode(s4)
#s4 is a scalar

#STEP_4a: Use a conditional statement to change the value of the upper limit 
#scalar created above to the maximum value of PEOPLE_POSITIVE_CASES_COUNT from 
#the data frame of all Texas COVID data if the upper limit scalar contains a 
#negative value.
s4a<-ifelse(s4<0,max(MTEXAS$PEOPLE_POSITIVE_CASES_COUNT[!is.na(MTEXAS$PEOPLE_POSITIVE_CASES_COUNT)]),s4)
#!is.na() expression gets rid of the NA values when looking for the max
s4a

#TITLE: BRAZOS COUNTY [SCALE] = 500 (Below Script)

#STEP_4b: Use logic expressions as indices to create a new data frame that 
#is a subset of the Texas COVID data for a single county. Include only those 
#rows where the PEOPLE_POSITIVE_CASES_COUNT is greater than 0, so we are only 
#plotting the time from the first case onward. For this part of the assignment 
#use rows from Brazos county. The only columns we need are the new date column 
#created in a previous assignment and the PEOPLE_POSITIVE_CASES_COUNT column. 
#Use column numbers to select the columns in the order named above.
s4b1<-MTEXAS[(MTEXAS$COUNTY_NAME=="Brazos"),]
str(s4b1)
s4b2<-s4b1[(s4b1$PEOPLE_POSITIVE_CASES_COUNT>0),c(8,3)]
s4b2

#STEP_4c: Reorder the new data frame by ascending date.
s4b2<-s4b2[order(s4b2$ACTUAL_DATE),]
s4b2

#STEP_4d: Create a barplot of cases by day using the value of PEOPLE_POSITIVE_CASES_COUNT 
#for the height of the vertical bars. Use the dates as the names for the bars. 
#Set the range of the bars to be from 0 to the upper limit scalar assigned at 
#the beginning of the assignment. Supply a main title that uses plotmath and 
#can resolve the value of variable names to automatically adapt to the data 
#provided. Hard code the word County after the county name. The symbols are 
#lceil and rceil. You can see them used by running the demo of plotmath. 
#HINT: The paste function can be a helpful companion to the
#plotmath functions. The title for this section of the script must be as shown:

pdf("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_06\\Final Files\\HW_06_Graphics_Output_01.pdf")
par(mfrow=c(2,1))
barplot(s4b2$PEOPLE_POSITIVE_CASES_COUNT,names.arg=s4b2$ACTUAL_DATE,space=2, ylim=c(0,s4a),ylab=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County Positive Cases Count"),xlab=paste("Date"), main=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County Cases vs. time"))


#TITLE: BRAZOS COUNTY [SCALE] = 500 (Above script)

#STEP_05: Copy the code in steps a through d above into the body of a function. 
#Set up the function with three parameters. The first parameter will be a positional
#argument that will supply the name of the county to be plotted. The second will be
#a keyword parameter with the same name as the upper level scalar that you created 
#at the beginning of the previous step. The default value will be -1. The third 
#parameter will also be a keyword parameter that supplies the name of the
#data frame that is the source of data for the function. The default value will be 
#the name of your Texas COVID data frame. In the code copied from above, replace hard 
#coded values of Brazos with the name of your first parameter. Replace all references 
#to the Texas COVID data frame with the name of your third parameter. To make this 
#function fully flexible, we would need to supply additional parameters for the column 
#names. Otherwise, the structure of any data frame used by the function must be identical 
#to our Texas COVID data frame. Execute the function definition code then call the 
#function using Brazos and 500 as the first and second parameter values. The result 
#should be identical to the result of the previous step.

#if((class(cname)=="character"&&length(cname)==1)cat("Correct Input Format Received:",bquote(.(cname)),"County")
#	else cat("cname must be a character vector of unit length\n Only type in the name of the county, not followed by the word county")

s5<-function(cname, s4=-1, frame=MTEXAS){
	s4b1<-frame[(frame$COUNTY_NAME==cname),]
	s4a<-ifelse(s4<0,max(s4b1$PEOPLE_POSITIVE_CASES_COUNT[!is.na(s4b1$PEOPLE_POSITIVE_CASES_COUNT)]),s4)
	print(s4a)
	s4b2<-s4b1[(s4b1$PEOPLE_POSITIVE_CASES_COUNT>0),c(8,3)]
	s4b2<-s4b2[order(s4b2$ACTUAL_DATE),]
	barplot(s4b2$PEOPLE_POSITIVE_CASES_COUNT,names.arg=s4b2$ACTUAL_DATE,space=2, ylim=c(0,ceiling(1.2*s4a)),ylab=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County Positive Cases Count"),xlab=paste("Date"), main=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County Cases vs. time"))
}
s5(cname="Brazos")
# Do not need to specify 500 as the second argument. The function automatically assigns
#500 (max of the PPCC column), as the limit for the y-axis
graphics.off()


# I was not sure if Prof. K wanted the title "BRAZOS COUNTY [SCALE] = 500" in
#just the script (here) or on the actual plots in the output pdf. So, I am 
#writing code to produce two sets of results for each graphics output.
#The naming scheme for these will be output_01, output_1a; output_02,
#output_2a...etc. First ones will have the title I gave them, second ones 
#will have the title "County Name" County [Scale] = ylim. Hope that covers
#all bases.

pdf("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_06\\Final Files\\HW_06_Graphics_Output_1a.pdf")
par(mfrow=c(2,1))
barplot(s4b2$PEOPLE_POSITIVE_CASES_COUNT,names.arg=s4b2$ACTUAL_DATE,space=2, ylim=c(0,s4a),ylab=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County Positive Cases Count"),xlab=paste("Date"), main=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County [Scale]=",bquote(.(s4a))))
#Step_05 Extra: Hence object name s5e
s5e<-function(cname, s4=-1, frame=MTEXAS){
	s4b1<-frame[(frame$COUNTY_NAME==cname),]
	s4a<-ifelse(s4<0,max(s4b1$PEOPLE_POSITIVE_CASES_COUNT[!is.na(s4b1$PEOPLE_POSITIVE_CASES_COUNT)]),s4)
	print(s4a)
	s4b2<-s4b1[(s4b1$PEOPLE_POSITIVE_CASES_COUNT>0),c(8,3)]
	s4b2<-s4b2[order(s4b2$ACTUAL_DATE),]
	barplot(s4b2$PEOPLE_POSITIVE_CASES_COUNT,names.arg=s4b2$ACTUAL_DATE,space=2, ylim=c(0,ceiling(1.2*s4a)),ylab=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County Positive Cases Count"),xlab=paste("Date"), main=paste(bquote(.(s4b1$COUNTY_NAME[1])),"County [Scale]=",bquote(.(s4a))))
}
s5e(cname="Brazos")
# Do not need to specify 500 as the second argument. The function automatically assigns
#500 (max of the PPCC column), as the limit for the y-axis
graphics.off()



#STEP_06: Open the PDF destination file to receive your graphics output. 
#When you define your PDF document, use arguments to set the width to 11 
#inches and the height to 8.5 inches to match the size of a normal letter 
#size sheet of paper in landscape orientation.
pdf("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_06\\Final Files\\HW_06_Graphics_Output_02.pdf",paper="a4r")

#STEP_07: Call your function using Dallas as the only argument.
s5(cname="Dallas")

#STEP_08: Set up your graphics so that there will be two columns of graphics on 
#the output page. Set the overall margins of the graphics within the page to be 
#.5 inches on the top, 1.5 inches on the bottom to allow space for punched holes, 
#and 1 inch on the right and left. Set the margins of the individual graph to be 
#4 lines on top, 0 lines on the bottom and 2 lines on the right and left.
par(mfrow=c(1,2))
par(omi=c(1.5,1,0.5,1))
par(mar=c(0,2,4,2))

#STEP_09: Call your function twice. The first call will be for Brazos County where 
#Texas A&M is located. The second function call will be for McLennan County where 
#Baylor is located. Both calls will use an upper limit value of 500 so the graphs 
#will be on the same scale.
s5("Brazos");s5("McLennan",s4=480)

#STEP_10: Reset the graphics area back to 1 row by 1 column.
par(mfrow=c(1,1))

#STEP_11: Create an expression that will return a vector of county names from the May 
#28 data frame where the PEOPLE_POSITIVE_CASES_COUNT is not missing. Nest this expression 
#inside an assignment statement that will create vector containing a random sample of 
#10 of those counties. By using the seed value of 2020607 for our sample
s11<-s7FRAME$COUNTY_NAME[!is.na(s7FRAME$PEOPLE_POSITIVE_CASES_COUNT)]
s11	#Just here for validation
set.seed(2020607)
s11a<-sample(s11,10)

#STEP_12: Use a loop to cycle through the sample vector of county names and call the 
#function once for each county. Use a value of 2000 for the upper limit parameter. 
#Include in the loop a function that will write the system time in the outer margin 
#on the right side of each page. Top justify the value.

for(i in c(1:length(s11a))){
	s5(cname=s11a[i])
	mtext(date(),side=4,adj=1)
}


graphics.off()

# All the steps below are extra, for plots with modified titles
# These steps do the same thing as steps 06 through 12 above

#STEP_06: Open the PDF destination file to receive your graphics output. 
#When you define your PDF document, use arguments to set the width to 11 
#inches and the height to 8.5 inches to match the size of a normal letter 
#size sheet of paper in landscape orientation.
pdf("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_06\\Final Files\\HW_06_Graphics_Output_2a.pdf",paper="a4r")

#STEP_07: Call your function using Dallas as the only argument.
s5e(cname="Dallas")

#STEP_08: Set up your graphics so that there will be two columns of graphics on 
#the output page. Set the overall margins of the graphics within the page to be 
#.5 inches on the top, 1.5 inches on the bottom to allow space for punched holes, 
#and 1 inch on the right and left. Set the margins of the individual graph to be 
#4 lines on top, 0 lines on the bottom and 2 lines on the right and left.
par(mfrow=c(1,2))
par(omi=c(1.5,1,0.5,1))
par(mar=c(0,2,4,2))

#STEP_09: Call your function twice. The first call will be for Brazos County where 
#Texas A&M is located. The second function call will be for McLennan County where 
#Baylor is located. Both calls will use an upper limit value of 500 so the graphs 
#will be on the same scale.
s5e("Brazos");s5e("McLennan",s4=480)

#STEP_10: Reset the graphics area back to 1 row by 1 column.
par(mfrow=c(1,1))

#STEP_11: Create an expression that will return a vector of county names from the May 
#28 data frame where the PEOPLE_POSITIVE_CASES_COUNT is not missing. Nest this expression 
#inside an assignment statement that will create vector containing a random sample of 
#10 of those counties. By using the seed value of 2020607 for our sample
s11<-s7FRAME$COUNTY_NAME[!is.na(s7FRAME$PEOPLE_POSITIVE_CASES_COUNT)]
s11	#Just here for validation
set.seed(2020607)
s11a<-sample(s11,10)

#STEP_12: Use a loop to cycle through the sample vector of county names and call the 
#function once for each county. Use a value of 2000 for the upper limit parameter. 
#Include in the loop a function that will write the system time in the outer margin 
#on the right side of each page. Top justify the value.

for(i in c(1:length(s11a))){
	s5e(cname=s11a[i])
	mtext(date(),side=4,adj=1)
}


graphics.off()

# Above steps are extra, for plots with modified titles

#ADDITIONAL STEP: Not required for the HW, just here for reference
#This step gives the same output as step 12, but for all 230 counties
# that have reported cases. These outputs will be in graphic_output_03

pdf("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_06\\Final Files\\HW_06_Graphics_Output_03.pdf",paper="a4r")

for(i in c(1:length(s11))){
	s5(cname=s11[i])
	mtext(date(),side=4,adj=1)
}


graphics.off()

#ADDITIONAL Extra STEP: With Modified Titles

pdf("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_06\\Final Files\\HW_06_Graphics_Output_3a.pdf",paper="a4r")

for(i in c(1:length(s11))){
	s5e(cname=s11[i])
	mtext(date(),side=4,adj=1)
}


graphics.off()


#STEP_13:After you have finished writing and testing your code close R. Then reopen 
#R and run your script. Answer the questions below based on the graphics output 
#in your PDF file.

#STEP_13a: What scale value is in the title for Dallas County?
#Dallas County [Scale]= 9587

#STEP_13b: What is your assessment of how Brazos and McLennan counties did in 
#“flattening the curve”?
#McLennan county has been much more successful in "flattening" the cureve
#than Brazos county. 


#STEP_13c: Which county had the earliest first case? The latest? Supply the dates.
#Latest first case: 
#Earliest first case: Fort Bend County, on 03-04-2020
#Latest first case: Reagan County, on 05-27-2020.