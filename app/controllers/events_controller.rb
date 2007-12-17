class EventsController < ApplicationController

  def index
  end

  def show
    @event = Event.find_by_event_date(params[:id])
    return not_found unless @event
    @results = @event.all_results
  end
end