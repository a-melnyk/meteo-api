class ObservationFetcherService

  attr_reader :errors

  def self.call
    new.tap(&:perform)
  end

  def perform
    ActiveRecord::Base.transaction do
      return true if process

      @errors[:service] << 'unknown error' if @errors.empty?
      raise ActiveRecord::Rollback
    end

    puts 'Error: ' + @errors.map { |k, v| v.map { |msg| "#{k.to_s.humanize} #{msg}" } }.flatten
    false
  end

  def success?
    @errors.empty?
  end

  private

  def initialize
    @errors = {}
  end

  def process
    fetch && save
  end

  def fetch
    connection = Faraday.new 'http://api.openweathermap.org/data/2.5/weather' do |conn|
      conn.response :json, content_type: /\bjson$/
      conn.adapter Faraday.default_adapter
    end

    @response = connection.get '', {
      id: ENV['OPENWEATHERMAP_CITY_ID'],
      APPID: ENV['OPENWEATHERMAP_APP_KEY'],
      units: ENV['OPENWEATHERMAP_UNITS']
    }

    @errors[:request] = "Status: #{@response.status}, reason: #{@response.reason_phrase}" unless @response.success?
    @response.success?
  end

  def save
    observation = Observation.find_or_create_by(time: DateTime.strptime(@response.body['dt'].to_s, '%s')) do |ob|
      ob.temperature = @response.body['main']['temp']
      ob.pressure = @response.body['main']['pressure']
      ob.humidity = @response.body['main']['humidity']
    end

    @errors[:observation_record] = observation.errors.messages
    observation.persisted?
  end
end
