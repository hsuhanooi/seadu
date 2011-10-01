class Question < ActiveRecord::Base
  belongs_to :room
  has_many :votes
end