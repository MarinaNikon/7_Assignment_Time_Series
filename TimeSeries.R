#Time Series Assignment using R
#Marina Nikon

#BACKGROUND: 
  
#The data contains monthly sales (in million USD) of a leading processed
#food manufacturer in USA. Data for 3 business units, from February 2015
#to January 2018, is provided in the same file. 

#Columns – Year, Month, BU1, BU2, BU3
#Number of observations – 35 for each business unit

#Install the packages if required and call for the corresponding library
install.packages("tseries")  
install.packages("urca")
install.packages("forecast")
library(dplyr)
library(tseries)
library(urca)
library(forecast)
        

#QUESTIONS
# 1. Import ‘USA Firm Sales’ data in R

# Load the data
salesData<-read.csv("USA_FIRM_SALES_DATA.csv", header = TRUE)

head(salesData) # View first 6 rows
dim(salesData) # Check the dimension of the dataset
summary(salesData) #Summarizing data and checking for missing values
str(salesData) # Check the structure of the dataset
anyNA(salesData) # Check for missing values
class(salesData)
#salesData <- na.omit(salesData)

#Observations:
#There are no missing values


# 2. Create time series objects of the data.

#Check if the data is sorted by Year and Month
is_sorted <- identical(salesData, salesData %>% arrange(Year, match(Month, month.name)))

print(is_sorted) #TRUE if sorted, FALSE otherwise

#Check the start date for BU1
start(ts_BU1)

#Convert to time series BU1
ts_BU1 <- ts(salesData$BU1, start = c(2015,2), frequency = 12)
head(ts_BU1) # View first 6 rows
summary(ts_BU1) #Summarizing data

#Plot to visualize the time series BU1
plot(ts_BU1, main = "BU1 Sales Time Series", 
     ylab="Sales (Million USD)", xlab="Year", col="blue")


#Check the start date for BU2
start(ts_BU2)

#Convert to time series BU2
ts_BU2 <- ts(salesData$BU2, start = c(2015,2), frequency = 12)
head(ts_BU2) # View first 6 rows
summary(ts_BU2) #Summarizing data

#Plot to visualize the time series BU2
plot(ts_BU2, main = "BU2 Sales Time Series", 
     ylab="Sales (Million USD)", xlab="Year", col="green")

#Check the start date for BU3
start(ts_BU3)

#Convert to time series BU3
ts_BU3 <- ts(salesData$BU3, start = c(2015,2), frequency = 12)
head(ts_BU3) # View first 6 rows
summary(ts_BU3) #Summarizing data

#Plot to visualize the time series BU3
plot(ts_BU3, main = "BU3 Sales Time Series", 
     ylab="Sales (Million USD)", xlab="Year", col="orange")


#All three time series in one plot
ts.plot(ts_BU1, ts_BU2, ts_BU3, 
        col=c("blue", "orange", "green"), lty=1, 
        main="Sales Time Series for BU1, BU2, BU3",
        ylab="Sales (Million USD)", xlab="Year")
legend("topright", legend=c("BU1", "BU2", "BU3"), col=c("blue", "orange", "green"), lty=1)
#Observations:
#The sales for BU1 show a slight up and downwards trend, indicating growth
#over time. Whereas BU3 appears to be relatively stable.
#It could be suggested that BU1 and BU2 shows seasonal fluctuations, with  peaks at
#the beginning of the year for BU1 and in mid-year for BU2. 
#BU3 shows more stable sales pattern with fewer unexpected changes.
#All three are clearly non-stationary time series


# 3. Check for stationarity for each of the three series.

#Correlogram to check the stationarity visually / Graphical approach
acf(ts_BU1, col="blue")
#Observations:
#The plot BU1 shows decay indicating non-stationary.

#Dickey Fuller Test / Analytical approach
df1 <- ur.df(ts_BU1, lag=0) 
summary(df1) 
#Observations:
#The value of test-statistic is: 1.683, which is greater
#then 5% critical value. Hence, time series is non-stationary.


#Correlogram to check the stationarity visually / Graphical approach
acf(ts_BU2, col="orange")
#Observations:
#The plot BU2 shows decay indicating non-stationary.

#Dickey Fuller Test / Analytical approach
df2 <- ur.df(ts_BU2, lag=0) 
summary(df2) 
#Observations:
#The value of test-statistic is: 5.2948, which is greater
#then 5% critical value. Hence, time series is non-stationary.


#Correlogram to check the stationarity visually / Graphical approach
acf(ts_BU3, col="green")
#Observations:
#The plot BU3 shows decay indicating non-stationary.

#Dickey Fuller Test / Analytical approach
df3 <- ur.df(ts_BU3, lag=0) 
summary(df3) 
#Observations:
#The value of test-statistic is: 8.4861, which is greater
#then 5% critical value. Hence, time series is non-stationary.


#How many times time series should be differenced to achieve stationarity?
ndiffs(ts_BU1)
ndiffs(ts_BU2)
ndiffs(ts_BU3)
#Observations:
#All three time series should be differenced 1 time to achieve stationarity.


#Dickey Fuller Test for 1st order differenced time series
BU1diff1<-diff(ts_BU1, differences = 1)
summary(ur.df(BU1diff1, lag=0))
#Observations:
#The value of test-statistic is: -2.9629, which is less
#then 5% critical value. Hence, time series BU1 is stationary.


#Dickey Fuller Test for 1st order differenced time series
BU2diff1<-diff(ts_BU2, differences = 1)
summary(ur.df(BU2diff1, lag=0))
#Observations:
#The value of test-statistic is: -2.578, which is less
#then 5% critical value. Hence, time series BU2 is stationary.


#Dickey Fuller Test for 1st order differenced time series
BU3diff1<-diff(ts_BU3, differences = 1)
summary(ur.df(BU3diff1, lag=0))
#Observations:
#The value of test-statistic is: -1.6151, which is more
#then 5% critical value. Hence, time series BU3 is non-stationary.


#Showing all graphs in one panel
par(mfrow=c(3,2))
plot(BU1diff1, col="blue")
acf(BU1diff1, col="blue")
plot(BU2diff1, col="orange")
acf(BU2diff1, col="orange")
plot(BU3diff1, col="green")
acf(BU3diff1, col="green")
#Observations:
#It was observed that all three time series should be differenced 1 time to 
#achieve stationarity. But it could be seen that after Dickey Fuller 
#Test the time series for BU3 are non-stationary. Correlogram and plot also 
#show stationary for all three time series. Dickey Fuller Test for 
#2nd order differenced time series for BU3 should be done.


#Dickey Fuller Test for 2nd order differenced time series for BU3
BU3diff2<-diff(ts_BU3, differences = 2)
summary(ur.df(BU3diff2, lag=0))
#Observations:
#The value of test-statistic is: -7.1215, which is less
#then 5% critical value. Hence, stationary for BU3 is
#achieved with second order difference.


# 4. Obtain best model for each BU.
#Identification of the best model using auto.arima
model_BU1 <- auto.arima(ts_BU1)
model_BU1

model_BU2 <- auto.arima(ts_BU2)
model_BU2

model_BU3 <- auto.arima(ts_BU3)
model_BU3
#Observations:
#Best model for ts_BU1 - ARIMA(0,1,1)(0,1,0)[12]
#sigma^2 = 1.424 (error variance) - it is the highest (making it less
#predictable) compared to BU2 and BU3.
#AIC=73.77   AICc=74.4   BIC=75.95 - Higher values indicate a relatively
#less efficient model compared to BU2 and BU3.
#Best model for ts_BU2 - ARIMA(0,1,1) with drift
#sigma^2 = 0.2386 - indicating a more stable model compare to BU1
#AIC=51.75   AICc=52.55   BIC=56.33 - Lower than BU1, meaning a better fit.
#Best model for ts_BU3 - ARIMA(0,1,1) with drift
#sigma^2 = 0.07058 - the lowest error variance among all three models
#AIC=10.21   AICc=11.01   BIC=14.79 - the lowest for model BU3
#BU3 is the most predictable unit, as it has the lowest error variance 
#and the best model fit.


# 5. Predict sales for each BU for January 2018, February 2018, March 2018.
#Forecast for the next 3 month
forecast_BU1 <- forecast(model_BU1, h=3)
forecast_BU2 <- forecast(model_BU2, h=3)
forecast_BU3 <- forecast(model_BU3, h=3)

#Print the forecasted values
print(forecast_BU1)
print(forecast_BU2)
print(forecast_BU3)

#Plot forecasted
par(mfrow=c(3,1)) #Showing all plots in rows
plot(forecast_BU1, main="Forecasted for BU1", col="blue")
plot(forecast_BU2, main="Forecasted for BU2", col="orange")
plot(forecast_BU3, main="Forecasted for BU3", col="green")

#Observations:
#Sales slightly decline for BU1 from 138.9859 in Jan to 135.9859 in 
#Mar 2018, indicating a possible seasonal pattern or market fluctuation.
#BU2 has steady upward trend from 131.7179 in Jan to 132.6391
#in Mar 2018, that suggests slight growth.
#BU3 has slightly increasing trend from 127.9471 in Jan to 128.7483
#in Mar 2018, with very small changes.
#Both BU2 and BU3 show steady increases.



