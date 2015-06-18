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
        daily_exchange_rates
      end

      private

      def uri
        URI::HTTP.build(host: SERVICE_HOST, path: SERVICE_PATH)
      end

      def daily_exchange_rates
        RSS::Parser.parse(uri.read, false).items.
          each_with_object({'KZT_TO_KZT' => 1.0}) do |rate, rates|
            rates["KZT_TO_#{rate.title}"] = 1 / rate.description.to_f
            rates["#{rate.title}_TO_KZT"] = rate.description.to_f
          end
      end
    end
  end
end
