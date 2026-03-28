class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show update destroy salary]

  def index
    employees = Employee.all
    employees = employees.by_country(params[:country]) if params[:country].present?
    employees = employees.by_job_title(params[:job_title]) if params[:job_title].present?

    employees = employees.order(:id)
                      .page(params[:page])
                      .per(params[:per_page] || 10)

    render json: {
      data: employees.map { |e| serialize_employee(e) },
        meta: pagination_meta(employees)
      }, status: :ok
  end

  def show
    render json: serialize_employee(@employee), status: :ok
  end

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: serialize_employee(employee), status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: serialize_employee(@employee), status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy!
    head :no_content
  end

  def salary
    result = SalaryCalculator.new(@employee).call
    render json: result, status: :ok
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end

  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

  def serialize_employee(employee)
    {
      id: employee.id,
      full_name: employee.full_name,
      job_title: employee.job_title,
      country: employee.country,
      salary: employee.salary.to_f
    }
  end
end
