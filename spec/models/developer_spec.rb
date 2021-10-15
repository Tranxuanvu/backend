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
require 'rails_helper'

RSpec.describe Developer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_uniqueness_of(:first_name).scoped_to(:last_name) }
    it { is_expected.to validate_uniqueness_of(:last_name).scoped_to(:first_name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:developers_projects).dependent(:destroy) }
    it { is_expected.to have_many(:projects).through(:developers_projects) }
  end
end
