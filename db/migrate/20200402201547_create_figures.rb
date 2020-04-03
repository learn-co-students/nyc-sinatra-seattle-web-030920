class CreateFigures < ActiveRecord::Migration
  def change
    create_table :figures do |t|
      t.string :name 

      t.timestamps
    end 
  end
end
