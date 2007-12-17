class Run < ActiveRecord::Base
  belongs_to :runner
  belongs_to :event
  
  def self.find_short(opts = {})
    find(:all,
         {:conditions => {:time7600 => nil,
                         :time11200 => nil,
                         :time15200 => nil},
         :order => "time3600"}.merge(opts))
  end
  
  def self.find_one_lap(opts = {})
    find(:all, 
         {:conditions => "time7600 is not null and time15200 is null",
         :order => "time7600"}.merge(opts))
  end
  
  def self.find_long(opts = {})
    find(:all, {:conditions => "time15200 is not null",
         :order => "time15200"}.merge(opts))
  end
  
  def self.find_results_for(length, *args)
    methods = {7600 => "one_lap",
               15200 => "long",
               3600 => "short"}
    send("find_" + methods[length], args)
  end
  
  def result(split)
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
  
  private
  
    def formatted_result(time)
      minutes = time / 60
      seconds = time % 60

      sprintf("%02d:%02d", minutes, seconds)
    end
end
