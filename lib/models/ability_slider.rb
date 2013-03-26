#encoding: utf-8

class AbilitySlider
  include DataMapper::Resource  
  property :id,             Serial
  property :current_level,  Integer
  property :wanted_level,   Integer

  belongs_to :ability
end
