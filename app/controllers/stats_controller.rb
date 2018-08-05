class StatsController < ApplicationController
  before_action :validate_params

  def word_statistics
    @stat = Stat.first
    render json: { count: @stat.words[params[:input]] || 0 }
  end

  def word_counter
    StatsJob.perform_async(params[:input])
    head :ok
  end

  private

    def validate_params
      params.require(:input)
    end
end
