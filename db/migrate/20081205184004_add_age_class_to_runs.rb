class AddAgeClassToRuns < ActiveRecord::Migration
  def self.up
    add_column :runs, :age_class, :string
    
    Run.find(:all).each do |run|
      run.update_attribute(:age_class,
                  run.runner.age_class_with_gender(run.event.event_date))
    end
  end

  def self.down
    remove_column :runs, :age_class
  end
end
