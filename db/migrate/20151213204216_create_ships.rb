class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :x
      t.integer :y
      t.integer :direction
      t.integer :size
      t.integer :player

      t.timestamps null: false
    end
  end
end
