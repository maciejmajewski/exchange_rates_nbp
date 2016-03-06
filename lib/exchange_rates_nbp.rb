require 'exchange_rates_nbp/version'

require 'http'

require 'exchange_rates_nbp/clients/table_list'

module ExchangeRatesNBP
  BASE_URL = 'http://www.nbp.pl/kursy/xml/'
  FILE_NAME_YEAR_PATTERN = 'dir{year}.txt'.freeze
  FILE_NAME_CURRENT_YEAR = 'dir.txt'.freeze

  # 'xnnnzrrmmdd.xml'

  TABLE_TYPES = {
    middle_exchange_rates_table_a: 'a',
    middle_exchange_rates_table_b: 'b',
    buy_and_sell_table: 'c',
    settlement_units_table: 'h'
  }

  DEFAULT_TABLE_TYPES = TABLE_TYPES.values.first

  def self.exchange_rate(date, currency, table = DEFAULT_TABLE_TYPES)
    table_id = find_table_id(date, table)
    table = retrieve_table(table_id)
    extract_currency(table, currency)
  end

  private

  def self.find_table_id(date, table)
    Clients::TableList.new(date.year, table).fetch_closest(date)
  end
end
