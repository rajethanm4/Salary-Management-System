require 'rails_helper'

RSpec.describe Employee, type: :model do
  it "is valid with valid attributes" do
    employee = Employee.new(
      full_name: "Raj",
      job_title: "Engineer",
      country: "india",
      salary: 50000
    )
    expect(employee).to be_valid
  end

  it "is invalid without full_name" do
    employee = Employee.new(job_title: "Engineer", country: "india", salary: 50000)
    expect(employee).not_to be_valid
  end

  it "is invalid with negative salary" do
    employee = Employee.new(
      full_name: "Raj",
      job_title: "Engineer",
      country: "india",
      salary: -100
    )
    expect(employee).not_to be_valid
  end

  it 'is valid without country' do
    employee = Employee.new(
      full_name: "Raj",
      job_title: "Engineer",
      salary: 50000
    )
    expect(employee).not_to be_valid
  end

  it 'is valid without job_title' do
    employee = Employee.new(
      full_name: "Raj",
      country: "india",
      salary: 50000
    )
    expect(employee).not_to be_valid
  end

  it 'is invalid with non-numeric salary' do
    employee = Employee.new(
      full_name: "Raj",
      job_title: "Engineer",
      country: "india",
      salary: "not_a_number"
    )
    expect(employee).not_to be_valid
  end
end
