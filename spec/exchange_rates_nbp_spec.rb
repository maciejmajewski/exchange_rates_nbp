require 'spec_helper'

describe ExchangeRatesNBP do
  it 'has a version number' do
    expect(ExchangeRatesNBP::VERSION).not_to be nil
  end

  describe '#exchange_rate' do
    subject(:exchange_rate) do
      described_class.exchange_rate(date, currency_code)
    end

    let(:date) { Date.new(2016, 2, 1) }
    let(:currency_code) { 'JPY' }

    it 'fetches currency code', :vcr do
      expect(exchange_rate).to eq(3.3524)
    end
  end
end
