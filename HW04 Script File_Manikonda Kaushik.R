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

#output is directed to a separate file while still appearing in the console.
#Includes the full path to show where the output file is being written.
#Not required for this HW, but I am doing it anyway for best practices.
#sink("C:/Users/Kaushik/Desktop/TAMU Semesters & Courses/Summer_2020/STAT_604/Assignments/HW_04/Final Files/HW04 Output File",split=TRUE)

#STEP_02: Loads the COVID-19 Activity.csv file into the R data.frame, "COVID" using read.csv function
COVID <- read.csv("C:/Users/Kaushik/Desktop/TAMU Semesters & Courses/Summer_2020/STAT_604/Assignments/HW_04/COVID-19 Activity.csv",header=TRUE,sep=",")
#The raw data had field names in the first line,hence header=TRUE

# Step_2a: Shows the structure of the new data frame
str(COVID)
#'data.frame':   419459 obs. of  13 variables:

# Non-essential step; Adding here just for my reference. Checks the names of all the columns in the data.frame, "COVID"
names(COVID)

# Step_2b: Renaming the first column to STATE_PROVINCE
names(COVID)[1]<-"STATE_PROVINCE"
names(COVID)
#This shows that the first column has been renamed successfully.

# Step_2c: Display the first 20 rows and all columns of the new data frame. 
#Clarification: It is not a new data.frame for me, I just renamed 
# the first column of the old one. I did not assign a new data.frame to the renamed old data.frame
COVID[(1:20),]

# Step_03_part_01: Create a new data frame that is a subset of the data frame created from the CSV file. 
#The subset will contain only rows for the state of Texas. 
TCOVID<-COVID[grep("Texas",COVID$STATE_PROVINCE,ignore.case=FALSE),]
str(TCOVID)

# Step_03_part_02: Use a negative subscript expression to remove the first six column and the eighth column 
#when creating the subset. Display in the console the structure of the new data frame.
TCOVID2<-COVID[grep("Texas",COVID$STATE_PROVINCE,ignore.case=FALSE),-c(1:6,8)]
DUMMYTCOVID2<-TCOVID[,-c(1:6,8)]
str(TCOVID2)		#Structure of the new data.frame with only Texas rows and 1:6,8th columns removed
str(DUMMYTCOVID2)		#This should match the structure of TCOVID2, just a different method of extraction. 
				#This is here just for reference

# Step_04: Write a line of code to load into R the texas workspace that you downloaded from eCampus for
# the previous programming assignment
load("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_04\\texas.RData")

# Step_4a: Show the contents of your workspace.
ls()

# Step_4b: Display the structure of the object loaded in the texas workspace.
str(Population)

# Step_4c: However, you will notice that the county name in
#one of the data frames ends with the word County. Remove the word County from all
#these values.
TCOVID2$COUNTY_NAME[1:30]
Population$CTYNAME[1:30]

#It ends with the word "County" in the data.frame "Population" imported from texas.RData
#Removing the word Country from the first column of the Population data.frame
Population$CTYNAME<- gsub(" County","",Population$CTYNAME)
class(Population$CTYNAME)

# Step_4d: Change the name of the first column to COUNTY_NAME to match the other data frame.
#Change the name of the second column to POPULATION
names(Population)[1]<-"COUNTY_NAME"
names(Population)[2]<-"POPULATION"
names(Population)	#To check if the changes have been made

# Step_4e: Display the structure again showing the modifications.
str(Population)
str(TCOVID2)	#For reference, not part of the HW

# Step_4f: Display the first 10 rows of the modified data frame.
Population[1:10,]

# Step_05: Create a new data frame by combining the last two “Texas” data frames that you have been
#working with in the previous steps. When you reference the data frame from Population in your
#expression to combine the data frames, do so in such a way that the GrowthRate column is not
#a part of the new data frame. Ensure that all counties from the Population data frame are
#included even if there was no COVID activity for that county in the other data frame.
MTEXAS<-merge(TCOVID2,Population[,-3],all=TRUE)
str(MTEXAS)

# Step_5a: Display a summary of the new data frame
summary(MTEXAS)

# Step_5b: Display the first 300 rows of the new data frame.
MTEXAS[1:300,]

# Step_06: Execute a function that will make the columns of the data frame available to R directly 
#by column name
attach(MTEXAS)

# Step_6a: Research the strptime function in the R documentation.
#Use this function to convert REPORT_DATE to an actual date value and assign it to a new
#column in the data frame. I name this new column, "ACTUAL_DATE"
MTEXAS$ACTUAL_DATE<-strptime(MTEXAS$REPORT_DATE,"%m/%d/%Y")
class(MTEXAS$ACTUAL_DATE);mode(MTEXAS$ACTUAL_DATE);str(MTEXAS$ACTUAL_DATE)	
#Not part of the HW, just here for reference and validation.

# Step_6b: Create four new columns in the data frame that represent each of the
#“COUNT” statistics as a percentage of the population of that county.
#I name the new columns "PPCC_PERCENT", "PDC_PERCENT", "PPNCC_PERCENT", "PDNC_PERCENT", 
#all short for their original names, "People_Positive_Cases_Count" .....etc.

#PPCC_PERCENT
MTEXAS$PPCC_PERCENT<-(PEOPLE_POSITIVE_CASES_COUNT/POPULATION)
summary(MTEXAS$PPCC_PERCENT)	#Just here for my reference, to see if everything worked properly.

#PDC_PERCENT
MTEXAS$PDC_PERCENT<-(PEOPLE_DEATH_COUNT/POPULATION)
summary(MTEXAS$PDC_PERCENT)	#Just here for my reference, to see if everything worked properly.

#PPNCC_PERCENT
MTEXAS$PPNCC_PERCENT<-(PEOPLE_POSITIVE_NEW_CASES_COUNT/POPULATION)
summary(MTEXAS$PPNCC_PERCENT)	#Just here for my reference, to see if everything worked properly.

#PDNC_PERCENT
MTEXAS$PDNC_PERCENT<-(PEOPLE_DEATH_NEW_COUNT/POPULATION)
summary(MTEXAS$PDNC_PERCENT)	#Just here for my reference, to see if everything worked properly.

# Step_6c: Display the structure of the updated data frame and its first 10 rows.
str(MTEXAS)
MTEXAS[1:10,]

# Step_6d: Execute a function so that the column names of the data frame are no longer available
#in the R search path
detach(MTEXAS)

# Step_07: Create a new data frame that is a subset of the data frame created in the previous step. Use a
#logical test to subset the rows to only those where the REPORT_DATE is 5/28/2020 or missing.
#Display the structure of the new data frame.

length(grep("TRUE",is.na(MTEXAS$REPORT_DATE)))	#is.na returns a vector of TRUE & FALSE, 
#grep searches to see if there are any TRUE values. length shows me how many rows have no Date reported.
#Above step is not required, just for my reference
 
s7a<-grep("TRUE",is.na(MTEXAS$REPORT_DATE))
str(s7a)
s7b<-grep("5/28/2020",MTEXAS$REPORT_DATE)
str(s7b)
s7FRAME<-MTEXAS[c(s7a,s7b),]
str(s7FRAME)
s7FRAME[220:235,]	#There will be a lot of NA entries shown in the str(s7FRAME). This step is just here to check
			# that not every entry in the whole data.frame is NA

# Step_08: Use the colSums function to display the statewide totals of each of the “COUNT” columns. Use
#the apply function to make the same calculation.

#colSums(MTEXAS[,3:6],na.rm=TRUE)	#Ignore these answers, I was confused first and did these, leaving them here for reference
#apply(MTEXAS[,3:6],2,sum,na.rm=TRUE)#Ignore these answers,I was confused first and did these, leaving them here for reference

colSums(s7FRAME[,3:6],na.rm=TRUE)		#This is the answer for step_08
apply(s7FRAME[,3:6],2,sum,na.rm=TRUE)	#This is the answer for step_08

# Step_09: Using the last data frame created, display a list of County names,
#PEOPLE_POSITIVE_CASES_COUNT, POPULATION, and percent of
#PEOPLE_POSITIVE_CASES_COUNT, listed from the highest percentage to the lowest.
s9<-s7FRAME[order(s7FRAME[,9],na.last=TRUE,decreasing=TRUE),c(1,3,7,9)]
s9[150:165,]	#Just here for verification purposes, displays rows from 150 to 165

# Step_10: Display all data for Counties whose names begin with the letter B.
s10a<-s7FRAME[grep("^B",s7FRAME$COUNTY_NAME,ignore.case=FALSE),]
s10a

# Step_11: Display the contents of the workspace
ls()

# Step_12: Remove everything from the workspace except the data frame created in step 5 above and the
#May 28 data frame.
rm(COVID,DUMMYTCOVID2,Population,s10a,s7a,s7b,s9,TCOVID,TCOVID2)
ls()

# Step_13: Save the workspace in case we want to use it in the next assignment. Name it HW04.RData.
 #save.image("C:\\Users\\Kaushik\\Desktop\\TAMU Semesters & Courses\\Summer_2020\\STAT_604\\Assignments\\HW_04\\Final Files\\HW_04_KM.RData")

# Closing the output file and stop sending output to it.
#sink()

# Step_14: Questions

#14a: How many continents are in the data loaded from the CSV file?
#5, code used to get the answer is below
#s14a<-as.factor(COVID$CONTINENT_NAME)
#levels(s14a)
#[1] "Africa"  "America" "Asia"    "Europe"  "Oceania"

#14b: How many observations and variables are in the Texas subset created in step 3?
#str(TCOVID)
#'data.frame':   29670 obs. of  13 variables:

#14c: What is one possible explanation for the minimum value of
#PEOPLE_POSITIVE_NEW_CASES_COUNT shown in the summary from step 5a and what
#is your reaction to this value as an analyst?
# Min.   :-122.000; Could be a problem with reading the NA entries for some of the counties;
#My reaction would be to find a way to ignore these NA values, or to read them as zero

#14d: What is the total number of COVID cases and deaths in the state of Texas as of May 28?
#sum(s7FRAME[,3],na.rm=TRUE)
#[1] 60768
#sum(s7FRAME[,4],na.rm=TRUE)
#[1] 1618


#14e: What is the name and population of the largest county in the top 10 counties with the
#highest percentage of cases as of May 28?
#Potter, with 119,648

#20048       Moore      21485                         565  0.026297417
#22287      Potter     119648                        2276  0.019022466
#15259       Jones      19817                         323  0.016299137
#25959       Titus      33033                         443  0.013410832
#27244      Walker      72480                         869  0.011989514
#6984   Deaf Smith      18760                         161  0.008582090
#7749       Donley       3319                          26  0.007833685
#21670      Panola      23148                         174  0.007516848
#24925     Sherman       3079                          23  0.007469958
#24836      Shelby      25418                         189  0.007435676


#14f: What is the name and population of the largest county with no COVID cases reported?
#Somervell, with 9,016

#1420         Baylor       3582                          NA           NA
#1937         Borden        648                          NA           NA
#6453       Crockett       3499                          NA           NA
#6583      Culberson       2204                          NA           NA
#8261        Edwards       1928                          NA           NA
#9294          Foard       1200                          NA           NA
#14326         Irion       1522                          NA           NA
#14714    Jeff Davis       2252                          NA           NA
#15747        Kenedy        442                          NA           NA
#15748          Kent        726                          NA           NA
#16007          King        277                          NA           NA
#16008        Kinney       3767                          NA           NA
#17815        Loving        152                          NA           NA
#19106      McMullen        749                          NA           NA
#19236        Menard       2139                          NA           NA
#22849          Real       3478                          NA           NA
#24527    Schleicher       2895                          NA           NA
#25173     Somervell       9016                          NA           NA
#25432      Sterling       1311                          NA           NA
#25433     Stonewall       1362                          NA           NA
#25434        Sutton       3758                          NA           NA
#25822       Terrell        823                          NA           NA
#25952  Throckmorton       1515                          NA           NA
#26727         Upton       3671                          NA           NA
