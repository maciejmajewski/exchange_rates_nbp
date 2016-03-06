require 'spec_helper'

describe ExchangeRatesNBP do
  it 'has a version number' do
    expect(ExchangeRatesNBP::VERSION).not_to be nil
  end

  describe '#exchange_rate' do
    let(:date) { Date.new(2016, 2, 1) }
    let(:currency_code) { 'JPY' }

    subject { described_class.exchange_rate(date, currency_code) }

    it 'fetches currency code', :vcr do
      expect(subject).to eq(3.3524)
    end
  end
end
