require 'rails_helper'

RSpec.describe Fetcher::Categories do
  let(:catalog) { Nokogiri::XML(file_fixture('catalog.xml')) }

  subject { described_class.new(catalog).fetch }

  describe '#fetch' do
    let(:first_category) { subject.first }
    let(:second_category) { subject.second }
    let(:first_category_name) { 'category #1' }
    let(:second_category_name) { 'category #2' }

    it { expect(subject.count).to eq(2) }
    it { expect(first_category.external_id).to eq(2844) }
    it { expect(second_category.external_id).to eq(1) }
    it { expect(first_category.name).to eq(first_category_name) }
    it { expect(second_category.name).to eq(second_category_name) }
    it { expect(first_category.subcategories).to eq([second_category]) }
    it { expect(second_category.parent_category).to eq(first_category) }
  end
end
