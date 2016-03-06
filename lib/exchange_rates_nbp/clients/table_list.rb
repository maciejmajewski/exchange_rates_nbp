module ExchangeRatesNBP
  module Clients
    class TableList
      PATTERN = /[abch][0-9]{3}z[0-9]{6}/

      def initialize(year, table_type)
        @year = year
        @table_type = table_type

        validate_year
      end

      def fetch_closest_to(date)
        loop do
          table_id = table_id_for(date)
          return table_id unless table_id.nil?
          date -= 1
          return fetch_data_for_previous_year if date.year != @year
        end
      end

      private

      def validate_year
        raise 'Data for nbp.pl is available from 2002 onwards' if @year < 2002
        raise "Can't fetch data for the future" if @year > Date.today.year
      end

      def fetch_data_for_previous_year
        last_day = Date.new(@year - 1, 12, 31)
        self.class.new(@year - 1, @table_type).fetch_closest_to(last_day)
      end

      def table_id_for(date)
        date_string = date.strftime('%y%m%d')
        selected_table_ids.detect { |l| l =~ /#{date_string}$/ }
      end

      def selected_table_ids
        @selected_table_ids ||= all_table_ids.select do |table_id|
          table_id =~ /^#{@table_type}/
        end
      end

      def all_table_ids
        body = HTTP.get(BASE_URL + table_list_url, encoding: 'utf-8').to_s
        body.scan(PATTERN)
      end

      def table_list_url
        if @year == Date.today.year
          FILE_NAME_CURRENT_YEAR
        else
          FILE_NAME_YEAR_PATTERN.sub('{year}', @year.to_s)
        end
      end
    end
  end
end
