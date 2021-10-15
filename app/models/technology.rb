# == Schema Information
#
# Table name: technologies
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_technologies_on_deleted_at  (deleted_at)
#
class Technology < ApplicationRecord
  acts_as_paranoid

  # Validations
  validates :name, presence: true

  # Associations
  has_many :projects_technologies, dependent: :destroy
  has_many :projects, through: :projects_technologies
end
