class Event < ActiveRecord::Base
  has_many :runs
  validates_presence_of :event_date
  validates_uniqueness_of :event_date
  
  def all_results
    result = {}
    [3600, 7600, 15200].each do |length|
      result[length] = runs.find_results_for(length)
    end
    result
  end
  
  def to_param
    event_date.to_s
  end
end
