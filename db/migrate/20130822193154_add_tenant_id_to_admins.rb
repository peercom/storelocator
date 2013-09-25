class AddTenantIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :tenant_id, :integer
  end
end
