
Admin.create([
  { :email => "info@example.com", :encrypted_password => "$2a$10$mHi/OhRKCMMGnzR3PgF/subjluunOwKVWeTVwL/Xuj1UsxtBa3QT2", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :created_at => nil, :updated_at => nil, :tenant_id => nil }
], :without_protection => true )


Tenant.create([
  { :name => "Me!", :host => "localhost", :locale => "de", :created_at => "2013-08-22 16:20:05", :updated_at => "2013-08-22 16:20:05", :center_lat => 51.5369, :center_lng => 9.92683, :shop_url => "http://www.rubyonrails.org", :shop_name => "Example Store" }
], :without_protection => true )


