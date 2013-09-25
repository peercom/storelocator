class AddCenterLatAndLngToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :center_lat, :float
    add_column :tenants, :center_lng, :float
  end
end
