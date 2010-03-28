class Admin::RunsController < Admin::BaseController
  def create
    @event = Event.find_by_event_date(params[:event_id])
    @run = @event.runs.build(params[:run])
    
    if @run.save
      redirect_to [:admin, @event]
    else
      render :template => "admin/events/show"
    end
  end
end