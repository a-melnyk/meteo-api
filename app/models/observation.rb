class Observation < ApplicationRecord
  def self.fetch
    connection = Faraday.new 'http://api.openweathermap.org/data/2.5/weather' do |conn|
      conn.response :json, content_type: /\bjson$/
      conn.adapter Faraday.default_adapter
    end

    response = connection.get '', {
      id: ENV['OPENWEATHERMAP_CITY_ID'],
      APPID: ENV['OPENWEATHERMAP_APP_KEY'],
      units: ENV['OPENWEATHERMAP_UNITS']
    }

    Observation.find_or_create_by!(time: DateTime.strptime(response.body['dt'].to_s, '%s')) do |ob|
      ob.temperature = response.body['main']['temp']
      ob.pressure = response.body['main']['pressure']
      ob.humidity = response.body['main']['humidity']
    end
  end
end
