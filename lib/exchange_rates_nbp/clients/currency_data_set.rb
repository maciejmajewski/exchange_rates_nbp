require 'oga'

module ExchangeRatesNBP
  module Clients
    class CurrencyDataSet
      SELECTOR_CURRENCY_ELEMENT = 'tabela_kursow pozycja'.freeze

      FIELD_AVERAGE_EXCHANGE_RATE = 'kurs_sredni'.freeze
      FIELD_CURRENCY_CODE = 'kod_waluty'.freeze
      FIELD_TABLE_NAME = 'numer_tabeli'.freeze
      FIELD_PUBLISH_DATE = 'data_publikacji'.freeze
      FIELD_CONVERSION_FACTOR = 'przelicznik'.freeze

      def initialize(table_id)
        @table_id = table_id
      end

      def exchange_rate(currency_code)
        xml = Oga.parse_xml(data)

        doc = selected_currency_element(xml, currency_code)

        currency_element_to_hash(xml, doc)
      end

      private

      def currency_element_to_hash(xml, doc)
        {
          exchange_rate: to_exchange_rate(doc),
          publish_date: to_publish_date(xml),
          conversion_factor: to_conversion_factor(doc)
        }
      end

      def to_publish_date(xml)
        Date.parse(xml.css(FIELD_PUBLISH_DATE).text)
      end

      def to_exchange_rate(doc)
        doc.css(FIELD_AVERAGE_EXCHANGE_RATE).text.tr(',', '.').to_f
      end

      def to_conversion_factor(doc)
        doc.css(FIELD_CONVERSION_FACTOR).text.to_i
      end

      def selected_currency_element(xml, currency_code)
        doc = xml.css(SELECTOR_CURRENCY_ELEMENT).detect do |p|
          p.css(FIELD_CURRENCY_CODE).text == currency_code
        end

        raise "Invalid currency code: #{currency_code}" if doc.nil?

        doc
      end

      def data
        HTTP.get(BASE_URL + "#{@table_id}.xml").to_s
      end
    end
  end
end
