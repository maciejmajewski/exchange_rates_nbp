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

  describe '#exchange_table_number' do
    subject(:exchange_table_number) do
      described_class.exchange_table_number(date)
    end

    let(:date) { Date.new(2016, 2, 1) }

    it 'fetches currency table number', :vcr do
      expect(exchange_table_number).to eq("020/A/NBP/2016")
    end
  end  

  describe '#exchange_table_date' do
    subject(:publish_date) do
      described_class.exchange_table_date(date)
    end

    let(:date) { Date.new(2016, 2, 7) }

    it 'fetches currency table publish date', :vcr do
      expect(publish_date).to eq( Date.new(2016, 2, 5) )
    end
  end 

end
