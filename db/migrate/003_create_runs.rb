class CreateRuns < ActiveRecord::Migration
  def self.up
    create_table :runs do |t|
      t.integer :runner_id, :event_id, 
                :time3600, :time7600,
                :time11200, :time15200
      t.boolean :outsider, :default => false
      t.timestamps
    end
    
    add_index :runs, :runner_id
    add_index :runs, :event_id
  end

  def self.down
    remove_index :runs, :runner_id
    remove_index :runs, :event_id
    drop_table :runs
  end
end
