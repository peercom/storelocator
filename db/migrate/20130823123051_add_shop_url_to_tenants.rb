class AddShopUrlToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :shop_url, :string
  end
end
