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
# customers.csv	Customer identifiers, unique IDs and location (zip code prefix, city, state) (Task 2)
# geolocation.csv	Zip code prefixes mapped to latitude/longitude, city and state (Bonus only)
# order_items.csv	Items within each order: product ID, seller ID, price, freight value (Task 1)
# orders.csv	Order identifiers, customer IDs, order status and timestamps (purchase, approval, delivery, estimated delivery) (Task 2)
# payments.csv	Order payments: payment sequence, payment type, instalments, value (Task 3)
# products.csv	Product identifiers, category name and physical attributes (name/description length, photos, weight, dimensions) (Task 1)
# sellers.csv	Seller identifiers and location (zip code prefix, city, state (Bonus only)

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

# First task,
# #•	Visualise the distribution of item prices in order_items.csv with a histogram, and report the mean and median price.

library(ggplot2)
library(tidyverse)
order_items = read.csv("order_items.csv")

# Histogram
ggplot(order_items) +
  geom_histogram(mapping = aes(x = price)) +
  labs(title = "Distribution of Item Prices", x = "Price", y = "Count")

# Mean and Median Price

mean_price = mean(order_items$price, na.rm = TRUE)
median_price = median(order_items$price, na.rm = TRUE)

#•	Join order_items.csv and products.csv, and draw a scatter plot of freight value against product weight (product_weight_g). Describe the relationship.

products = read.csv("products.csv")

# Join

items_product = left_join(order_items, products, by = "product_id")

# Scatter plot

ggplot(items_product) +
  geom_point(mapping = aes(x = product_weight_g, y = freight_value)) +
  labs(title = "Freight value vs product weight", x = "Product Weight (g)", y = "Freight Value")

# For relationship, it seems that everything is almost equal to each other, although some product weights has a higher value.

# Findings, 

# From the first histogram, the distribution has shown that the lesser the price, the more count the product has. 
# Also, mean price is at 120.65, median price at 74.99. It shows that the median is a better measure of the item prices.
# For the second, same findings, for relationship, it seems that everything is almost equal to each other, although some product weights has a higher value.


# Second task,
#•	Count the number of orders in each order status and the percentage of all orders, and visualise this with a bar chart. What percentage of orders were not delivered, that is, orders whose status is anything other than delivered?

library(ggplot2)
library(tidyverse)
orders = read.csv("orders.csv")

# Count number of orders in each status and percentage

status_summary = orders %>%
  count(order_status) %>%
  mutate(percentage = (n / sum(n)) * 100) # Turns counts to percentage

status_summary

# Bar plot

ggplot(status_summary) +
  geom_col(mapping = aes(x = order_status, y = percentage)) +
  labs(title = "Percentage of orders by status", x = "Status", y = "Percentage")

# Percentage of orders not delivered

not_delivered = status_summary %>%
  filter(order_status != "delivered") %>%
  summarise(not_delivered = sum(percentage))

not_delivered

#•	Join orders.csv and customers.csv, calculate the percentage of orders not delivered in each customer state, and show it in a bar chart.

customers = read.csv("customers.csv")
orders_customers = left_join(orders, customers, by = "customer_id")

# Count total orders per state

total_state = orders_customers %>%
  count(customer_state)

# Count orders not delivered per state

not_delivered = orders_customers %>%
  filter(order_status != "delivered") %>%
  count(customer_state)

# Join the two summaries and calculate percentage
state_summary = left_join(total_state, not_delivered, by = "customer_state")
state_summary$percent_not_delivered = (state_summary$n.y / state_summary$n.x) * 100

state_summary

# Bar chart

ggplot(state_summary) +
  geom_col(mapping = aes(x = customer_state, y = percent_not_delivered)) +
  labs(title = "Percentage of orders not delivered by state", x = "Customer State", y = "Percentage of not delivered")

# Findings,

# Out of all orders, 2.8% were not delivered, and by state, state RR is the highest at 10.9%

# Third task,

#•	Analyse the usage frequency of each payment type (number and percentage of payments), and visualise it with a bar chart.

library(ggplot2)
library(tidyverse)
payments = read.csv("payments.csv")

# Count the payments and calculate percentage

payment_summary = payments %>%
  count(payment_type)

payment_summary$percentage = (payment_summary$n / sum(payment_summary$n)) * 100

payment_summary

# Bar chart

ggplot(payment_summary) +
  geom_col(mapping = aes(x = payment_type, y = percentage)) +
  labs(title = "Frequency of each payment types", x = "Payment Type", y = "Percentage of Payments")

#•	Compare the payment values of the different payment types with a boxplot. Which payment types are used for larger or smaller amounts?

ggplot(payments) +
  geom_boxplot(mapping = aes(x = payment_type, y = payment_value)) +
  labs(title = "Payment Values vs Payment Types", x = "Payment Type", y = "Payment Values")

# Larger, credit
# Smaller, voucher

# Findings,

# Credit card is the most common type of payments, with debit card the least.