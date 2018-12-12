class Workshop
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property :start_date,   Date,    :required => true, :default => Chronic.parse('now')
  property :end_date,     Date,    :required => true, :default => Chronic.parse('tomorrow')
  property :venue,        String,  :required => true
  property :description,  Text 
  property :program,      Text
  property :location,     Text
  property :address1,     Text
  property :address2,     Text
  property :city,         String
  property :state,        String
  property :zip,          String
  property :time,         String, :length => 255
  property :price1,       String, :length => 255
  property :price2,       String
  property :auth_code,    Text
  
  property :special,   Boolean, default: false

  has n, :reservations, :constraint => :destroy
  
  def self.upcoming
    all(:end_date.gte => Chronic.parse('now'))
  end
  
  def self.expired
    all(:end_date.lt => Chronic.parse('now'))
  end
  
  def self.total
    all(:end_date.lt => Chronic.parse('now')).count + 126
  end
  
  def specialid
    all(:special => 't')
  end
  
end