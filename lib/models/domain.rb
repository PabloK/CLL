class Domain
  include DataMapper::Resource
  property :name, String, :required => true, :key => true
  has n , :areas, :through => Resource

  def name=(name)
    super(name.downcase)
  end
  
  def self.exists(domain)
    return Domain.count(:name.like => domain.downcase) != 0
  end
end
