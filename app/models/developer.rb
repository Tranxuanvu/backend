# == Schema Information
#
# Table name: developers
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#
# Indexes
#
#  index_developers_on_deleted_at                (deleted_at)
#  index_developers_on_first_name_and_last_name  (first_name,last_name) UNIQUE
#  index_developers_on_project_id                (project_id)
#
class Developer < ApplicationRecord
  acts_as_paranoid

  # Validations
  validates :first_name, presence: true, uniqueness: { scope: :last_name }
  validates :last_name, presence: true, uniqueness: { scope: :first_name }

  # Associations
  has_many :developers_projects, dependent: :destroy
  has_many :projects, through: :developers_projects
end
