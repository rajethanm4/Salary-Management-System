require 'rails_helper'

RSpec.describe "Api::V1::Metrics::Salary", type: :request do
  before do
    Employee.create!(
      full_name: "Raj",
      job_title: "Engineer",
      country: "india",
      salary: 50000
    )

    Employee.create!(
      full_name: "Amit",
      job_title: "Engineer",
      country: "india",
      salary: 60000
    )

    Employee.create!(
      full_name: "John",
      job_title: "Manager",
      country: "united states",
      salary: 80000
    )
  end

  describe "GET /api/v1/metrics/salary/country/:country" do
    it "returns salary stats for country" do
      get "/api/v1/metrics/salary/country/india"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data["employee_count"]).to eq(2)
      expect(data["minimum_salary"]).to eq(50000.0)
      expect(data["maximum_salary"]).to eq(60000.0)
      expect(data["average_salary"]).to eq(55000.0)
    end

    it "returns not found for invalid country" do
      get "/api/v1/metrics/salary/country/france"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/v1/metrics/salary/job_title/:job_title" do
    it "returns average salary for job title" do
      get "/api/v1/metrics/salary/job_title/engineer"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data["employee_count"]).to eq(2)
      expect(data["average_salary"]).to eq(55000.0)
    end

    it "returns not found for invalid job title" do
      get "/api/v1/metrics/salary/job_title/designer"

      expect(response).to have_http_status(:not_found)
    end
  end
end
