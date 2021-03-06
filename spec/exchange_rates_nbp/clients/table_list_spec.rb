describe ExchangeRatesNBP::Clients::TableList do
  describe '.fetch_closest_to' do
    subject(:closest_date) do
      described_class.new(year, table_type).fetch_closest_to(date)
    end

    let(:table_type) { 'a' }

    let(:date) { Date.today }

    context 'when year is unsupported' do
      let(:year) { 1999 }

      it 'raises exception' do
        expect { closest_date }
          .to raise_error('Data for nbp.pl is available from 2002 onwards')
      end
    end

    context 'when year is in the future' do
      let(:year) { 2017 }

      before do
        Timecop.freeze(Time.local(2016))
      end

      after do
        Timecop.return
      end

      it 'raises exception' do
        expect { closest_date }
          .to raise_error("Can't fetch data for the future")
      end
    end

    context 'when date is at beginning of the year' do
      let(:date) { Date.new(2016, 1, 1) }
      let(:year) { date.year }

      it 'returns table ID from previous year', :vcr do
        expect(closest_date).to match(/^a[0-9]{3}z151231$/)
      end
    end

    context 'when date is at beginning of the year '\
            'before tables are published' do
      let(:date) { Date.new(2017, 1, 1) }
      let(:year) { date.year }

      it 'returns table ID from previous year', :vcr do
        expect(closest_date).to match(/^a[0-9]{3}z161230$/)
      end
    end

    context 'when table for given date exists' do
      let(:date) { Date.new(2016, 3, 4) }
      let(:year) { date.year }

      it 'returns table ID for this', :vcr do
        expect(closest_date).to match(/^a[0-9]{3}z160304$/)
      end
    end

    context 'when date is in the future' do
      let(:date) { Date.new(2016, 3, 6) }
      let(:year) { date.year }

      it 'returns table ID for this', :vcr do
        expect(closest_date).to match(/^a[0-9]{3}z160304$/)
      end
    end
  end
end
