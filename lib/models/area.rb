class Area
  include DataMapper::Resource
  property :name, String, :required => true, :key => true
  property :empty, String, :default => ''
  has n , :terms, :through => Resource, :order => [:fondness.desc]

  def self.find_terms(area_name, term)
    area = Area.first(:name => area_name)
    if area
      area.terms.all(:fields => [:name], 
                     :name.like => '%'+term.downcase+'%', 
                     :order => [:fondness.desc], :limit => 10) 
    end
  end

  def name=(name)
    super(name.downcase)
  end
  
  def self.exists(area)
    return Area.count(:name.like => area.downcase) != 0
  end
end
