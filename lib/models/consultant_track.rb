class ConsultantTrack
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, String, :required => true
  has n , :abilitys, :through => Resource, :order => [:fondness.desc]

  def name=(name)
    super(name.downcase)
  end

  def self.exists(consultant_track)
    return ConsultantTrack.count(:name.like => consultant_track.downcase) != 0
  end
  
end
