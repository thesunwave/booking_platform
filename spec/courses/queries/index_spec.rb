require 'rails_helper'

RSpec.describe Courses::Queries::Index do
  subject { described_class.new(model: model).call(sort_by)}

  let(:model) { Course }

  before do
    FactoryBot.create(:course, name: 'Go', groups: [FactoryBot.build(:group, start_date: Date.current)])
    FactoryBot.create(:course, name: 'Ruby', groups: [FactoryBot.build(:group, start_date: Date.current + 1.day)])
    FactoryBot.create(:course, name: 'Java', groups: [FactoryBot.build(:group, start_date: Date.current + 2.day)])
  end

  describe 'sort by group start date' do

    context 'when asc' do
      let(:sort_by) { 'groups_asc' }

      it 'returns right order' do
        expect(subject.value!.pluck(:name)).to eq(['Go', 'Ruby', 'Java'])
      end
    end

    context 'when desc' do
      let(:sort_by) { 'groups_desc' }

      it 'returns right order' do
        expect(subject.value!.pluck(:name)).to eq(['Java', 'Ruby', 'Go'])
      end
    end
  end

  describe 'sort by course name' do
    context 'when asc' do
      let(:sort_by) { 'name_asc' }

      it 'returns right order' do
        expect(subject.value!.pluck(:name)).to eq(['Go', 'Java', 'Ruby'])
      end
    end

    context 'when desc' do
      let(:sort_by) { 'name_desc' }

      it 'returns right order' do
        expect(subject.value!.pluck(:name)).to eq(['Ruby', 'Java', 'Go'])
      end
    end
  end

  describe 'when sort is nil' do
    let(:sort_by) { nil }

    it 'returns order by id' do
      expect(subject.value!.pluck(:name)).to eq(['Go', 'Ruby', 'Java'])
    end
  end
end
