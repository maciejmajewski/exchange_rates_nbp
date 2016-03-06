require 'oga'

module ExchangeRatesNBP
  module Clients
    class CurrencyDataSet
      SELECTOR_CURRENCY_ELEMENT = 'tabela_kursow pozycja'.freeze
      FIELD_AVERAGE_CURRENCY_CODE = 'kurs_sredni'.freeze
      FIELD_CURRENCY_CODE = 'kod_waluty'.freeze

      def initialize(table_id)
        @table_id = table_id
      end

      def exchange_rate(currency_code)
        doc = Oga.parse_xml(data).css(SELECTOR_CURRENCY_ELEMENT).detect do |p|
          p.css(FIELD_CURRENCY_CODE).text == currency_code
        end

        raise "Invalid currency code: #{currency_code}" if doc.nil?

        doc.css(FIELD_AVERAGE_CURRENCY_CODE).text.tr(',', '.').to_f
      end

      private

      def data
        HTTP.get(BASE_URL + "#{@table_id}.xml").to_s
      end
    end
  end
end
