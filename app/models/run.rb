class Run < ActiveRecord::Base
  DISTANCES = {7600 => "one_lap",
               15200 => "long",
               3600 => "short"}
  
  belongs_to :runner
  belongs_to :event
  
  validates_presence_of :runner_id, :event_id
  validates_associated :runner, :event
    
  #  3600 = short
  #  7600 = one_lap
  # 11200 = 3600 + 7600
  # 15200 = 7600 + 7600 = long
  scope :short, where({:time7600 => nil,
                       :time11200 => nil,
                       :time15200 => nil}).
                order("time3600").
                includes(:runner)
  
  # includes 11200. does it matter at all?
  scope :one_lap,
        where("time7600 is not null and time15200 is null").
        order("time7600").
        includes(:runner)
  
  scope :long,
        where("time15200 is not null").
        order("time15200").
        includes(:runner)
        
  scope :for_distance, lambda {|length|
          send(Run::DISTANCES[length.to_i])
        }
  
  scope :recent, 
        order("events.event_date desc").
        includes(:event)
  
  def self.find_recent
    runs = recent
    return {} if runs.blank?
    runs.group_by do |item|
      item.event.event_date.year
    end
  end
  
  def result(split = latest_split)
    method = "time" + split.to_s
    return nil unless respond_to?(method)
    
    time = send(method)
    return nil unless time
    
    formatted_result(time)
  end
  
  # the method to be used for tracking runner records. The difference
  # to result is that record for 3600 and 7600 can also be from the
  # second lap of a two-lap run
  def record(split)    
    if [11200, 15200].include?(split.to_i)
      return result(split)
    end
    
    time = case split.to_i
    when 3600
      (time11200 && time7600) ? 
        time11200.to_i - time7600.to_i : time3600
    when 7600
      time15200.to_i - time7600.to_i
    else
      nil
    end
    
    if time.nil?
      nil
    elsif time < 0
      result(split)
    elsif result(split).nil?
      split.to_i == 7600 ? nil : formatted_result(time)
    else
      [result(split), formatted_result(time)].min
    end
  end
  
  # (5:00, 10:00, 16:40)
  def splits
    case latest_split
    when 15200
      splits = [result(3600), result(7600), result(11200)].compact
      splits.empty? ? "" : "(#{splits.join(", ")})"
    when 7600
      result(3600) ? "(#{result(3600)})" : ""
    else
      ""
    end      
  end
  
  # latest_split in km-s
  def length
    return nil unless latest = latest_split
    "#{latest / 1000.0} km"
  end
  
  [15200, 11200, 7600, 3600].each do |length|
    define_method("time#{length}=") do |time|
      write_attribute("time#{length}", sanitize_time(time))
    end
  end
  
  private
  
    def formatted_result(time)
      minutes = time / 60
      seconds = time % 60

      sprintf("%02d:%02d", minutes, seconds)
    end
    
    # latest_split in meters
    def latest_split
      [15200, 7600, 3600].each do |length|
        return length if send("time#{length}")
      end
      return nil
    end
    
    def sanitize_time(time)
      Rails.logger.debug("sanitizing #{time}")
      if time.blank?
        nil
      else
        mins, secs = time.to_s.split(/[\.\:]/)
        mins.to_i * 60 + secs.to_i
      end
    end
end
