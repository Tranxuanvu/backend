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
require 'rails_helper'

RSpec.describe Technology, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects_technologies).dependent(:destroy) }
    it { is_expected.to have_many(:projects).through(:projects_technologies) }
  end
end
