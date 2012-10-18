class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.integer :position
      t.boolean :completed
      
      t.timestamps
    end
  end
end
