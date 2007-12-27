class Runner < ActiveRecord::Base
  has_many :runs
  
  def record_run(split)
    @record_run ||= {}
    
    @record_run[split] ||= runs.min do |a,b|
      if a.record(split).nil?
        1
      elsif b.record(split).nil?
        -1
      else
        a.record(split) <=> b.record(split)
      end
    end
    
    @record_run[split] = nil if @record_run[split].record(split) == nil
    
    @record_run[split]
  end
  
  def record_time(split)
    run = record_run(split)
    return nil unless run
    run.record(split)
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def age(at = Time.now)
    at.year - birth_year
  end
  
  def age_class(at = Time.now)
    classes = {8  => 7..8,
               10 => 9..10,
               12 => 11..12,
               14 => 13..14,
               16 => 15..16,
               18 => 17..18,
               20 => 19..20,
               21 => 21..34,
               35 => 35..39,
               40 => 40..44,
               45 => 45..49,
               50 => 50..54,
               55 => 55..59,
               60 => 60..64,
               65 => 65..999}
               
    classes.find{|k,v| v === age(at)}.first
  end
  
  def age_class_with_gender(at = Time.now)
    "#{sex}#{age_class(at)}"
  end
  
  def to_param
    "#{id}-#{name.strip.downcase.gsub(/\s/, "-").gsub(/[^\w\-]/, "")}"
  end
end
