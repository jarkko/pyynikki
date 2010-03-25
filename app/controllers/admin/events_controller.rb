class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.order("event_date desc").all.group_by{|e| e.event_date.year}
    @years = @events.keys.sort.reverse
  end
  
  def new
    @page_title = "Lisää uusi juoksu"
    @event = Event.new(:event_date => Date.today)
  end
  
  def create
    @event = Event.new(params[:event])
    
    if @event.save
      redirect_to [:admin, @event]
    else
      render :action => "new"
    end
  end
  
  def show
    @event = Event.find_by_event_date(params[:id])
    return not_found unless @event
    @page_title = @event.event_date.to_finnish
    @results = @event.all_results
  end
end