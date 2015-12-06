#### Programming tasks
Carsales.Com is a provider for automotive advertising which is listed on the Australian Stock Exchange (ASX). The ASX identifies companies with an alphanumeric code (ticker). The current ticker for Carsales is CAR, but prior to 26/2/2015 the ticker was CRZ. This task consists of 2 parts:
1. Design a database schema to store pricing history (Open, Low, High, Close, Volume, AdjClose) for companies listed on the ASX. The schema should allow the user to see the correct company ticker at any specific date, and also the daily return to be derived from AdjClose pricing data,

2. Create an executable in a programming language of your choice to retrieve pricing data for Carsales from Yahoo Finance between 2 dates and save to CSV file(s) in a form ready to be inserted into the database schema previously designed.

####Task 1. Database schema design

In my solution, there will be 3 data tables:
ASX_PRICE table to store daily financial data for designated ticker
TICKER table to retain ticker and company information e.g. CAR for carsales.com.au
SOURCE table to keep information provider e.g. Yahoo Finance
Basically, each table has primary key as Price_id, Ticker_id, and Source_id. ASX_PRICE table will have foreign keys which are Ticker_id and Source_id which respectively links to TICKER and SOURCE table.

Regarding the issue of certain company having multiple Ticker_codes i.e. carsales.com.au has CAR and CRZ, it can be resolved by strictly keeping formal company name. For instance, CAR and CRZ can be inserted in TICKER table as a different row of record. However, having same formal Company_name will allow us to query using either of them (tickers) to pull data from both. See the query below.

![Image of DB Design](images/unamed.png)
```
SELECT		AP.PRRICE_ID,
			T.TICKER_CODE,	-- 'CAR' or 'CRZ'
			AP.COMPUTE_DATE,		
			AP.OPEN_PRICE,	
			AP.CLOSE_PRICE,
			AP.LOW_PRICE,
			AP.HIGH_PRICE,
			AP.VOLUME,
			AP.ADJCLOSE_PRICE	 
FROM 		ASX_PRICE AP WITH(NOLOCK)
INNER JOIN 	TICKER T WITH(NOLOCK)		ON AP.TICKER_ID=T.TICKER_ID 
WHERE		T.COMPANY_NAME IN (SELECT COMPANY_NAME FROM TICKER WHERE ACTIVATED=1 AND TICKER_CODE='CAR')
ORDER BY	AP.COMPUTE_DATE ASC;
```

####Task 2. Financial data mining program

About task 2, I have attached R script (daily financial data.R) to extract financial data. I have chosen R program since I'm sure there must be URL to scrap data in .CSV format from Yahoo Finance, R is good candidate to deal with it. For your information, I have used search to remind me of R syntax and find a way to pull Yahoo Finance data, but not copied directly. 

Possibly Task 3 can be created to implement program to store output from R script into database. To do this, I may use ASP.NET framework or check if Microsoft Azure platform (which already supports running R script and visualize R ouput) has smartness to address the situation.

