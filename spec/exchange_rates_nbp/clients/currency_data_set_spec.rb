describe ExchangeRatesNBP::Clients::CurrencyDataSet do
  describe '.exchange_rate', :vcr do
    subject(:currency_exchange_rate) do
      described_class.new(table_id).exchange_rate(currency_code)
    end

    let(:table_id) { 'a044z160304' }

    context 'when currency code is incorrect' do
      let(:currency_code) { 'ABC' }

      it 'raises an exception' do
        expect { currency_exchange_rate }
          .to raise_error(/Invalid currency code: #{currency_code}/)
      end
    end

    context 'when currency code is correct' do
      let(:currency_code) { 'EUR' }

      it 'returns exchange rate' do
        expect(currency_exchange_rate[:exchange_rate]).to eq(4.334)
      end

      it 'returns publish date' do
        expect(currency_exchange_rate[:publish_date])
          .to eq(Date.new(2016, 3, 4))
      end

      it 'returns conversion factor' do
        expect(currency_exchange_rate[:conversion_factor]).to eq(1)
      end
    end
  end
end
