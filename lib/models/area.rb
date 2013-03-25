#encoding: utf-8
class Area
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, String, :required => true
  has n , :abilities, :through => Resource, :order => [:fondness.desc]

  def self.find_abilities(area_id, ability)
    area = Area.first(area_id)
    if area and ability
      area.abilities.all(:fields => [:name, :fondness], 
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
