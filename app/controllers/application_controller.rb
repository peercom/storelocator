class ApplicationController < ActionController::Base
  protect_from_forgery
  
  around_filter :with_tenant

  protected
    attr_reader :current_tenant

    def with_tenant
      @current_tenant = Tenant.find_by_host!(request.host)
      I18n.locale = @current_tenant.locale || I18n.default_locale
      @current_tenant.with { yield }
    rescue ActiveRecord::RecordNotFound
      render "no_such_tenant"
    end
      
end
