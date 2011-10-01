class Vibe < ActiveRecord::Base
  belongs_to :room
  
  VIBE_TYPES = ['bored', 'good', 'confused']
  
  scope :bored, where(vibe_type: 'bored')
  scope :good, where(vibe_type: 'good')
  scope :confused, where(vibe_type: 'confused')
  
  validates :room_id, presence: true
  validates :vibe_type, inclusion: {in: VIBE_TYPES}
  
  def self.generate_mock_data(room_id)
    room = Room.find(room_id)
    VIBE_TYPES.each{ |vibe|
      created = room.created_at + rand(3600) + 300
      (1..200).each{|i|
        v = Vibe.new(:vibe_type => vibe, :room_id => room_id, :created_at => created, :updated_at => created)
        v.save!
      }
    }
  end
end