# Data Analytics in Power BI Report

In this project, I have been tasked to create a Quartely report for a (theoretical) medium-sized international retailer. The end goal for the report is to be a high-level business summary for C-suite executives, and give insights into business metrics to demonstrate current performance. 


## Project Milestones

### Milestone One
In order to track changes, and implement reobust version control, a git repository was creeated for this project. 

### Milestone Two
This project utilises the ETL pipeline of data analytics. This stands for: extract, transform, and load. The key skills utilised in this project are:
- Importing, or extracting, data into PowerBI from different sources. Methods used were:
    1. Importing the products table from a .csv file. To do this, simply select text/csv file from the "Get data" option in the home banner. 
    2. Connecting to an SQL database to extract the orders table. To do this, select "SQL server" from the "Get data" option in the home banner. You will be prompted to enter the server name and database name (optional), followed by another prompt to ever the username and password for the desired server/database. The navigation pane will be displayed once you are connected, and from here you can select the table(s) that you want to import. 
    3. Connecting to an Azure Blob Storage container and extracting the stores table.  To do this, select "Azure Blob Storage" from the "Get data" option in the home banner. You will be prompted to enter an account name, followed by an account key. The navigation pane will be displayed once you are connected, from which you can select the container that you want to import. You should select transform data at this stage, and select "Combine" from the first column to populate the table with the data. 
    4. Importing a folder containg three .csv files and combing these to create the customers table. To do this, simply select text/csv file from the "Get data" option in the home banner and point PowerBI to the desired folder. Once the navigation pane pops up, select "Combine and transform" to generate a single table with the information from all the .csv files in your folder. 
- Transforming data in Power Query Editor to rename columns, remove null rows to ensure data integrity, deleting unnecessary columns (and those that contain sensitive data), and creating new columns based upon existing columns. 
- Loading the data into PowerBI for further analysis. 


### Milestone Three
For comprehensive analysis, a date table was generated that separates the date from the orders table into several key aspects:
- Day of Week - Generated using the `WEEKDAY()` function. 
- Month Number - Generated using the `MONTH()` function. 
- Month Name - Generated using `'Date Table'[date].[Month]`
- Quarter - Generated using the `QUARTER()` function.
- Year - Generated using the `YEAR()` function. 
- Start of Year, Quarter, Month -  Generated using `STARTOFYEAR()`, `STARTOFQUARTER()`, and `STARTOFMONTH()` respectively.
- Start of Week - Generated using `'Date Table'[date] - WEEKDAY('Date Table'[date], 2) + 1` where the weekday is taken from the date and one added to get the date for the start of the week. 


#### Star Schema
A star schema was created to define the relationships between the tables in this project. Each of these relationships is a one-to-many, single direction relationship. This means that each entry in one table, there are many matching entries in the related table. Below is a schematic of the star schema for this project. The arrows show the direction of the relationship. 

![Alt text](image.png)

#### Measure Table
It is good practice to create a table to hold your measures. This is so that they are easily accessible and do not get lost or difficult to find in larger projects. Within this table, seven key measures were created:
1. Total orders - `COUNTROWS(Orders)` Calculates the total orders. This is a dynamic measure and will change as different filters are applied. 
2. Total revenue - `SUMX(Orders, Orders[product quantity] * RELATED(Products[sale price]))` Calculates the total revenue. 
3. Total profit - `SUMX(Orders, (RELATED(Products[sale price]) - RELATED(Products[cost price])) * Orders[product quantity])` Calcualtes the total profit.
4. Total customers - `DISTINCTCOUNT(Orders[user ID])` Calculates the total customers. 
5. Total quantity - `SUM(Orders[product quantity])` Calcualtes the total products sold. 
6. Profit year to date - `TOTALYTD([total profit], 'Date Table'[year])` Calculates the total profit for the specified year. 
7. Revenue year to date - `TOTALYTD([total revenue], 'Date Table'[year])` Calculates the total revenue for the specified year. 

#### Calculated Columns
There were several calcualted columns created at this stage also. 
1. Country in the Stores table - This was generated using an IF statement based on the country code as follows: `IF(Stores[country code] = "GB", "United Kingdom", IF(Stores[country code] = "US", "United States", "Germany"))`
2. Geography in the Stores table - This was generated by concatenating the values from the country region and country columsn as follows: `CONCATENATE(Stores[country region], CONCATENATE(", ", Stores[country]))`