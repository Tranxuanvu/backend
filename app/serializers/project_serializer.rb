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
class ProjectSerializer < BaseSerializer
  attributes :name, :description

  attribute :start_date do |object|
    object.start_date.strftime('%d/%m/%Y')
  end

  attribute :end_date do |object|
    object&.end_date&.strftime('%d/%m/%Y')
  end

  attribute :technologies do |object|
    object.technologies.map { |tech| { id: tech.id, name: tech.name } }
  end

  attribute :developers do |object|
    object.developers.map { |dev| { id: dev.id, name: dev.fullname } }
  end
end
