#load libraries #############################

library(dplyr)
library(lubridate)
library(here)


##### set working directory ###############################

setwd(here())

getwd()

rm(list =ls())


# data file names

# load("data/eos-pier/EOS_YSI_20191120-20201219.RData")
# 
# load("data/cma-pier/CMA_YSI_20191108-20201219.RData")
# 
# load("data/eos-met/EOS_MET_20191120-20201219.RData")









##### BOB no 2020 data due to COVID-19 crisis  #####################################


# #comment out starts here
#
# 
# #load tidied data
# load("data/bob/ctd/bob.ctd.2019.RData")
# data1 <- data
# rm(data)
# 
# data1$date <- date(data1$datetime)
# 
# data1 <- filter(data1, date> "2019-05-31")
# 
# #load tidied data
# load("data/bob/seafet/bob.seafet.2019.RData")
# data2 <- data
# rm(data)
# 
# data2$date <- date(data2$datetime)
# 
# data2 <- filter(data2, date> "2019-05-31")
# 
# 
# date_start <- date("2019-06-01")
# 
# date_end <- date("2019-10-24")
# 
# date_end - date_start
# 
# buoy_season_days <- difftime(date_end, date_start, units = "days")
# 
# print(buoy_season_days)
# 
# #samples per day
# seconds_per_day <- 60*60*24
# sampling_freq1 <- 360 #seconds
# sampling_freq2 <- 360 #seconds
# sample_per_day <- seconds_per_day/sampling_freq
# 
# threshold <- 0.75*sample_per_day
# 
# days_sampling <- length(data$sst)/sample_per_day
# 
# 
# #for search and replacing
# #colnames(data)
# # [1] "sst"      "sss"      "ph"       "chl"      "trb"      "o2"       "date"     "mon"      "day"  
# # [10] "year"     "datetime"
# 
# 
# # temperature counts of uptimes
# 
# sst_samples <- data1 %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# sst_sample_count <- length(sst_samples$count)
# 
# uptime_sst <- data1 %>%
#   filter(sst > 0, sst <30) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_sst_count <- length(uptime_sst$count)
# 
# uptime_sst_percent <- uptime_sst_count/sst_sample_count
# 
# 
# 
# #salinity counts of uptimes
# 
# sss_samples <- data1 %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# sss_sample_count <- length(sss_samples$count)
# 
# uptime_sss <- data1 %>%
#   filter(sss > 0, sss <35) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_sss_count <- length(uptime_sss$count)
# 
# uptime_sss_percent <- uptime_sss_count/sss_sample_count
# 
# 
# #ph counts of uptimes
# 
# ph_samples <- data2 %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# ph_sample_count <- length(ph_samples$count)
# 
# uptime_ph <- data2 %>%
#   filter(pH > 7.0, pH <8.5) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_ph_count <- length(uptime_ph$count)
# 
# uptime_ph_percent <- uptime_ph_count/ph_sample_count
# 
# 
# #chl counts of uptimes
# 
# chl_samples <- data1 %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# chl_sample_count <- length(chl_samples$count)
# 
# uptime_chl <- data1 %>%
#   filter(chla > 0, chla <30) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_chl_count <- length(uptime_chl$count)
# 
# uptime_chl_percent <- uptime_chl_count/chl_sample_count
# 
# #turbidity counts of uptimes
# 
# trb_samples <- data1 %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# trb_sample_count <- length(trb_samples$count)
# 
# uptime_trb <- data1 %>%
#   filter(turb > 0, turb <200) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_trb_count <- length(uptime_trb$count)
# 
# uptime_trb_percent <- uptime_trb_count/trb_sample_count
# 
# #o2 counts of uptimes
# 
# o2_samples <- data1 %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# o2_sample_count <- length(o2_samples$count)
# 
# uptime_o2 <- data1 %>%
#   filter(o2 > 4, o2 <11) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_o2_count <- length(uptime_o2$count)
# 
# uptime_o2_percent <- uptime_o2_count/o2_sample_count
# 
# 
# #for search and replacing
# #colnames(data)
# # [1] "sst"      "sss"      "ph"       "chl"      "trb"      "o2"       "date"     "mon"      "day"  
# # [10] "year"     "datetime"
# 
# 
# 
# 
# 
# 
# 
# 
#  #comment out ends here

# EOS Pier 16-may-2020 to 01-dec-2020 uptime counts #############################

rm(list = ls())

load("data/eos-pier/EOS_YSI_20191120-20201219.RData")

# for first 6 months of data
#load("data/eos-pier/EOS_YSI_20191201-20200515.RData")

df1 <- eos_pier_2020
rm(eos_pier_2020)

str(df1)

df1 <- df1 %>%                     
  rename(o2 = 'o2_mg_l',
         trb = "Turb"
         )

str(df1)

summary(df1)




df1 <- df1 %>%
  mutate(day = day(datetime),
         date = date(datetime))

# for first 6 months of year analysis
# 
# df1 <- df1 %>%
#   filter(date >= as.POSIXct("2019-12-01")) 


df1 <- df1 %>%
  filter(date >= as.POSIXct("2020-05-16")) 


df1 <- df1 %>%
  filter(date <= as.POSIXct("2020-12-01")) 


report_interval <- interval(ymd("2020-05-16"), ymd("2020-12-01")) 

report_interval <- as.duration(report_interval)

report_interval <- floor(as.numeric(report_interval, "days"))



#calculating samples per day with 6 min sampling freq
seconds_per_day <- 60*60*24
sampling_freq <- 360 #seconds
sample_per_day <- seconds_per_day/sampling_freq

threshold <- 0.75*sample_per_day

days_sampling <- length(df1$sst)/sample_per_day


# temperature counts of uptimes

sst_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

sst_sample_count <- length(sst_samples$count)

uptime_sst <- df1 %>%
  filter(sst > 0, sst <30) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_sst_count <- length(uptime_sst$count)

uptime_sst_percent <- (uptime_sst_count/sst_sample_count) * 100

uptime_sst_percent <- round(uptime_sst_percent, digits = 1)

uptime_table <- list()

uptime_table$eos_pier_temp <- paste0(uptime_sst_count,"/",sst_sample_count,"(",uptime_sst_percent,")")

#salinity counts of uptimes

sss_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

sss_sample_count <- length(sss_samples$count)

uptime_sss <- df1 %>%
  filter(sss > 0, sss <35) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_sss_count <- length(uptime_sss$count)

uptime_sss_percent <- (uptime_sss_count/sss_sample_count) * 100

uptime_sss_percent <- round(uptime_sss_percent, digits = 1)

uptime_table$eos_pier_sal <- paste0(uptime_sss_count,"/",sss_sample_count,"(",uptime_sss_percent,")")


#ph counts of uptimes

ph_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

ph_sample_count <- length(ph_samples$count)

uptime_ph <- df1 %>%
  filter(pH > 7.0, pH <8.5) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_ph_count <- length(uptime_ph$count)

uptime_ph_percent <- uptime_ph_count/ph_sample_count


#chl counts of uptimes

chl_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

chl_sample_count <- length(chl_samples$count)

uptime_chl <- df1 %>%
  filter(chl_ugl > -5, chl_ugl <30) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_chl_count <- length(uptime_chl$count)

uptime_chl_percent <- uptime_chl_count/chl_sample_count

#turbidity counts of uptimes

trb_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

trb_sample_count <- length(trb_samples$count)

uptime_trb <- df1 %>%
  filter(trb > 0, trb <200) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_trb_count <- length(uptime_trb$count)

uptime_trb_percent <- uptime_trb_count/trb_sample_count

#o2 counts of uptimes

o2_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

o2_sample_count <- length(o2_samples$count)

uptime_o2 <- df1 %>%
  filter(o2 > 4, o2 <11) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_o2_count <- length(uptime_o2$count)

uptime_o2_percent <- uptime_o2_count/o2_sample_count


# depth counts of uptimes

depth_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

depth_sample_count <- length(depth_samples$count)

uptime_depth <- df1 %>%
  filter(Depth > 0, Depth <5) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_depth_count <- length(uptime_depth$count)

uptime_depth_percent <- uptime_depth_count/depth_sample_count




# EOS MET 16-may-2020 01-dec-2020 uptime counts #############################

rm(list =ls())

load("data/eos-met/EOS_MET_20191120-20201219.RData")

# for first 6 months of year
#load("data/eos-met/EOS_MET_20191201-20200515.RData")

df1 <- eos_met_2020
rm(eos_met_2020)

df1 <- df1 %>%
  mutate(day = day(datetime),
         date = date(datetime))



# for first 6 months of year analysis
# 
# df1 <- df1 %>%
#   filter(date >= as.POSIXct("2019-12-01")) 


df1 <- df1 %>%
  filter(date >= as.POSIXct("2020-05-16")) 


df1 <- df1 %>%
  filter(date <= as.POSIXct("2020-12-01")) 


report_interval <- interval(ymd("2020-05-16"), ymd("2020-12-01")) 

report_interval <- as.duration(report_interval)

report_interval <- floor(as.numeric(report_interval, "days"))


#samples per day
seconds_per_day <- 60*60*24
sampling_freq <- 360 #seconds
sample_per_day <- seconds_per_day/sampling_freq

threshold <- 0.75*sample_per_day

days_sampling <- length(df1$AirTC)/sample_per_day


#for search and replacing
# colnames(data)
# [1] "datetime"  "TIMESTAMP" "RECORD"    "BattV"     "AirTC"     "RH"        "BP_mmHg"   "WS_ms"    
# [9] "WindDir"   "PAR_Den"   "PAR_Tot"   "SlrkW"     "SlrMJ"     "Rain_mm"   "day"       "date"  


# temperature counts of uptimes

airtemp_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

airtemp_sample_count <- length(airtemp_samples$count)

uptime_airtemp <- df1 %>%
  filter(AirTC > 4, AirTC < 40) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_airtemp_count <- length(uptime_airtemp$count)

uptime_airtemp_percent <- uptime_airtemp_count/airtemp_sample_count


# relative humidity counts of uptimes

rh_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

rh_sample_count <- length(rh_samples$count)

uptime_rh <- df1 %>%
  filter(RH >= 0, RH <= 100) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_rh_count <- length(uptime_rh$count)

uptime_rh_percent <- uptime_rh_count/rh_sample_count


# PAR counts of uptimes

par_dens_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

par_dens_sample_count <- length(par_dens_samples$count)

uptime_par_dens <- df1 %>%
  filter(PAR_Den >= 0, PAR_Den <= 3000) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_par_dens_count <- length(uptime_par_dens$count)

uptime_par_dens_percent <- uptime_par_dens_count/par_dens_sample_count



# rain counts of uptimes

rain_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

rain_sample_count <- length(rain_samples$count)

uptime_rain <- df1 %>%
  filter(Rain_mm >= 0, Rain_mm <= 5) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_rain_count <- length(uptime_rain$count)

uptime_rain_percent <- uptime_rain_count/rain_sample_count


# wind counts of uptimes

ws_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

ws_sample_count <- length(ws_samples$count)

uptime_ws <- df1 %>%
  filter(WS_ms >= 0, WS_ms <= 30) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_ws_count <- length(uptime_ws$count)

uptime_ws_percent <- uptime_ws_count/ws_sample_count



# barometric pressure counts of uptimes

bp_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

bp_sample_count <- length(bp_samples$count)

uptime_bp <- df1 %>%
  filter(BP_mmHg >= 700, BP_mmHg <= 800) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_bp_count <- length(uptime_bp$count)

uptime_bp_percent <- uptime_bp_count/bp_sample_count






#for search and replacing
# sst
# colnames(data)
# [1] "datetime"   "record"     "batt"       "airtemp"    "rh"         "bp"         "ws"         "wdir"       "par_dens"  # [10] "par_tot"    "sol_irr_kw" "sol_irr_mj" "rain"









# NO 2020 MARI data ############################################################


# # commenting out starts here 
# 
# 
# # load tidied data
# 
# rm(list=ls())
# 
# load("data/mari/mari.2019.RData")
# 
# data$date <- date(data$datetime)
# 
# data <- filter(data, date> "2019-05-31")
# 
# 
# #samples per day
# seconds_per_day <- 60*60*24
# sampling_freq <- 1200 #seconds
# sample_per_day <- seconds_per_day/sampling_freq
# 
# threshold <- 0.75*sample_per_day
# 
# days_sampling <- length(data$sst)/sample_per_day
# 
# 
# #for search and replacing
# # colnames(data)
# # [1] "date"     "time"     "sst"      "sss"      "dep"      "ph"       "chl"      "trb"      "o2"  
# # [10] "datetime"
# 
# 
# # temperature counts of uptimes
# 
# sst_samples <- data %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# sst_sample_count <- length(sst_samples$count)
# 
# uptime_sst <- data %>%
#   filter(sst > 0, sst <30) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_sst_count <- length(uptime_sst$count)
# 
# uptime_sst_percent <- uptime_sst_count/sst_sample_count
# 
# 
# 
# #salinity counts of uptimes
# 
# sss_samples <- data %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# sss_sample_count <- length(sss_samples$count)
# 
# uptime_sss <- data %>%
#   filter(sss > 0, sss <35) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_sss_count <- length(uptime_sss$count)
# 
# uptime_sss_percent <- uptime_sss_count/sss_sample_count
# 
# 
# #ph counts of uptimes
# 
# ph_samples <- data %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# ph_sample_count <- length(ph_samples$count)
# 
# uptime_ph <- data %>%
#   filter(pH > 7.0, pH <8.5) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_ph_count <- length(uptime_ph$count)
# 
# uptime_ph_percent <- uptime_ph_count/ph_sample_count
# 
# 
# 
# #o2 counts of uptimes
# 
# o2_samples <- data %>%
#   group_by(date) %>% 
#   summarize(count=n())
# 
# o2_sample_count <- length(o2_samples$count)
# 
# uptime_o2 <- data %>%
#   filter(o2 > 4, o2 <11) %>%
#   group_by(date) %>% 
#   summarize(count=n()) %>%
#   filter(count > threshold)
# 
# uptime_o2_count <- length(uptime_o2$count)
# 
# uptime_o2_percent <- uptime_o2_count/o2_sample_count
# 
# 
# 
# uptime_all <- 128/145
# 
# 
# #for search and replacing
# # colnames(data)
# # [1] "date"     "time"     "sst"      "sss"      "dep"      "ph"       "chl"      "trb"      "o2"  
# # [10] "datetime"
# 
# 
# 
# # commenting out ends here




# CMA Pier 15-may-2020 to 01-dec-2020 to uptime counts #############################

rm(list = ls())

load("data/cma-pier/CMA_YSI_20191108-20201219.RData")

# for first 6 months of year
#load("data/cma-pier/CMA_YSI_20191201-20200515.RData")

df1 <- cma_2020
rm(cma_2020)

str(df1)

df1 <- df1 %>%                     
  rename(o2 = 'o2_mg_l',
         trb = "Turb"
  )

str(df1)

summary(df1)




df1 <- df1 %>%
  mutate(day = day(datetime),
         date = date(datetime))


# for first 6 months of year analysis
# 
# df1 <- df1 %>%
#   filter(date >= as.POSIXct("2019-12-01")) 


df1 <- df1 %>%
  filter(date >= as.POSIXct("2020-05-16")) 


df1 <- df1 %>%
  filter(date <= as.POSIXct("2020-12-01")) 


report_interval <- interval(ymd("2020-05-16"), ymd("2020-12-01")) 

report_interval <- as.duration(report_interval)

report_interval <- floor(as.numeric(report_interval, "days"))






#calculating samples per day with 6 min sampling freq
seconds_per_day <- 60*60*24
sampling_freq <- 360 #seconds
sample_per_day <- seconds_per_day/sampling_freq

threshold <- 0.75*sample_per_day

days_sampling <- length(df1$sst)/sample_per_day


# temperature counts of uptimes

sst_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

sst_sample_count <- length(sst_samples$count)

uptime_sst <- df1 %>%
  filter(sst > 0, sst <30) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_sst_count <- length(uptime_sst$count)

uptime_sst_percent <- (uptime_sst_count/sst_sample_count) * 100

uptime_sst_percent <- round(uptime_sst_percent, digits = 1)

uptime_table <- list()

uptime_table$cma_pier_temp <- paste0(uptime_sst_count,"/",sst_sample_count,"(",uptime_sst_percent,")")

#salinity counts of uptimes

sss_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

sss_sample_count <- length(sss_samples$count)

uptime_sss <- df1 %>%
  filter(sss > 0, sss <35) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_sss_count <- length(uptime_sss$count)

uptime_sss_percent <- (uptime_sss_count/sss_sample_count) * 100

uptime_sss_percent <- round(uptime_sss_percent, digits = 1)

uptime_table$cma_pier_sal <- paste0(uptime_sss_count,"/",sss_sample_count,"(",uptime_sss_percent,")")


#ph counts of uptimes

ph_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

ph_sample_count <- length(ph_samples$count)

uptime_ph <- df1 %>%
  filter(pH > 7.0, pH <8.5) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_ph_count <- length(uptime_ph$count)

uptime_ph_percent <- uptime_ph_count/ph_sample_count


#chl counts of uptimes

chl_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

chl_sample_count <- length(chl_samples$count)

uptime_chl <- df1 %>%
  filter(chl_ugl > -5, chl_ugl <30) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_chl_count <- length(uptime_chl$count)

uptime_chl_percent <- uptime_chl_count/chl_sample_count

#turbidity counts of uptimes

trb_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

trb_sample_count <- length(trb_samples$count)

uptime_trb <- df1 %>%
  filter(trb > 0, trb <200) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_trb_count <- length(uptime_trb$count)

uptime_trb_percent <- uptime_trb_count/trb_sample_count

#o2 counts of uptimes

o2_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

o2_sample_count <- length(o2_samples$count)

uptime_o2 <- df1 %>%
  filter(o2 > 4, o2 <11) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_o2_count <- length(uptime_o2$count)

uptime_o2_percent <- uptime_o2_count/o2_sample_count


# depth counts of uptimes

depth_samples <- df1 %>%
  group_by(date) %>% 
  summarize(count=n())

depth_sample_count <- length(depth_samples$count)

uptime_depth <- df1 %>%
  filter(Depth > 0, Depth <5) %>%
  group_by(date) %>% 
  summarize(count=n()) %>%
  filter(count > threshold)

uptime_depth_count <- length(uptime_depth$count)

uptime_depth_percent <- uptime_depth_count/depth_sample_count


