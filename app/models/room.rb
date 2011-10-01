class Room < ActiveRecord::Base
  belongs_to :teacher
  has_many :vibe
  
  validates_uniqueness_of :name
  
  validates_length_of :name, :within => 1..255
end