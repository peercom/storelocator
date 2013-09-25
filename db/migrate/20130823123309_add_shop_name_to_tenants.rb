class AddShopNameToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :shop_name, :string
  end
end
