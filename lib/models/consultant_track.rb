class ConsultantTrack
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, String, :required => true
  has n , :abilities, :through => Resource, :order => [:fondness.desc]

  def name=(name)
    super(name.downcase)
  end

  def self.exists(consultant_track)
    return ConsultantTrack.count(:name.like => consultant_track.downcase) != 0
  end
  
  def has_ability? (ability_id)
    self.abilities.each do |ability|
      return true if ability_id == ability.id
    end
    return false
  end
end
