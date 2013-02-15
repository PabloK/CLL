class Term
  include DataMapper::Resource

  property :name, String, :required => true, :key => true
  # A measurement of how much this term is embraced
  property :number_of_inclusions, Integer, :required => true, :default => 1
  property :embracement, Float, :required => true, :default => 1.0
  # A measurement of how much this term is rejected
  property :number_of_complaints, Integer, :required => true, :default => 0
  property :ostracisity, Float, :required => true, :default => 0.0
  property :fondness, Float, :required => true, :default => 1.0

  # Embrace the term
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

  # Defame the term
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

  # Calculate the fondness of a term
  def determine_fondness(embracement, ostracisity)
     return embracement - ostracisity
  end

  # Embrace or create the term if it is used
  def self.use_term(term)
      unless Term.exists(term)
        Term.create(:name => term)
      else
        current_term = Term.first(:name => term)
        current_term.embrace!
      end
  end

  def self.exists(term)
    return Term.count(:name.like => term.downcase) != 0
  end

  def self.find_terms(term)
    all(:fields => [:name], :name.like => '%'+term.downcase+'%', :order => [:fondness.desc],:limit => 10)
  end

  def name=(name)
    super(name.downcase)
  end

end
