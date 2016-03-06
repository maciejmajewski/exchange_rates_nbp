describe ExchangeRatesNBP::Clients::CurrencyDataSet do
  describe '.exchange_rate', :vcr do
    let(:table_id) { 'a044z160304' }

    subject { described_class.new(table_id) }

    context 'given incorrect currency code' do
      let(:currency_code) { 'ABC' }

      it 'raises an exception' do
        expect { subject.exchange_rate(currency_code) }
          .to raise_error(/Invalid currency code: #{currency_code}/)
      end
    end

    context 'given correct currency code' do
      let(:currency_code) { 'EUR' }

      let(:hash) { subject.exchange_rate(currency_code) }

      it 'returns exchange rate' do
        expect(hash[:exchange_rate]).to eq(4.334)
      end

      it 'returns publish date' do
        expect(hash[:publish_date]).to eq(Date.new(2016, 3, 4))
      end

      it 'returns conversion factor' do
        expect(hash[:conversion_factor]).to eq(1)
      end
    end
  end
end
