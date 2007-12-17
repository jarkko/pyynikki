class CreateRunners < ActiveRecord::Migration
  def self.up
    create_table :runners do |t|
      t.integer :birth_year
      t.string :first_name, :last_name, :sex
      t.boolean :outsider, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :runners
  end
end
