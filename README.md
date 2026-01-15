# Time Series Analysis: USA Firm Sales Forecasting

## Project Overview
This project presents a time series analysis conducted in R to analyze and forecast monthly sales of a leading processed food manufacturer in the United States.  
Sales data from three business units (BU1, BU2, BU3) are examined to identify trends, stationarity, and future sales behavior.

## Business Context
The dataset contains monthly sales figures (in million USD) for three business units from **February 2015 to January 2018**.  
Accurate sales forecasting helps the firm improve demand planning, inventory management, and strategic decision-making.

## Objectives
1. Import and explore monthly sales data  
2. Convert sales data into time series objects  
3. Check stationarity using graphical and statistical methods  
4. Identify the best ARIMA model for each business unit  
5. Forecast sales for the next three months  

## Dataset
The dataset (`USA_FIRM_SALES_DATA.csv`) is included in the repository and located in the root directory.

### Dataset Description
Variables:
- `Year` — Calendar year  
- `Month` — Month  
- `BU1` — Sales of Business Unit 1  
- `BU2` — Sales of Business Unit 2  
- `BU3` — Sales of Business Unit 3  

Each business unit contains **35 monthly observations**.

## Analysis Workflow
1. Data import and validation  
2. Creation of time series objects  
3. Exploratory visualization of sales trends  
4. Stationarity testing:
   - ACF plots  
   - Augmented Dickey–Fuller test  
5. Differencing to achieve stationarity  
6. ARIMA model selection using `auto.arima()`  
7. Sales forecasting for three future months  

## Methods and Techniques
- Time series visualization  
- Stationarity testing:
  - ACF
  - Augmented Dickey–Fuller test  
- ARIMA modeling  
- Forecasting using the `forecast` package  

## Key Findings
- All three business units exhibit non-stationary behavior in original series  
- BU1 and BU2 achieve stationarity after first-order differencing  
- BU3 requires second-order differencing  
- ARIMA models provide reliable short-term forecasts  
- BU3 shows the lowest forecast error variance, indicating stable sales behavior  

## Visualization
Time series plots and forecast visualizations are generated within the analysis.  
Selected outputs can be saved in the `results/` directory.

## Tools and Skills
- R
- Time Series Analysis
- ARIMA Modeling
- Forecasting
- Business Analytics

## How to Run the Project
1. Clone the repository  
2. Open the R script  
3. Ensure required packages are installed  
4. Run the script sequentially  

## Notes
This project was completed for educational purposes and demonstrates practical time series forecasting techniques applied to real-world business data.
