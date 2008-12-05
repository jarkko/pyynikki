class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.date :event_date
      t.integer :temperature
      t.string :weather
      t.text :story
      t.timestamps
    end
    
    add_index :events, :event_date
  end

  def self.down
    remove_index :events, :event_date
    drop_table :events
  end
end