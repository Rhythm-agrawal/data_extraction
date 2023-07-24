require "grape"
require "roo"
require "roo-xls"
require "grape-swagger"
require 'rack/cors'

class MileageReportAPI < Grape::API
  version "v1", using: :path
  format :json
  prefix :api

  desc "Extract Mileage Report data"
  get "/mileage_report" do
    file_paths = [
      "data/XYZ_MPG_2020_August.xls",
      "data/XYZ_MPG_2020_April.xls",
      "data/XYZ_MPG_2020_January.xls"
    ]

    result = []

    file_paths.each do |file_path|
      if file_path.end_with?(".xls")
        df = Roo::Excel.new(file_path)
      else
        raise "Unsupported file format. Supported formats: .xls, .xlsx, .xlsm"
      end

      # Extract the relevant information from the Excel file
      company_name = df.cell(2, 1)
      date_range = df.cell(3, 1)
      total_driver_count = df.cell(4, 1)
      processed_date = df.cell(5, 1)

      driver_data = []
      (8..df.last_row).each do |row|
        driver = df.cell(row, 1)
        miles = df.cell(row, 2)
        gallons = df.cell(row, 3)
        mpg = df.cell(row, 4)

        driver_data << {Driver: driver, Miles: miles, Gallons: gallons, MPG: mpg}
      end

      # Store the extracted data in a hash
      data = {
        Company: company_name,
        DateRange: date_range,
        TotalDriverCount: total_driver_count,
        ProcessedDate: processed_date,
        DriverData: driver_data
      }

      result << data
    end

    # Return the array of extracted data for all three files
    result
  rescue => e
    error!({ error: e.message }, 500)
  end

  add_swagger_documentation(
    api_version: "v1",
    hide_format: true,
    hide_documentation_path: true,
    mount_path: "/swagger_doc",
    info: {
      title: "Mileage Report API",
      description: "API to extract data from Mileage Report XLS files",
      contact: {
        name: "Rhythm Agrawal",
        email: "rhythmagrawal41@email.com"
      },
      license: {
        name: "The name of the license.",
        url: "www.The-URL-of-the-license.org"
      },
      version: "0.0.1"
    }
  )
end
