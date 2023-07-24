require "rack/test"
require_relative "../mileage_report_api"

RSpec.describe MileageReportAPI, type: :request do
  include Rack::Test::Methods

  def app
    MileageReportAPI.new
  end

  context "GET /api/v1/mileage_report" do
    it "returns a 200 status code and JSON data when XLS files exist" do
      allow(Roo::Excel).to receive(:new).and_return(
        double(
          cell: "Company Name",
          last_row: 8,
          celltype: nil,
          sheet: nil
        )
      )
      
      get "/api/v1/mileage_report"

      expect(last_response.status).to eq(200)
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response).to be_an(Array)
      expect(parsed_response.length).to eq(3)

      parsed_response.each do |data|
        expect(data).to have_key("Company")
        expect(data).to have_key("DateRange")
        expect(data).to have_key("TotalDriverCount")
        expect(data).to have_key("ProcessedDate")
        expect(data).to have_key("DriverData")
      end
    end

    it "returns a 500 status code with an error message when XLS files are missing" do
      allow(Roo::Excel).to receive(:new).and_raise("File not found")

      get "/api/v1/mileage_report"

      expect(last_response.status).to eq(500)
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response).to have_key("error")
    end
  end
end
