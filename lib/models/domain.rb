class Domain
  include DataMapper::Resource
  property :name, String, :required => true, :key => true
  has n , :areas, :through => Resource

  def name=(name)
    super(name.downcase)
  end
  
  def self.exists(area)
    return Domain.count(:name.like => Domain.downcase) != 0
  end
end
