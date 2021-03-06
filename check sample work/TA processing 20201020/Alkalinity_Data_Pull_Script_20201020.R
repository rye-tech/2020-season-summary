#updated info---------------------------

# renewed this script on Feb 24th 2020 to read data from .csv files provided by the titration software
# older versions of this script will have different pointer variables


#set work environment ------------------------------------------------------

# use at your peril....
# rm(list=ls())

library(dplyr)
library(stringr)
library(here)


setwd(here())

getwd()

setwd(here("check sample work", "TA processing 20201020"))


getwd()

#use at your own peril....

#rm(list=ls())


list.files()

#   sample information file
# "alkalinity run 10122020 samples only.csv"
# "alkalinity run 10132020 samples only.xlsx"

#   sample environmental data
# "20201012 sample metadata.csv" 
# "20201013 sample metadata.csv"

# alkalinity titration data files
# "alkalinity run 10122020 data only.csv"       
# "alkalinity run 10122020 part 1 data only.csv"
# "alkalinity run 10132020 data only.csv"


# read in sample summary information ####-----------------------------------------------------

#NEED TO UPDATE HOW TO BRING THIS DATA IN
# WOULD BE BETTER TO GET .CSV FROM LABX THEN LESS ALTERING WOULD NEED TO HAPPEN
# FOR THIS PARTICULAR VERSION I DOWNLOADED A .XLSX AND THEN SAVED AS .CSV IN EXCEL

df_sum = read.csv("alkalinity run 10122020 samples only.csv",
                  header=T, skip = 14, stringsAsFactors=F, sep=",")

# used before finding option skip above
#df_sum_rm_rows <- 1:9
#df_sum <- df_sum[-df_sum_rm_rows,]


df_sum <- select(df_sum,  Sample.ID,
                Result)


df_sum <- df_sum %>% 
  filter(Sample.ID != '') 


df_sum$Result <- str_remove(df_sum$Result, "g")

df_sum <- df_sum %>%                     
  rename(sample = 'Sample.ID', 
         weight ='Result')


df_sum$weight <- as.numeric(df_sum$weight) 

#read in environmental and electrode data ------------------------------------------------


df_env = read.csv("20201012 sample metadata.csv",
                  header=T, stringsAsFactors=F, sep=",")

df_env <- df_env %>%                     
  rename(S = 'salinity', 
         weight ='sample.mass')


# read in sample data ####-------------------------------------------------------------------

# "alkalinity run 10122020 data only.csv"       
# "alkalinity run 10122020 part 1 data only.csv"

df1 = read.csv("alkalinity run 10122020 part 1 data only.csv",
               header=F, stringsAsFactors=F, sep=",")

df1 <- select(df1,  
              V6,
              V12,
              V20)


df1 <- df1 %>%                     
  rename(V1 = 'V6', 
         V2 ='V12',
         V3 = 'V20')



df2 = read.csv("alkalinity run 10122020 data only.csv",
              header=F, stringsAsFactors=F, sep=",")


df2 <- select(df2,  
              V5,
              V11,
              V18)

df2 <- df2 %>%                     
  rename(V1 = 'V5', 
         V2 = 'V11',
         V3 = 'V18')


df <- bind_rows(df1, df2, .id = NULL)

rm(df1,df2)

# below selects variables of interest
# if throws error "unused arguments" restart R session with ctrl + Shift + F10, and reload library(dplyr)

# df1 <- select(df1,  V6,
#                   V12,
#                   V20)


#pulled this nifty fix to remove empty cells from each row. 
#removes one value of temperature in first titrations but doesn't matter
# https://markhneedham.com/blog/2015/06/02/r-dplyr-removing-empty-rows/

df <- df %>%
  filter(V1 != '') %>%
  filter(V2 != '') %>%
  filter(V3 != '')


df <- df %>%
  rename(volume = 'V1',
         E ='V2',
         temperature = 'V3')


#point to each titration
titration_list <- df[c(df$volume == "V"),]

#get pointers in list
titration_indices <-  rownames(titration_list)

#get pointers to units of measure from data
drop_units_list <- as.numeric(titration_indices) + 1

#drop units of measure from data
df <- df[-drop_units_list,]

rownames(df) <- NULL

#point to each titration
titration_list <- df[c(df$volume == "V"),]

#get pointers in list
titration_indices <-  rownames(titration_list)


#get last pointer
#last(df$V3)

# pulls the last name of the last row
#rownames(tail(df,1))


#add last pointer to titration indices
titration_indices <- c(titration_indices, rownames(tail(df,1)))


#print(titration_indices)


#get length of sequence for loop
len_loop <- length(titration_indices)

len_alt_loop <- seq(2, length(titration_indices), by = 2)

#get sample names as list and paired

sample_list <- df_sum$sample

sample_list <- c(rep(sample_list, each = 2))

sample_list2 <- sample_list

each_titration <- c("titration1", "titration2")

sample_list <- paste(sample_list,each_titration, sep = "-")


#list1 = ls()


#print(sample_list)
#print(sample_list[1])
#[1] "ALKCRM1"




#test of functionality to pull data
# 
# titration_data <-  slice(df, titration_indices[1]:titration_indices[2])
# 
# titration_data <- slice(titration_data, 1:(n()-1)) #removes last row
# 
# assign(sample_list[1], titration_data)

#env_data <- filter(df_env, sample.id == regex(sample_list2[1], ignore_case = T))
#env_data <- filter(df_env, sample.id == sample_list2[3])

#print(sample_list2[1])
#print(sample_list2)



#loop to pull data --------------------------------------------------------------
# IGNORE WARNING AFTER RUNNING

for (i in 1:len_loop) {
  
  titration_data <-  slice(df, titration_indices[i]:titration_indices[i+1])
  titration_data <- titration_data[-1,] #removes unwanted header row that was needed to point the slice step above
  titration_data <- slice(titration_data, 1:(n()-1)) #removes last unwanted row
  titration_data$E <- as.numeric(titration_data$E)
  titration_data$volume <- as.numeric(titration_data$volume)
  titration_data$temperature <- as.numeric(titration_data$temperature)
  titration_data <- mutate(titration_data, sample.id = sample_list2[i])
  assign(sample_list[i], titration_data)

}


#loop to add volume values from first titration to second titration ----

#point to object in R
# print(sample_list[2])
# titration_data <- get(sample_list[2])


for (i in len_alt_loop) {
  
  titration_data <- get(sample_list[i])
  titration1_volume <- get(sample_list[i-1])
  titration1_volume <- as.numeric(max(titration1_volume$volume))
  titration_data <- mutate(titration_data, volume = volume + titration1_volume)
  assign(sample_list[i], titration_data)
  
}




#loop to add metadata -------------------

for (i in len_alt_loop) {
  
  titration_data <- get(sample_list[i])
  titration_data <- left_join(titration_data, df_env, by = "sample.id")
  assign(sample_list[i], titration_data)
  
}



#loop to sort to gran titration pH bounds ----------------------------

for (i in len_alt_loop) {
  
  titration_data <- get(sample_list[i])
  mV_lwr_bound <- titration_data$EHigh
  mV_upr_bound <- titration_data$ELow
  titration_data <- filter(titration_data, E >= mV_lwr_bound & E <= mV_upr_bound)
  assign(sample_list2[i], titration_data)
  
}


#removes everything except for wanted data
rm(list=setdiff(ls(), sample_list2))


#save all data frames in global environment as csv files
#pulled code from: https://stackoverflow.com/questions/48707198/write-data-frames-in-environment-into-separate-csv-files

files <- mget(ls())

for (i in 1:length(files)){
  write.csv(files[[i]], paste(names(files[i]), ".csv", sep = ""), row.names = F)
}








