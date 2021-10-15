# == Schema Information
#
# Table name: projects_technologies
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :bigint           not null
#  technology_id :bigint           not null
#
# Indexes
#
#  index_projects_technologies_on_project_id     (project_id)
#  index_projects_technologies_on_technology_id  (technology_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (technology_id => technologies.id)
#
require 'rails_helper'

RSpec.describe ProjectsTechnology, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:technology) }
  end
end
