class Employee < ApplicationRecord
  validates :full_name, presence: true
  validates :job_title, presence: true
  validates :country, presence: true
  validates :salary, presence: true, numericality: { greater_than: 0 }

  scope :by_country, ->(country) { where("LOWER(country) = ?", country.to_s.downcase) }
  scope :by_job_title, ->(job_title) { where("LOWER(job_title) = ?", job_title.to_s.downcase) }
end
