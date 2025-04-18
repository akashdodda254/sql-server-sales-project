# 🛒 SQL Server Sales Insights Platform

A real-time retail sales analytics system built in SQL Server. This project simulates a multi-store business with sales transactions, reporting layers, invoice generation, and access control.

## 📦 Features

- Normalized schema with Products, Customers, Stores, Sales
- Inventory tracking with stock triggers and low-stock alerts
- Invoice generation with billing logic
- Reporting layer with daily and monthly ETL rollups
- Stored procedures, functions, and error logging
- Simulated row-level security and role-based views
- Window functions: running totals, rankings

## 📂 Folder Structure

- `1_create_tables.sql`: Schema design
- `2_insert_sample_data.sql`: Dummy data setup
- `3_stored_procedures.sql`: Sales and ETL logic
- `4_views.sql`: Sales summaries, invoice view
- `5_triggers.sql`: Inventory and audit automation
- `6_row_level_security.sql`: Store-based filtering

## 🛠️ Built With

- SQL Server 2022
- SSMS (SQL Server Management Studio)

## 📊 Future Enhancements

- Power BI Dashboard
- REST API Integration
- Email alerts via SQL Agent

---

## 👨‍💻 Author

**Akash Dodda**  
📧 akashdodda254@gmail.com  
🌐 [github.com/akashdodda254](https://github.com/akashdodda254)
