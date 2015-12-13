class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.integer :x
      t.integer :y
      t.integer :player
      t.string :result

      t.timestamps null: false
    end
  end
end
