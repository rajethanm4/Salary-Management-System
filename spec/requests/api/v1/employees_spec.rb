require 'rails_helper'

RSpec.describe "Api::V1::Employees", type: :request do
  let!(:employee1) do
    Employee.create!(
      full_name: "Raj",
      job_title: "Engineer",
      country: "india",
      salary: 50000
    )
  end

  let!(:employee2) do
    Employee.create!(
      full_name: "John",
      job_title: "Manager",
      country: "united states",
      salary: 80000
    )
  end

  describe "GET /api/v1/employees" do
    it "returns all employees" do
      get "/api/v1/employees"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)["data"]

      expect(data.length).to eq(2)
    end

    it "filters by country" do
      get "/api/v1/employees", params: { country: "india" }

      data = JSON.parse(response.body)["data"]
      expect(data.length).to eq(1)
      expect(data.first["country"]).to eq("india")
    end

    it "filters by job_title" do
      get "/api/v1/employees", params: { job_title: "manager" }

      data = JSON.parse(response.body)["data"]
      expect(data.length).to eq(1)
      expect(data.first["job_title"]).to eq("Manager")
    end
  end

  describe "GET /api/v1/employees/:id" do
    it "returns an employee" do
      get "/api/v1/employees/#{employee1.id}"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data["id"]).to eq(employee1.id)
    end
  end

  describe "POST /api/v1/employees" do
    it "creates an employee" do
      post "/api/v1/employees", params: {
        employee: {
          full_name: "Test",
          job_title: "QA",
          country: "india",
          salary: 40000
        }
      }

      expect(response).to have_http_status(:created)
      expect(Employee.count).to eq(3)
    end

    it "returns error for invalid data" do
      post "/api/v1/employees", params: {
        employee: {
          full_name: "",
          job_title: "",
          country: "",
          salary: -10
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /api/v1/employees/:id" do
    it "updates employee" do
      patch "/api/v1/employees/#{employee1.id}", params: {
        employee: { full_name: "Updated Name" }
      }

      expect(response).to have_http_status(:ok)
      expect(employee1.reload.full_name).to eq("Updated Name")
    end
  end

  describe "DELETE /api/v1/employees/:id" do
    it "deletes employee" do
      delete "/api/v1/employees/#{employee1.id}"

      expect(response).to have_http_status(:no_content)
      expect(Employee.exists?(employee1.id)).to be_falsey
    end
  end

  describe "GET /api/v1/employees/:id/salary" do
    it "returns salary calculation" do
      get "/api/v1/employees/#{employee1.id}/salary"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data["net_salary"]).to eq(45000)
    end
  end
end
