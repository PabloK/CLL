#encoding: utf-8

class AbilitySlider
  include DataMapper::Resource  
  property :id,             Serial
  property :current_level,  Integer
  property :target_level,   Integer

  belongs_to :ability
end
