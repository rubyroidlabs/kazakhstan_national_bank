require 'kazakhstan_national_bank/version'
require 'money'
require 'open-uri'
require 'rss'

class Money
  module Bank
    class KazakhstanNationalBank < Money::Bank::VariableExchange
      SERVICE_HOST = 'www.nationalbank.kz'
      SERVICE_PATH = '/rss/rates_all.xml'

      def update_rates
        update_parsed_rates(daily_exchange_rates)
        @rates
      end

      private

      def uri
        URI::HTTP.build(host: SERVICE_HOST, path: SERVICE_PATH)
      end

      def daily_exchange_rates
        RSS::Parser.parse(uri.read, false).items
      end

      def update_parsed_rates(rates)
        add_rate('KZT', 'KZT', 1)
        rates.each do |rate|
          begin
            if local_currencies.include?(rate.title)
              add_rate('KZT', rate.title, 1 / rate.description.to_f)
              add_rate(rate.title, 'KZT', rate.description.to_f)
            end
          rescue Money::Currency::UnknownCurrency
          end
        end
      end

      def local_currencies
        @local_currencies ||= Money::Currency.table.map { |currency| currency.last[:iso_code] }
      end
    end
  end
end
