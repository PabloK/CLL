class Ability
  include DataMapper::Resource

  property :name, String, :required => true, :key => true

  # A measurement of how much this ability is embraced
  property :number_of_inclusions, Integer, :required => true, :default => 1
  property :embracement, Float, :required => true, :default => 1.0

  # A measurement of how much this ability is rejected
  property :number_of_complaints, Integer, :required => true, :default => 0
  property :ostracisity, Float, :required => true, :default => 0.0
  property :fondness, Float, :required => true, :default => 1.0
  validates_length_of :name, :min => 3, :max => 32
  
  has n, :areas, :through => Resource

  # Embrace the ability
  def embrace!
    if @number_of_inclusions <= 300 
      number_of_inclusions = @number_of_inclusions + 1
      embracement = 10.0*Math.atan((number_of_inclusions.to_f-30.0)/10.0)/(Math::PI/2.0)+10.0
      fondness = determine_fondness(embracement,@ostracisity)
      update!(:number_of_inclusions => number_of_inclusions,
              :embracement => embracement,
              :fondness => fondness)
    end
  end

  # Defame the ability
  def ostracize!
    if @number_of_complaints <= 300 
      number_of_complaints = @number_of_complaints + 1
      ostracisity = 8.0*Math.atan((number_of_complaints.to_f-30.0)/10.0)/(Math::PI/2.0)+8.0
      fondness = determine_fondness(@embracement,ostracisity)
      update!(:number_of_inclusions => number_of_inclusions,
              :ostracisity => ostracisity,
              :fondness => fondness)
    end
  end

  # Embrace or create the ability if it is used
  def self.use_ability(area ,ability)
      return false if ability.length < 3 or ability.length > 32 
      unless Ability.exists(ability)
         new_ability = Ability.new
         new_ability.name = ability
         new_ability.areas << Area.get(area)
         if new_ability
           new_ability.save 
         else
          nil
          #TODO error report
         end
      else
        current_ability = Ability.first(:name => ability)
        current_ability.embrace!
      end

      return ability
  end

  def self.exists(ability)
    return Ability.count(:name.like => ability.downcase) != 0
  end

  def self.find_abilitys(ability)
    all(:fields => [:name], :name.like => '%'+ability.downcase+'%', :order => [:fondness.desc],:limit => 10)
  end

  def name=(name)
    super(name.downcase)
  end

  # Calculate the fondness of a ability
  private
  def determine_fondness(embracement, ostracisity)
     return embracement - ostracisity
  end

end
