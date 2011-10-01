class Question < ActiveRecord::Base
  belongs_to :room
  has_many :votes
  
  QUESTION_STATES = ["new", "done"]
  
  validates :room_id, presence: true
  validates :content, presence: true
  validates :status, inclusion: {in: QUESTION_STATES}
  
  scope :most_recent, order("created_at DESC")
  scope :highest_rated, joins(:votes).order("count(votes.id) DESC").group("questions.id")
  
  after_initialize :init
  
  private
  def init
    self.status ||= 'new'
  end
end