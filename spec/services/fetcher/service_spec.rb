require 'rails_helper'

RSpec.describe Fetcher::Service do
  let(:catalog) { file_fixture('catalog.xml') }

  subject { described_class.new(catalog).fetch }

  describe '#fetch' do
    it { expect(subject.count).to eq(3) }
  end
end
