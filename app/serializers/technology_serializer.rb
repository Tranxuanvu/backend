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
class TechnologySerializer < BaseSerializer
  attributes :name
end
