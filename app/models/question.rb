class Question < ActiveRecord::Base
  belongs_to :room
  has_many :votes
  
  QUESTION_STATES = ["new", "done"]
  
  validates :room_id, presence: true
  validates :content, presence: true
  validates :status, inclusion: {in: QUESTION_STATES}
  
  scope :from_room, lambda {|room_id| where(room_id: room_id).includes(:votes) }
  scope :after, lambda {|time| where('created_at > ?', Time.parse(time)) }
  scope :most_recent, where("status = 'new'").order("created_at DESC")
  scope :highest_rated, select("distinct on (questions.id) questions.*").joins("LEFT OUTER JOIN votes ON questions.id = votes.question_id").where("questions.status = 'new'").order("count(votes.id) DESC").group("questions.id")
  
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