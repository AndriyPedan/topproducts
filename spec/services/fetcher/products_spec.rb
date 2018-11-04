require 'rails_helper'

RSpec.describe Fetcher::Products do
  let(:catalog) { Nokogiri::XML(file_fixture('catalog.xml')) }

  subject { described_class.new(catalog).fetch }

  describe '#fetch' do
    let(:first_product) { subject.first }
    let(:second_product) { subject.second }
    let(:first_product_name) { 'product #1' }
    let(:second_product_name) { 'product #2' }

    it { expect(subject.count).to eq(3) }
    it { expect(first_product.external_id).to eq(0) }
    it { expect(second_product.external_id).to eq(1) }
    it { expect(first_product.name).to eq(first_product_name) }
    it { expect(second_product.name).to eq(second_product_name) }
  end
end
