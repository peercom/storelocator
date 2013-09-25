class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :zip
      t.string :country
      t.string :state
      t.string :street
      t.string :city
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
  end
end
