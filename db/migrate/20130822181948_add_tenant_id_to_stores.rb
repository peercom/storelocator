class AddTenantIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :tenant_id, :integer
  end
end
