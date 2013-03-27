#encoding: utf-8

class AbilityKey
  include DataMapper::Resource  
  property :id,             Serial
  property :edited,         DateTime, :required => true, :lazy => false
  property :name,           String, :required => true , :lazy => false

  has n, :ability_sliders, :through => Resource, :constraint => :destroy
end
