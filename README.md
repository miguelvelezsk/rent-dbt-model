# 🇨🇴 Medellín Real Estate & Gentrification Analytics Pipeline

This project is an End-to-End data engineering pipeline designed to extract, clean, model, and visualize the residential rental market in Medellín, Colombia. The primary objective is to identify sectors experiencing accelerated gentrification by analyzing the cost per square meter and measuring the real market gap against the country's accumulated Consumer Price Index (CPI).

## Data Architecture

The pipeline follows the modern **ELT** (Extract, Load, Transform) paradigm:

1. **Extract (Python):** A modular, adaptive web scraper designed to capture live listings from real estate portals while dynamically avoiding traffic blocks.
2. **Load & Clean (Pandas):** Automated business logic filtering and mathematical outlier removal using the **Interquartile Range (IQR)** method applied to the price per square meter.
3. **Feature Engineering (Pandas):** Indexation of Colombia's accumulated inflation over the last 4 years (~36.5% based on DANE's CPI) on a row-by-row basis to calculate a theoretical "expected price" and the monthly gap in COP for each individual property.
4. **Transform (dbt Cloud):** Data orchestration and transformation using a layered approach (`Staging` for casting/typing and `Marts` for business analytics and statistical aggregations) running on Google BigQuery.
5. **Visualize (Looker Studio):** An interactive business intelligence dashboard utilizing a custom "Brick & Mountain" visual theme to contrast real market prices against inflation baselines.

[Web Portal] ──(Python Scraper)──> [Pandas (IQR + Inflation Clean)] ──(to_gbq)──> [BigQuery Raw] ──(dbt Cloud)──> [dbt Marts] ──> [Looker Studio]

## Market Insights (Real Processed Data)

After orchestrating the raw data into Google BigQuery using dbt, the final analytics model revealed the sectors with the highest pricing pressure and misalignment against standard inflation in Medellín (Sectors with a minimum of 3 active listings):

| Sector / Neighborhood | Active Listings | Avg Monthly Price | Real Cost / $m^2$ | Inflation Expected Cost / $m^2$ | Market Price Premium % |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **El Tesoro** | 12 | \$8,633,333 COP | \$58,773 COP | \$37,650 COP | **+56.10%** |
| **Lalinde** | 3 | \$4,833,333 COP | \$58,266 COP | \$37,650 COP | **+54.75%** |
| **Altos del Poblado** | 20 | \$6,692,500 COP | \$56,411 COP | \$37,650 COP | **+49.83%** |
| **Los Balsos** | 25 | \$7,422,000 COP | \$54,924 COP | \$37,650 COP | **+45.88%** |
| **El Poblado** | 7 | \$7,414,285 COP | \$49,117 COP | \$37,650 COP | **+30.45%** |

### Core Findings:
* **The Total Area Paradox (La Calera & Cola del Zorro):** Although these sectors command the highest absolute monthly rents in the dataset (**\$13.2M** and **\$12.3M COP** respectively), their cost per square meter remains aligned with the average. Their steep price is purely a function of **large property sizes (square footage)** rather than an inflationary premium.
* **Empirical Evidence of Gentrification:** High-end sectors like *El Tesoro* and *Lalinde* feature rental prices that exceed the projected cost of living by more than **54%**. This means tenants are paying an average premium of **+\$3,100,000 COP per month** above the historical inflation baseline due to high international and luxury demand.

## Tech Stack

* **Python 3.11** (BeautifulSoup4, Requests)
* **Pandas** (Statistical Outlier Treatment / IQR & Feature Engineering)
* **Google BigQuery** (Serverless Data Warehouse)
* **dbt Cloud** (Data Build Tool - Transformations, lineage, and orchestration)
* **Looker Studio** (Business Intelligence & Data Visualization)
