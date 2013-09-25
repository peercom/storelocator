class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :host
      t.string :locale

      t.timestamps
    end
  end
end
