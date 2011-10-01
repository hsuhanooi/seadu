class Vibe < ActiveRecord::Base
  belongs_to :room
  
  VIBE_TYPES = ['bored', 'good', 'confused']
  
  scope :bored, where(vibe_type: 'bored')
  scope :good, where(vibe_type: 'good')
  scope :confused, where(vibe_type: 'confused')
  
  validates :room_id, presence: true
  validates :vibe_type, inclusion: {in: VIBE_TYPES}
end