require 'timeout'

class EventsController < ApplicationController

  def index
    @page_title = t 'app.common.test_runs'
    @events = Event.find(:all, :order => "event_date desc").group_by{|e| e.event_date.year}
    @years = @events.keys.sort.reverse
  end

  def show
    @event = Event.find_by_event_date(params[:id])
    return not_found unless @event
    @page_title = @event.event_date.to_finnish
    @results = @event.all_results
    
    begin
      @photos = Timeout::timeout(9) do
        TwentyThree.new.photos(:tags => "pyynikki, testrun", 
                                         :owner => "426283",
                                         :min_taken_date => @event.event_date.strftime("%Y-%m-%d"),
                                         :max_taken_date => (@event.event_date + 1).strftime("%Y-%m-%d"),
                                         :per_page => 10,
                                         :sort => "interestingness-desc")
      end
    rescue Timeout::Error, SocketError
      @photos = []
    end
  end
end
