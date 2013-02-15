class Term
  include DataMapper::Resource

  property :name
  # A measurement of how much this term is embraced
  property :embracement, Integer :required => true, :default => 2
  # A measurement of how much this term is rejected
  property :ostracisity, Integer :required => true, :default => 0


  # Embrace the term
  def embrace
    #Use the formula 5*arctan((x-30)/10)/(pi/2)+5 
  end

  # Defame the term
  def ostracize

  end

end
