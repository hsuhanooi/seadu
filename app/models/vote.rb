class Vote < ActiveRecord::Base
  belongs_to :question
  
  VOTE_TYPES = ['up']
  
  validates :room_id, presence: true
  validates :vote_type, inclusion: {in: VOTE_TYPES}
end