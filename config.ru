# config.ru

require_relative 'mileage_report_api'
require 'rack/cors'

# Define your Grape API
run MileageReportAPI

# Add Rack::Cors middleware to handle Cross-Origin Resource Sharing (CORS)
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
  end
end
