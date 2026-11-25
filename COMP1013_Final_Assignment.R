# COMP1013 Final Assignment script
# Written by Anzarez Saka Hiragizawa
# 25th of November 2026
# Description:
# Final Assignment for COMP1013

# Project Tasks:
# You are a data analyst for a large e-commerce marketplace operating in Brazil. 
# Management wants to understand how product prices and shipping costs behave, 
# how many orders are not delivered, and how customers pay. 
# You have been given data on orders, customers, products, sellers, payments and geolocation from 2016 to 2018.
# The dataset is provided as seven CSV files:
# customers.csv	Customer identifiers, unique IDs and location (zip code prefix, city, state)
# geolocation.csv	Zip code prefixes mapped to latitude/longitude, city and state
# order_items.csv	Items within each order: product ID, seller ID, price, freight value
# orders.csv	Order identifiers, customer IDs, order status and timestamps (purchase, approval, delivery, estimated delivery)
# payments.csv	Order payments: payment sequence, payment type, instalments, value	
# products.csv	Product identifiers, category name and physical attributes (name/description length, photos, weight, dimensions)
# sellers.csv	Seller identifiers and location (zip code prefix, city, state

# Task 1:
#•	Visualise the distribution of item prices in order_items.csv with a histogram, and report the mean and median price.
#•	Join order_items.csv and products.csv, and draw a scatter plot of freight value against product weight (product_weight_g). Describe the relationship.
#•	Explain your findings.

# Task 2:
#•	Count the number of orders in each order status and the percentage of all orders, and visualise this with a bar chart. What percentage of orders were not delivered, that is, orders whose status is anything other than delivered?
#•	Join orders.csv and customers.csv, calculate the percentage of orders not delivered in each customer state, and show it in a bar chart.
#•	Explain your findings.

# Task 3:
#•	Analyse the usage frequency of each payment type (number and percentage of payments), and visualise it with a bar chart.
#•	Compare the payment values of the different payment types with a boxplot. Which payment types are used for larger or smaller amounts?
#•	Explain your findings.