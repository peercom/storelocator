class Store < ActiveRecord::Base

  belongs_to :tenant
  
  attr_accessible :city, :country, :gmaps, :latitude, :longitude, :name, :state, :street, :zip
  acts_as_gmappable :process_geocoding => :geocode?, :msg => "Sorry, not even Google could figure out where that is",
                    :address => "address"
                    
  scope :near, lambda{ |*args|
    origin = *args.first[:origin]
    if (origin).is_a?(Array)
      origin_lat, origin_lng = origin
    else
      origin_lat, origin_lng = origin.lat, origin.lng
    end
    origin_lat, origin_lng = deg2rad(origin_lat), deg2rad(origin_lng)
    within = *args.first[:within]
    {
      :conditions => %(
      (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(stores.latitude))*COS(RADIANS(stores.longitude))+
      COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(stores.latitude))*SIN(RADIANS(stores.longitude))+
      SIN(#{origin_lat})*SIN(RADIANS(stores.latitude)))*3963) <= #{within[0]} AND tenant_id = #{Tenant.current.id}
      ),
      :select => %( stores.*,
      (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(stores.latitude))*COS(RADIANS(stores.longitude))+
      COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(stores.latitude))*SIN(RADIANS(stores.longitude))+
      SIN(#{origin_lat})*SIN(RADIANS(stores.latitude)))*3963) AS distance
      )
    }
  }

  def address
    "#{self.street}, #{self.zip} #{self.city}, #{self.country}" 
  end
  
  def address_changed?
    (street_changed? || zip_changed? || city_changed? || country_changed?)
  end
   
  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end
  
  def self.search(search)
   unless search.nil? 
     location = Gmaps4rails.geocode(search[:address], true)
   end
   unless location.nil?
     result =  Store.near(:origin =>[location[0][:lat], location[0][:lng]], :within => 62)
   else
     result = []
   end
   result
  end
  
  private
  
  def self.deg2rad(deg)
    radians = deg * Math::PI / 180 
  end
end
