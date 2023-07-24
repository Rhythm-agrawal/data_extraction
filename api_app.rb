require "grape-swagger"
require_relative "mileage_report_api"
require 'rack/cors'

class APIApp < Grape::API
  # Mount the Swagger UI endpoint
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
    end
  end
  
  format :json
  mount MileageReportAPI
  add_swagger_documentation api_version: 'v1'
end

