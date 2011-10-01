class Room < ActiveRecord::Base
  belongs_to :teacher
  has_many :vibe
end