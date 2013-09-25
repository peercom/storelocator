class Tenant < ActiveRecord::Base
  attr_accessible :host, :locale, :name
  
  class << self
      def current
        Thread.current[:current_tenant]
      end

      def current=(tenant)
        Thread.current[:current_tenant] = tenant
      end
    end
    
    validates :name, :host, presence: true

    def with
      previous, Tenant.current = Tenant.current, self
      yield
    ensure
      Tenant.current = previous
    end
end
