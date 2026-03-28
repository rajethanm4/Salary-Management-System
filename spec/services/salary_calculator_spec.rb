require 'rails_helper'

RSpec.describe SalaryCalculator do
  let(:employee) do
    Employee.new(
      id: 1,
      full_name: "Raj",
      job_title: "Engineer",
      country: "india",
      salary: 50000
    )
  end

  it "calculates salary with deduction for India" do
    result = SalaryCalculator.new(employee).call

    expect(result[:gross_salary]).to eq(50000)
    expect(result[:total_deductions]).to eq(5000)
    expect(result[:net_salary]).to eq(45000)
  end

  it 'calculates salary with deduction for United States' do
    employee.country = "united states"

    result = SalaryCalculator.new(employee).call

    expect(result[:gross_salary]).to eq(50000)
    expect(result[:total_deductions]).to eq(6000)
    expect(result[:net_salary]).to eq(44000)
  end

  it "returns no deduction if country not in rules" do
    employee.country = "france"

    result = SalaryCalculator.new(employee).call

    expect(result[:total_deductions]).to eq(0.0)
    expect(result[:net_salary]).to eq(50000)
  end
end
