class Runner < ActiveRecord::Base
  has_many :runs
  
  def record_run(split)
    runs.min do |a,b|
      if a.record(split).nil?
        1
      elsif b.record(split).nil?
        -1
      else
        a.record(split) <=> b.record(split)
      end
    end
  end
  
  def record_time(split)
    run = record_run(split)
    return nil unless run
    run.record(split)
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end
