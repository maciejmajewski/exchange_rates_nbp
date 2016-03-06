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

      it 'returns exchange rate' do
        expect(subject.exchange_rate(currency_code)).to eq(4.334)
      end
    end
  end
end
