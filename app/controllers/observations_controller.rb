class ObservationsController < ApplicationController

  before_action :doorkeeper_authorize!

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: errors_json(e.message), status: :not_found
  end

  def index
    if params[:q]
      search = Observation.ransack(params[:q])
      observations = search.result
    else
      observations = Observation.all
    end
    render json: observations
  end

  private

  def errors_json(messages)
    { errors: [*messages] }
  end
end
