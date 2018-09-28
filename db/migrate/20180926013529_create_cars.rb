class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :bien_so
      t.integer :so_cho

      t.timestamps
    end
  end
end
