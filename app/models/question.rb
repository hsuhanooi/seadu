class Question < ActiveRecord::Base
  belongs_to :room
  has_many :votes
  
  QUESTION_STATES = ["new", "done"]
  
  validates :room_id, presence: true
  validates :content, presence: true
  validates :status, inclusion: {in: QUESTION_STATES}
  
  scope :most_recent, order("created_at DESC")
  scope :highest_rated, joins("LEFT OUTER JOIN votes ON questions.id = votes.question_id").order("count(votes.id) DESC").group("questions.id")
  
  after_initialize :init
  
  def up_votes
    votes.up
  end
  
  def pg_created_at
    "#{created_at.to_s(:db)}.#{sprintf("%06d", created_at.usec)}"
  end
  
  private
  def init
    self.status ||= 'new'
  end
end