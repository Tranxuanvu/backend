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
class DeveloperSerializer < BaseSerializer
  attributes :first_name, :last_name

  attribute :name do |object|
    object.fullname
  end

  attribute :projects do |object|
    object.projects.map { |project| { id: project.id, name: project.name } }
  end
end
