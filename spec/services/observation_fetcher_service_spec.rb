require 'rails_helper'

describe ObservationFetcherService, :vcr do
  after(:each) { Dotenv.overload }
  context 'when all is ok' do
    it 'successfully fetch and save observation' do
      result = described_class.()
      expect(result.errors.empty?).to eq true
      expect(result.success?).to eq true
      expect(Observation.count).to eq 1
    end
  end

  context 'when something wrong' do

    context 'when city ID is invalid' do
      before { ENV['OPENWEATHERMAP_CITY_ID'] = '0' }

      it 'unsuccessfully check with invalid city' do
        result = described_class.()
        expect(Observation.count).to eq 0
        expect(result.errors.empty?).to eq false
        expect(result.success?).to eq false
        expect(result.errors).to include(request: 'Status: 502, reason: Bad Gateway')
      end
    end

    context 'when city API key is empty' do
      before { ENV['OPENWEATHERMAP_APP_KEY'] = '' }

      it 'unsuccessfully check with invalid API key' do
        result = described_class.()
        expect(Observation.count).to eq 0
        expect(result.errors.empty?).to eq false
        expect(result.success?).to eq false
        expect(result.errors).to include(request: 'Status: 401, reason: Unauthorized')
      end
    end
  end
end
