#encoding: utf-8

class AbilityKey
  include DataMapper::Resource  
  property :id,             Serial
  property :edited,         DateTime, :required => true

  has n, :ability_sliders, :through => Resource
  belongs_to :user
end
