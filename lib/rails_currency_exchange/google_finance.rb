module RailsCurrencyExchange
  class GoogleFinance

    BASE_URI = 'www.google.com'
    BASE_PATH = '/finance/converter'

    def self.exchange_rate(from_iso_code, to_iso_code)
      uri = URI::HTTP.build(
        :host  => BASE_URI,
        :path  => BASE_PATH,
        :query => "a=1&from=#{from_iso_code}&to=#{to_iso_code}"
      )
      data = uri.read
      case data
      when /<span class=bld>(\d+\.?\d*) [A-Z]{3}<\/span>/
        $1.to_f
      when /Could not convert\./
        raise UnknownRate
      else
        raise GoogleCurrencyFetchError
      end
    end
  end
end
