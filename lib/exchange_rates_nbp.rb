require 'exchange_rates_nbp/version'

require 'http'

require 'exchange_rates_nbp/clients/table_list'
require 'exchange_rates_nbp/clients/currency_data_set'

module ExchangeRatesNBP
  BASE_URL = 'http://www.nbp.pl/kursy/xml/'.freeze
  FILE_NAME_YEAR_PATTERN = 'dir{year}.txt'.freeze
  FILE_NAME_CURRENT_YEAR = 'dir.txt'.freeze

  # 'xnnnzrrmmdd.xml'

  TABLE_TYPES = {
    middle_exchange_rates_table_a: 'a',
    middle_exchange_rates_table_b: 'b',
    buy_and_sell_table: 'c',
    settlement_units_table: 'h'
  }.freeze

  DEFAULT_TABLE_TYPES = TABLE_TYPES.values.first

  def self.exchange_rate(date, currency_code, table = DEFAULT_TABLE_TYPES)
    exchange_rate_info(date, currency_code, table)[:exchange_rate]
  end

  def self.exchange_rate_info(date, currency_code, table = DEFAULT_TABLE_TYPES)
    table_id = find_table_id(date, table)
    exchange_rate_hash(table_id, currency_code)
  end

  class << self
    private

    def find_table_id(date, table)
      Clients::TableList.new(date.year, table).fetch_closest_to(date)
    end

    def exchange_rate_hash(table_id, currency_code)
      ExchangeRatesNBP::Clients::CurrencyDataSet
        .new(table_id)
        .exchange_rate(currency_code)
    end
  end
end
