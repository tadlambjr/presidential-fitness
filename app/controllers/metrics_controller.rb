class MetricsController < ApplicationController
  before_action :require_login

  def index
    @metric_entries = current_user.metric_entries.chronological
  end

  def new
    @metric_entry = current_user.metric_entries.new(recorded_on: Date.today)
  end

  def create
    @metric_entry = current_user.metric_entries.new(metric_entry_params)
    if @metric_entry.save
      redirect_to metrics_path, notice: "Metrics recorded successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def metric_entry_params
    params.require(:metric_entry).permit(
      :recorded_on,
      :broad_jump_inches,
      :throw_distance_inches,
      :push_ups,
      :sit_ups,
      :chin_ups,
      :pull_ups,
      :handstand_seconds,
      :flexibility_inches,
      :fifty_yard_dash_seconds,
      :one_mile_run_seconds,
      :shuttle_run_seconds,
      :rope_climb_seconds,
      :vertical_jump_inches,
      :notes
    )
  end
end
