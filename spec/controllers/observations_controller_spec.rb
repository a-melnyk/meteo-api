require 'rails_helper'

describe ObservationsController do
  let(:token) { double :acceptable? => true }

  describe 'GET #index' do
    before do
      allow(controller).to receive(:doorkeeper_token) {token}
      FactoryGirl.create_list(:observation, 3)
      get :index
    end

    it 'responses with JSON' do
      expect(response.header['Content-Type']).to include 'application/json'
    end

    it 'returns correct number of observations' do
      json = JSON.parse(response.body)
      expect(json['data'].count).to eq(3)
    end
  end
end