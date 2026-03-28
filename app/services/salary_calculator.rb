# app/services/salary_calculator.rb
class SalaryCalculator
  DEDUCTION_RULES = {
    "india" => { name: "TDS", rate: 0.10 },
    "united states" => { name: "TDS", rate: 0.12 }
  }.freeze

  attr_reader :employee

  def initialize(employee)
    @employee = employee
  end

  def call
    gross_salary = employee.salary.to_d
    rule = deduction_rule

    return no_deduction_response(gross_salary) unless rule

    deduction_amount = (gross_salary * rule[:rate]).round(2)
    net_salary = (gross_salary - deduction_amount).round(2)

    base_response(gross_salary).merge(
      deductions: [
        {
          name: rule[:name],
          rate: "#{(rule[:rate] * 100).to_i}%",
          amount: deduction_amount
        }
      ],
      total_deductions: deduction_amount,
      net_salary: net_salary
    )
  end

  private

  def deduction_rule
    DEDUCTION_RULES[employee.country.to_s.downcase]
  end

  def base_response(gross_salary)
    {
      employee_id: employee.id,
      full_name: employee.full_name,
      country: employee.country,
      gross_salary: gross_salary
    }
  end

  def no_deduction_response(gross_salary)
    base_response(gross_salary).merge(
      deductions: [],
      total_deductions: 0.0,
      net_salary: gross_salary
    )
  end
end
