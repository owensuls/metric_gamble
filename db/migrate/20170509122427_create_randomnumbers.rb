class CreateRandomnumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :randomnumbers do |t|
      t.integer :number
      t.string :name

      t.timestamps
    end
  end
end
