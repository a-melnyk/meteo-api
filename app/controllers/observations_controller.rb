class ObservationsController < ApplicationController
  def index
    if params[:q]
      @search = Observation.ransack(params[:q])
      @observations = @search.result
    else
      @observations = Observation.all
    end
    render json: @observations
  end
end
