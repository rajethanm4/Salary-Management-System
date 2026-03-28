class Api::V1::Metrics::SalaryController < ApplicationController
  # GET /api/v1/metrics/salary/country/:country
  def by_country
    employees = Employee.by_country(params[:country])

    unless employees.exists?
      return render json: {
        error: "No employees found",
        message: "No employees found for country: #{params[:country]}"
        }, status: :not_found
    end

    stats = employees.pick(
      Arel.sql("MIN(salary)"),
      Arel.sql("MAX(salary)"),
      Arel.sql("AVG(salary)")
    )

    render json: {
      country: params[:country],
      employee_count: employees.count,
      minimum_salary: stats[0].to_f.round(2),
      maximum_salary: stats[1].to_f.round(2),
      average_salary: stats[2].to_f.round(2)
    }, status: :ok
  end

  # GET /api/v1/metrics/salary/job_title/:job_title
  def by_job_title
    employees = Employee.by_job_title(params[:job_title])

    unless employees.exists?
      return render json: {
        error: "No employees found",
        message: "No employees found for job title: #{params[:job_title]}"
      }, status: :not_found
    end

    render json: {
      job_title: params[:job_title],
      employee_count: employees.count,
      average_salary: employees.average(:salary).to_f.round(2)
      }, status: :ok
  end
end
