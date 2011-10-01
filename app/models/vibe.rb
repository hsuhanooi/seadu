class Vibe < ActiveRecord::Base
  TYPE_MAP = ["bored", "good", "confused"]
  
  belongs_to :room
  
  def type
    TYPE_MAP[type_key]
  end
end