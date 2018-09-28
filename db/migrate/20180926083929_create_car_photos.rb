class CreateCarPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :car_photos do |t|
      t.integer :car_id
      t.string :anh

      t.timestamps
    end
  end
end
