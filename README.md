# Mileage Report API

The Mileage Report API is a Ruby-based web service that allows users to extract data from Mileage Report XLS files. It leverages the Grape framework for building APIs and provides a JSON interface to access the extracted data.

## Requirements

To use the Mileage Report API, you need to have the following installed:

- Ruby
- Grape gem
- Roo gem
- Roo-xls gem
- Grape-Swagger gem

## Installation

1. Clone or download the project files from the repository.

2. Install the required gems by running the following command in the project directory:

```bash
bundle install
```

Usage
To start the Mileage Report API server, run the following command in the project directory:

```bash
ruby app.rb
```

The API will be accessible at http://localhost:3000/api/v1/mileage_report. It will extract data from the provided XLS files and return the results in JSON format.

API Endpoints
Extract Mileage Report Data
URL: /api/v1/mileage_report
Method: GET
Description: Extracts Mileage Report data from the XLS files specified in the "data" directory.
Response: An array of extracted data for all three files, each containing Company, DateRange, TotalDriverCount, ProcessedDate, and DriverData.

Running Test Cases
To run the test cases for the Mileage Report API, use the following command in the project directory:

```bash
bundle exec rspec
```

This will execute all the test cases and provide a summary of the results, including any failures or errors encountered during testing.
