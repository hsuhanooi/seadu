class Room < ActiveRecord::Base
  belongs_to :teacher
  has_many :vibes
  has_many :questions, include: :votes
  
  ROOM_STATES = ['active', 'expired']
  
  validates :status, inclusion: {in: ROOM_STATES}
  validate :name_is_unique
  validates :name, presence: true, length: 1..255
  validates :vibe_threshold, numericality: true
  validates :question_threshold, numericality: true
  
  after_initialize :init
  
  def bored_vibes
    vibes.bored
  end
  
  def good_vibes
    vibes.good
  end
  
  def confused_vibes
    vibes.confused
  end
  
  def active?
    status.eql?('active')
  end
  
  private
  def init
    self.status ||= 'active'
    self.vibe_threshold ||= 10
    self.question_threshold ||= 10
  end
  
  def name_is_unique
    if active? and Room.exists?(status: 'active', name: name)
      errors.add(:name, 'a room currently exists with this name')
    end
  end
end