class TenantScopedModel < ActiveRecord::Base
  
  @abstract_class = true
  
  belongs_to :tenant

  default_scope -> { where(:tenant_id => Tenant.current)}
    
end
