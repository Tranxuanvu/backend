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
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:start_date) }

    context 'end_date_after_start_date?' do
      subject { FactoryBot.build(:project, start_date: Date.current, end_date: Date.current - 1) }

      it 'raises an error if end date is lower than start date' do
        subject.valid?
        expect(subject.errors.full_messages).to include('End date must be after Start date')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:developers_projects).dependent(:destroy) }
    it { is_expected.to have_many(:developers).through(:developers_projects) }
    it { is_expected.to have_many(:projects_technologies).dependent(:destroy) }
    it { is_expected.to have_many(:technologies).through(:projects_technologies) }
  end
end
