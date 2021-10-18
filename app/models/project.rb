# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :text
#  end_date    :date
#  name        :string
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_deleted_at  (deleted_at)
#  index_projects_on_start_date  (start_date)
#
class Project < ApplicationRecord
  acts_as_paranoid

  # Validations
  validates :name, :description, :start_date, presence: true
  validate :end_date_after_start_date?

  # Associations
  has_many :developers_projects, dependent: :destroy
  has_many :developers, through: :developers_projects
  has_many :projects_technologies, dependent: :destroy
  has_many :technologies, through: :projects_technologies

  private

  def end_date_after_start_date?
    errors.add(:end_date, 'must be after Start date') if end_date.present? && end_date < start_date
  end
end
