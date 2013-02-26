class Area
  include DataMapper::Resource
  property :name, String, :required => true, :key => true
  has n , :abilitys, :through => Resource, :order => [:fondness.desc]

  def self.find_abilitys(area_name, ability)
    area = Area.first(:name => area_name)
    if area and ability
      area.abilitys.all(:fields => [:name], 
                     :name.like => '%'+ability.downcase+'%', 
                     :number_of_inclusions.gt => $CONFIG[:min_num_of_inclusions_for_display],
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
